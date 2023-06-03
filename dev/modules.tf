locals {
  default_public_key_path = "${path.cwd}/secrets/public.key"
  default_private_key_path = "${path.cwd}/secrets/private.key"
}

resource "oci_identity_compartment" "domain" {
  description = "domain"
  compartment_id = var.tenancy_ocid
  name        = var.domain
}

resource "oci_objectstorage_bucket" "mgmt" {
  compartment_id = oci_identity_compartment.domain.id
  name = "mgmt"
  namespace = var.user_namespace
  storage_tier = "Standard"
  access_type = "NoPublicAccess"
}

module "oci_cloud_core" {
  source = "../modules/oic_cloud_core"
  domain_compartment_id = oci_identity_compartment.domain.id
  env = var.env
  tenancy_id = var.tenancy_ocid
  vcn_display_name = lower(var.env)

  vcn_cidr_block = "172.${var.cidr_mid}.0.0/16"
  control_plane_subnet_cidr_block = "172.${var.cidr_mid}.16.0/20"
  worker_subnet_cidr_block = "172.${var.cidr_mid}.32.0/20"
  public_subnet_cidr_block = "172.${var.cidr_mid}.48.0/20"
  private_subnet_cidr_block = "172.${var.cidr_mid}.64.0/20"
}


module "kubernetes_cluster" {
  source = "../modules/oci_kubernetes_cluster"

  k8s_token = var.k8s_token
  ssh_public_key_path = local.default_public_key_path
  ssh_private_key_path = local.default_private_key_path

  domain_compartment_id = module.oci_cloud_core.domain_compartment_id
  env_compartment_id = module.oci_cloud_core.env_compartment_id

  control_plane_subnet_id = module.oci_cloud_core.control_plane_subnet_id
  worker_subnet_id = module.oci_cloud_core.worker_subnet_id
  public_subnet_id = module.oci_cloud_core.public_subnet_id
  private_subnet_id = module.oci_cloud_core.private_subnet_id

  control_plane_ip = "172.${var.cidr_mid}.16.5"

  tenancy_id = var.tenancy_ocid
  vcn_id = module.oci_cloud_core.vcn_id
}

module "infra_tools" {
  source = "../modules/infra_tools"
  cloudflare_api_token    = var.cloudflare_api_token
  public_subnet_id        = module.oci_cloud_core.public_subnet_id

  ssh_private_key_path    = local.default_private_key_path
  ssh_public_key_path     = local.default_public_key_path

  compartment_id          = oci_identity_compartment.domain.id
  vcn_id                  = module.oci_cloud_core.vcn_id

  domain                  = var.domain
  domain_endpoint         = var.domain_endpoint
  tool_server_domain      = var.tool_server_domain

  admin_email             = var.admin_email
  admin_password          = var.admin_password
  boot_volume_size_in_gbs = 50
}

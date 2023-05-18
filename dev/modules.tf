locals {
  default_public_key_path = "${path.cwd}/secrets/public.key"
  default_private_key_path = "${path.cwd}/secrets/private.key"
}

module "kubernetes_cluster" {
  source = "../modules/oci_kubernetes_cluster"

  env = lower(var.env)

  tenancy_id = var.tenancy_ocid
  vcn_display_name = lower(var.env)

  vcn_cidr_block = "172.${var.cidr_mid}.0.0/16"
  public_subnet_cidr_block = "172.${var.cidr_mid}.48.0/20"
  control_plane_subnet_cidr_block = "172.${var.cidr_mid}.16.0/20"
  worker_subnet_cidr_block = "172.${var.cidr_mid}.32.0/20"

  ssh_public_key_path = local.default_public_key_path
  ssh_private_key_path = local.default_private_key_path

  arm_master_count = var.control_plane_count
  arm_worker_count = var.worker_count

  arm_worker_shape_config = var.worker_shape
  worker_boot_volume_size_in_gbs = var.worker_volume
}

module "vpn_server" {
  source = "../modules/vpn_server"

  boot_volume_size_in_gbs = 50
  public_subnet_id        = module.kubernetes_cluster.public_subnet_id
  ssh_private_key_path    = local.default_private_key_path
  ssh_public_key_path     = local.default_public_key_path
  compartment_id          = module.kubernetes_cluster.compartment_id
  vcn_id                  = module.kubernetes_cluster.vcn_id
  vpn_server_fqdn         = var.vpn_server_fqdn
  admin_email             = var.vpn_server_admin_email
  vpn_server_password     = var.vpn_server_password
}

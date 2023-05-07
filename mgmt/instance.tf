locals {
  default_public_key_path = "${path.cwd}/secrets/public.key"
  default_private_key_path = "${path.cwd}/secrets/private.key"
}

module "kubernetes_cluster" {
  source = "../modules/oci_kubernetes_cluster"

  env = "mgmt"

  compartment_id = var.compartment_id
  vcn_display_name = "mgmt"

  vcn_cidr_block = "172.3.0.0/16"
  public_subnet_cidr_block = "172.3.48.0/20"
  control_plane_subnet_cidr_block = "172.3.16.0/20"
  worker_subnet_cidr_block = "172.3.32.0/20"

  ssh_public_key_path = local.default_public_key_path
  ssh_private_key_path = local.default_private_key_path

  arm_master_count = var.control_plane_count
  arm_worker_count = var.worker_count

  arm_worker_shape_config = var.worker_shape
  worker_boot_volume_size_in_gbs = var.worker_volume
}

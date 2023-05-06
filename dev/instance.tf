module "kubernetes_cluster" {
  source = "../modules/oci_kubernetes_cluster"

  compartment_id = data.oci_identity_compartment.admin.id
  node_availability_domain = data.oci_identity_availability_domain.main[0].name
  vcn_display_name = "prod"

  arm_master_count = var.control_plane_count
  arm_worker_count = var.worker_count

  ssh_public_key_path = var.ssh_public_key_path
  ssh_private_key_path = var.ssh_private_key_path

}

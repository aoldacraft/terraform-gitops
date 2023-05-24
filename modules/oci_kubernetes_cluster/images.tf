data "oci_core_images" "amd_nodes" {
  compartment_id = data.oci_identity_compartment.env.id
  shape = var.amd_node_shape
  operating_system = var.image_os_name
  operating_system_version = var.image_os_version
}

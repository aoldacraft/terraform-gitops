data "oci_core_images" "arm_nodes" {
  compartment_id = oci_identity_compartment.domain.id
  shape = var.arm_node_shape
  operating_system = var.image_os_name
  operating_system_version = var.image_os_version
}

data "oci_core_images" "amd_nodes" {
  compartment_id = oci_identity_compartment.domain.id
  shape = var.amd_node_shape
  operating_system = var.image_os_name
  operating_system_version = var.image_os_version
}

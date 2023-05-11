data "oci_core_images" "arm_nodes" {
  compartment_id = oci_identity_compartment.compute.id
  shape = var.arm_node_shape
  operating_system = var.arm_image_os_name
  operating_system_version = var.arm_image_os_version
}

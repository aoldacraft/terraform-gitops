resource "oci_core_instance" "control_plane" {
  compartment_id = var.compartment_id
  availability_domain = var.node_availability_domain

  count = var.arm_master_count
  display_name = "${var.control_plane_name}_${count.index + 1}"
  metadata = {
    ssh_authorized_keys = file(var.ssh_public_key_path)
  }
  create_vnic_details {
    subnet_id = oci_core_subnet.control_plane.id
    assign_public_ip = "false"
    nsg_ids = [
      oci_core_network_security_group.kubernetes_node.id,
      oci_core_network_security_group.kubernetes_control_plane.id
    ]
  }

  shape = var.arm_node_shape
  shape_config {
    ocpus = var.arm_master_shape_config.ocpus
    memory_in_gbs = var.arm_master_shape_config.memory_in_gbs
  }

  source_details {
    source_id   = var.arm_image_id
    source_type = "image"
    boot_volume_size_in_gbs = var.control_plane_boot_volume_size_in_gbs
  }

}

resource "oci_core_instance" "worker_node" {

  compartment_id = var.compartment_id
  availability_domain = var.node_availability_domain

  count = var.arm_worker_count
  display_name = "${var.worker_name}_${count.index + 1}"

  metadata = {
    ssh_authorized_keys = file(var.ssh_public_key_path)
    # 기타 메타데이터
  }
  create_vnic_details {
    subnet_id = oci_core_subnet.worker.id
    assign_public_ip = "false"
    nsg_ids = [
      oci_core_network_security_group.kubernetes_node.id
    ]
  }
  shape = var.arm_node_shape
  shape_config {
    ocpus = var.arm_worker_shape_config.ocpus
    memory_in_gbs = var.arm_worker_shape_config.memory_in_gbs
  }

  source_details {
    source_id   = var.arm_image_id
    source_type = "image"
    boot_volume_size_in_gbs = var.worker_boot_volume_size_in_gbs
  }

}
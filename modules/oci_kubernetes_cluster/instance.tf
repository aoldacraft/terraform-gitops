locals {
  MST_FIXED_IP = var.control_plane_ip
}

resource "oci_core_instance" "control_plane" {
  count = var.master_count

  compartment_id = data.oci_identity_compartment.env.id
  availability_domain = data.oci_identity_availability_domains.azs.availability_domains[count.index % length(data.oci_identity_availability_domains.azs.availability_domains)].name
  display_name = "${var.control_plane_name}_${count.index + 1}"
  metadata = {
    ssh_authorized_keys = file(var.ssh_public_key_path)
    user_data = base64encode(data.template_file.master_cloud_config.rendered)
  }
  create_vnic_details {
    subnet_id = data.oci_core_subnet.control_plane.id
    private_ip = local.MST_FIXED_IP
    assign_public_ip = "false"
    nsg_ids = [
      oci_core_network_security_group.kubernetes_node.id,
      oci_core_network_security_group.kubernetes_control_plane.id
    ]
  }

  shape = var.amd_node_shape
  shape_config {
    ocpus = var.master_shape_config.ocpus
    memory_in_gbs = var.master_shape_config.memory_in_gbs
    baseline_ocpu_utilization = var.master_shape_config.baseline
  }

  source_details {
    source_id   = data.oci_core_images.amd_nodes.images[0].id
    source_type = "image"
    boot_volume_size_in_gbs = var.control_plane_boot_volume_size_in_gbs
  }
}

## workers

resource "oci_core_instance_pool" "worker_nodes" {
  depends_on = [
    oci_core_instance.control_plane
  ]
  #Required
  compartment_id = data.oci_identity_compartment.env.id
  instance_configuration_id = oci_core_instance_configuration.worker_node_configuration.id
  placement_configurations {
    #Required
    availability_domain = data.oci_identity_availability_domains.azs.availability_domains[0].name
    primary_subnet_id = data.oci_core_subnet.worker.id
  }
  size = var.worker_pool_node_quantity
  display_name = var.worker_pool_name

  dynamic "load_balancers" {
    for_each = range(length(var.lb_listening_ports.*))
    content {
      backend_set_name = oci_network_load_balancer_backend_set.worker_node_set[load_balancers.key].name
      load_balancer_id = oci_network_load_balancer_network_load_balancer.main.id
      port             = var.lb_forwarding_ports[load_balancers.key]
      vnic_selection   = "PrimaryVnic"
    }
  }
}

resource "oci_core_instance_configuration" "worker_node_configuration" {

  compartment_id = data.oci_identity_compartment.env.id
  display_name = "${var.worker_pool_name}-configuration"
  instance_details {
    instance_type = "compute"
    launch_details {
      compartment_id = data.oci_identity_compartment.env.id
      metadata = {
        ssh_authorized_keys = file(var.ssh_public_key_path)
        user_data = base64encode(data.template_file.master_cloud_config.rendered)
      }
      create_vnic_details {
        subnet_id = data.oci_core_subnet.worker.id
        assign_public_ip = "false"
        nsg_ids = [
          oci_core_network_security_group.kubernetes_node.id
        ]
      }
      shape = var.amd_node_shape
      shape_config {
        baseline_ocpu_utilization = var.worker_shape_config.baseline
        ocpus = var.worker_shape_config.ocpus
        memory_in_gbs = var.worker_shape_config.memory_in_gbs
      }

      source_details {
        source_type = "image"
        image_id   = data.oci_core_images.amd_nodes.images[0].id
        boot_volume_size_in_gbs = var.worker_boot_volume_size_in_gbs
      }
    }
  }
}
locals {
  cidr_s = [
    oci_core_subnet.control_plane.cidr_block,
    oci_core_subnet.worker.cidr_block,
    oci_core_subnet.public.cidr_block
  ]
}

resource "oci_core_network_security_group" "kubernetes_control_plane" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.main_vcn.id
  display_name = "kubernetes_control_plane_sg"
}

resource "oci_core_network_security_group_security_rule" "kubernetes-api" {
  direction = "INGRESS"
  network_security_group_id = oci_core_network_security_group.kubernetes_control_plane.id
  protocol = "6" # TCP protocol
  source = "0.0.0.0/0"
  tcp_options {
    destination_port_range {
      min = 6443
      max = 6443
    }
  }
}

resource "oci_core_network_security_group_security_rule" "etcd-api" {
  count = length(local.cidr_s)
  direction = "INGRESS"
  network_security_group_id = oci_core_network_security_group.kubernetes_control_plane.id
  protocol = "6" # TCP protocol
  source = local.cidr_s[count.index]
  tcp_options {
    destination_port_range {
      min = 2379
      max = 2380
    }
  }
}

resource "oci_core_network_security_group_security_rule" "controller-api" {
  count = length(local.cidr_s)
  direction = "INGRESS"
  network_security_group_id = oci_core_network_security_group.kubernetes_control_plane.id
  protocol = "6" # TCP protocol
  source = local.cidr_s[count.index]
  tcp_options {
    destination_port_range {
      min = 10257
      max = 10257
    }
  }
}

resource "oci_core_network_security_group_security_rule" "scheduler-api" {
  count = length(local.cidr_s)
  direction = "INGRESS"
  network_security_group_id = oci_core_network_security_group.kubernetes_control_plane.id
  protocol = "6" # TCP protocol
  source = local.cidr_s[count.index]
  tcp_options {
    destination_port_range {
      min = 10259
      max = 10259
    }
  }
}


##########################################################################
##########################################################################
##########################################################################
##########################################################################


resource "oci_core_network_security_group" "kubernetes_node" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.main_vcn.id
  display_name = "kubernetes_node_sg"
}

resource "oci_core_network_security_group_security_rule" "ping" {
  direction                 = "INGRESS"
  network_security_group_id = oci_core_network_security_group.kubernetes_node.id
  protocol                  = "1" # ICMP protocol
  source = "0.0.0.0/0"
}

resource "oci_core_network_security_group_security_rule" "ssh" {
  direction = "INGRESS"
  network_security_group_id = oci_core_network_security_group.kubernetes_node.id
  protocol = "6" # TCP protocol
  source = "0.0.0.0/0"
  tcp_options {
    destination_port_range {
      min = 22
      max = 22
    }
  }
}

resource "oci_core_network_security_group_security_rule" "kubelet" {
  count = length(local.cidr_s)
  direction = "INGRESS"
  network_security_group_id = oci_core_network_security_group.kubernetes_node.id
  protocol = "6" # TCP protocol
  source = local.cidr_s[count.index]
  tcp_options {
    destination_port_range {
      min = 10250
      max = 10250
    }
  }
}

resource "oci_core_network_security_group_security_rule" "nodeport_tcp" {
  count = length(local.cidr_s)
  direction = "INGRESS"
  network_security_group_id = oci_core_network_security_group.kubernetes_node.id
  protocol = "6" # TCP protocol
  source = local.cidr_s[count.index]
  tcp_options {
    destination_port_range {
      min = 30000
      max = 32767
    }
  }
}

resource "oci_core_network_security_group_security_rule" "nodeport_udp" {
  count = length(local.cidr_s)
  direction = "INGRESS"
  network_security_group_id = oci_core_network_security_group.kubernetes_node.id
  protocol = "17" # TCP protocol
  source = local.cidr_s[count.index]
  udp_options {
    destination_port_range {
      min = 30000
      max = 32767
    }
  }
}

resource "oci_core_network_security_group_security_rule" "calico_bgp" {
  count = length(local.cidr_s)
  direction = "INGRESS"
  network_security_group_id = oci_core_network_security_group.kubernetes_node.id
  protocol = "6" # TCP protocol
  source = local.cidr_s[count.index]
  tcp_options {
    destination_port_range {
      min = 179
      max = 179
    }
  }
}

resource "oci_core_network_security_group_security_rule" "calico_vxlan" {
  count = length(local.cidr_s)
  direction = "INGRESS"
  network_security_group_id = oci_core_network_security_group.kubernetes_node.id
  protocol = "17" # TCP protocol
  source = local.cidr_s[count.index]
  udp_options {
    destination_port_range {
      min = 4789
      max = 4789
    }
  }
}

resource "oci_core_network_security_group_security_rule" "calico_typha" {
  count = length(local.cidr_s)
  direction = "INGRESS"
  network_security_group_id = oci_core_network_security_group.kubernetes_node.id
  protocol = "6" # TCP protocol
  source = local.cidr_s[count.index]
  tcp_options {
    destination_port_range {
      min = 5473
      max = 5473
    }
  }
}

resource "oci_core_network_security_group_security_rule" "calico_wireguard_ipv4" {
  count = length(local.cidr_s)
  direction = "INGRESS"
  network_security_group_id = oci_core_network_security_group.kubernetes_node.id
  protocol = "17" # TCP protocol
  source = local.cidr_s[count.index]
  udp_options {
    destination_port_range {
      min = 51820
      max = 51820
    }
  }
}

resource "oci_core_network_security_group" "vpn" {
  compartment_id = data.oci_identity_compartment.vpn.id
  vcn_id         = data.oci_core_vcn.vpn.vcn_id
  display_name = "vpn-server"
}

resource "oci_core_network_security_group_security_rule" "ping" {
  direction                 = "INGRESS"
  network_security_group_id = oci_core_network_security_group.vpn.id
  protocol                  = "1" # ICMP protocol
  source = "0.0.0.0/0"
}

resource "oci_core_network_security_group_security_rule" "ssh" {
  direction = "INGRESS"
  network_security_group_id = oci_core_network_security_group.vpn.id
  protocol = "6" # TCP protocol
  source = "0.0.0.0/0"
  tcp_options {
    destination_port_range {
      min = 22
      max = 22
    }
  }
}

resource "oci_core_network_security_group_security_rule" "http" {
  direction = "INGRESS"
  network_security_group_id = oci_core_network_security_group.vpn.id
  protocol = "6" # TCP protocol
  source = "0.0.0.0/0"
  tcp_options {
    destination_port_range {
      min = 80
      max = 80
    }
  }
}

resource "oci_core_network_security_group_security_rule" "https" {
  direction = "INGRESS"
  network_security_group_id = oci_core_network_security_group.vpn.id
  protocol = "6" # TCP protocol
  source = "0.0.0.0/0"
  tcp_options {
    destination_port_range {
      min = 443
      max = 443
    }
  }
}

resource "oci_core_network_security_group_security_rule" "wireguard-web" {
  direction = "INGRESS"
  network_security_group_id = oci_core_network_security_group.vpn.id
  protocol = "6" # TCP protocol
  source = "0.0.0.0/0"
  tcp_options {
    destination_port_range {
      min = 51821
      max = 51821
    }
  }
}


resource "oci_core_network_security_group_security_rule" "wireguard" {
  direction = "INGRESS"
  network_security_group_id = oci_core_network_security_group.vpn.id
  protocol = "17" # UDP protocol
  source = "0.0.0.0/0"
  udp_options {
    destination_port_range {
      min = 51820
      max = 51820
    }
  }
}
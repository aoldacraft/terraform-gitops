locals{
  lb_shape_free_tier = "10Mbps-Micro"
  lb_shape_default = "flexible"
}

resource "oci_network_load_balancer_network_load_balancer" "net_ingress_main" {
  compartment_id = var.compartment_id
  display_name = var.lb_name
  subnet_id = oci_core_subnet.public.id
  is_private = var.env == "prod" ? false : true
  is_preserve_source_destination = true
}

/*
Listener
*/
resource "oci_network_load_balancer_listener" "ingress_main" {
  #Required
  default_backend_set_name = oci_network_load_balancer_backend_set.ingress_main.name
  name = "main"
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.net_ingress_main.id
  port = var.lb_listening_ports[0]
  protocol = "TCP_AND_UDP"
}

/*
Backend
*/
resource "oci_network_load_balancer_backend_set" "ingress_main" {
  name = "backend"
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.net_ingress_main.id
  policy = "FIVE_TUPLE"
  health_checker {
    protocol = "TCP"
  }
}

resource "oci_network_load_balancer_backend" "worker" {
  #Required
  count = length(oci_core_instance.worker_node.*)
  backend_set_name = oci_network_load_balancer_backend_set.ingress_main.name
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.net_ingress_main.id
  port = var.lb_forwarding_ports[0]

  #Optional
  ip_address = oci_core_instance.worker_node[count.index].private_ip
  is_backup = false
  name = oci_core_instance.worker_node[count.index].display_name
}
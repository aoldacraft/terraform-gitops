locals{
  lb_shape_free_tier = "10Mbps-Micro"
  lb_shape_default = "flexible"
}

resource "oci_network_load_balancer_network_load_balancer" "main" {
  compartment_id = data.oci_identity_compartment.env.id
  display_name = var.lb_name
  subnet_id = data.oci_core_subnet.public.id
  is_private = var.lb_is_private
  is_preserve_source_destination = true
}

/*
Listener
*/
resource "oci_network_load_balancer_listener" "main" {
  count = length(var.lb_listening_ports.*)
  #Required
  default_backend_set_name = oci_network_load_balancer_backend_set.worker_node_set.0.name
  name = "main"
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.main.id
  port = var.lb_listening_ports[count.index]
  protocol = "TCP_AND_UDP"
}

/*
Backend
*/
resource "oci_network_load_balancer_backend_set" "worker_node_set" {
  count = length(var.lb_listening_ports.*)
  name = "backend-${count.index}"
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.main.id
  policy = "FIVE_TUPLE"
  health_checker {
    protocol = "TCP"
  }
}
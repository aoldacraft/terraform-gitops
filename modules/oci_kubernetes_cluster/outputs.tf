output "bastion_control_plane_session" {
  value = oci_bastion_session.cp_session
}

#compartment
output "compute_compartment" {
  value = oci_identity_compartment.compute.id
}
output "network_compartment" {
  value = oci_identity_compartment.network.id
}

#network
output "vcn_id" {
  value = oci_core_vcn.main_vcn.id
}

output "public_subnet_id" {
  value = oci_core_subnet.public.id
}

output "control_plane_subnet_id" {
  value = oci_core_subnet.control_plane.id
}

output "worker_subnet_id" {
  value = oci_core_subnet.worker.id
}

output "inventory_render" {
  value = local.inventory
}
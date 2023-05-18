output "bastion_control_plane_session" {
  value = oci_bastion_session.cp_session
}

#compartment
output "compartment_id" {
  value = oci_identity_compartment.project.id
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
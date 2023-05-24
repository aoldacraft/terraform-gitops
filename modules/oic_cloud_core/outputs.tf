output "vcn_id" {
  value = oci_core_vcn.main_vcn.id
}

output "domain_compartment_id" {
  value = data.oci_identity_compartment.domain.id
}
output "env_compartment_id" {
  value = oci_identity_compartment.env.id
}

output "control_plane_subnet_id" {
  value = oci_core_subnet.control_plane.id
}
output "worker_subnet_id" {
  value = oci_core_subnet.worker.id
}
output "public_subnet_id" {
  value = oci_core_subnet.public.id
}
output "private_subnet_id" {
  value = oci_core_subnet.private.id
}
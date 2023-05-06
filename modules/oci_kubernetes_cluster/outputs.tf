output "control_plane_bastion" {
  value = oci_bastion_bastion.control_plane_bastion
}

output "bastion_control_plane_session" {
  value = oci_bastion_session.cp_session
}

output "inventory_render" {
  value = local.inventory
}
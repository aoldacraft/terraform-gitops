output "bastion" {
  value = module.kubernetes_cluster.control_plane_bastion
}

output "bastion_session" {
  value = module.kubernetes_cluster.bastion_control_plane_session
}

output "inventory" {
  value = module.kubernetes_cluster.inventory_render
}

#core
variable "compartment_id" {
  type = string
}

# metadata
variable "ssh_public_key_path" {
  type = string
  default = "~/.ssh/id_rsa.pub"
}
variable "ssh_private_key_path" {
  type = string
  default = "~/.ssh/id_rsa.key"
}

# control_plane
variable "control_plane_count" {
  type = number
  default = 1
}

# worker_instance
variable "worker_count" {
  type = number
  default = 1
}
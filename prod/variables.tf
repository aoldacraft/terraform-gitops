#core
variable "compartment_id" {
  type = string
}

# metadata
variable "ssh_public_key_path" {
  type = string
  default = "./secrets/public.key"
}
variable "ssh_private_key_path" {
  type = string
  default = "./secrets/private.key"
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
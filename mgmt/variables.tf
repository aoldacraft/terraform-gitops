#core
variable "compartment_id" {
  type = string
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

variable "worker_volume" {
  type = number
  default = 150
}

variable "worker_shape" {
  default = {
    ocpus = 2
    memory_in_gbs = 20
  }
}
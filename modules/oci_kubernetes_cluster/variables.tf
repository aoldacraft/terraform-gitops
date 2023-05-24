variable "tenancy_id" {
  type = string
}

variable "domain_compartment_id" {
  type = string
}
variable "env_compartment_id" {
  type = string
}

########
# Loadbalancer Info
########
variable "lb_is_private" {
  type = bool
  default = true
}

variable "lb_name" {
  type = string
  default = "main"
}

variable "lb_listening_ports" {
  type = list(number)
  default = [25565]
}

variable "lb_forwarding_ports" {
  type = list(number)
  default = [30000]
}

########
# Network
########

variable "vcn_id" {
  type = string
}

variable "control_plane_subnet_id" {
  type = string
}
variable "worker_subnet_id" {
  type = string
}
variable "public_subnet_id" {
  type = string
}
variable "private_subnet_id" {
  type = string
}

########
# Auth Info
########

variable "ssh_public_key_path" {
  type = string
  default = "~/.ssh/id_rsa_pub.key"
}

variable "ssh_private_key_path" {
  type = string
  default = "~/.ssh/id_rsa.key"
}

########
# Node Info
########

variable "control_plane_name" {
  type = string
  default = "control_plane"
}

variable "worker_pool_name" {
  type = string
  default = "workers"
}

variable "worker_boot_volume_size_in_gbs" {
  type = number
  default = 50
}

variable "control_plane_boot_volume_size_in_gbs" {
  type = number
  default = 50
}

variable "master_count" {
  type = number
  default = 1
}

variable "worker_pool_node_quantity" {
  type = number
  default = 1
}

variable "image_os_name" {
  type = string
  default = "Canonical Ubuntu"
}

variable "image_os_version" {
  type = string
  default = "20.04"
}

variable "amd_node_shape" {
  type = string
  default = "VM.Standard.E4.Flex"
}
variable "master_shape_config" {
  default = {
    ocpus = 2
    memory_in_gbs = 4
    baseline = "BASELINE_1_8"
  }
}
variable "worker_shape_config" {
  default = {
    ocpus = 2
    memory_in_gbs = 16
    baseline = "BASELINE_1_8"
  }
}


variable "tenancy_id" {
  type = string
}

variable "domain" {
  type = string
}

variable "env" {
  type = string
  default = "prod"
}

########
# Loadbalancer Info
########

variable "lb_name" {
  type = string
  default = "ingress_main"
}

variable "lb_listening_ports" {
  type = list(number)
  default = [443]
}

variable "lb_forwarding_ports" {
  type = list(number)
  default = [30000]
}

########
# Network
########

variable "vcn_display_name" {
  type = string
  default = "oci_k8s_vpc"
}

variable "vcn_cidr_block" {
  type = string
}

variable "control_plane_subnet_cidr_block" {
  type = string
}

variable "control_plane_subnet_display_name" {
  type = string
  default = "control_plane"
}

variable "worker_subnet_cidr_block" {
  type = string
}

variable "worker_subnet_display_name" {
  type = string
  default = "worker"
}

variable "public_subnet_cidr_block" {
  type = string
}

variable "public_subnet_display_name" {
  type = string
  default = "public"
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

variable "arm_node_shape" {
  type = string
  default = "VM.Standard.A1.Flex"
}
variable "amd_node_shape" {
  type = string
  default = "VM.Standard.E4.Flex"
}
variable "image_os_name" {
  type = string
  default = "Canonical Ubuntu"
}

variable "image_os_version" {
  type = string
  default = "20.04"
}

variable "master_shape_config" {
  default = {
    ocpus = 2
    memory_in_gbs = 4
  }
}
variable "worker_shape_config" {
  default = {
    ocpus = 2
    memory_in_gbs = 16
    baseline = "BASELINE_1_8"
  }
}


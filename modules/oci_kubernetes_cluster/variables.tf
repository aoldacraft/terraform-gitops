variable "compartment_id" {
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
  default = [80]
}

variable "lb_forwarding_ports" {
  type = list(number)
  default = [31000]
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
  default = "172.1.0.0/16"
}

variable "control_plane_subnet_cidr_block" {
  type = string
  default = "172.1.16.0/20"
}

variable "control_plane_subnet_display_name" {
  type = string
  default = "control_plane"
}

variable "worker_subnet_cidr_block" {
  type = string
  default = "172.1.32.0/20"
}

variable "worker_subnet_display_name" {
  type = string
  default = "worker"
}

variable "public_subnet_cidr_block" {
  type = string
  default = "172.1.48.0/20"
}

variable "public_subnet_display_name" {
  type = string
  default = "public"
}

variable "node_availability_domain" {
  type = string
}

########
# Auth Info
########

variable "ssh_public_key_path" {
  type = string
  default = "~/.ssh/id_rsa.pub"
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

variable "worker_name" {
  type = string
  default = "worker"
}

variable "worker_boot_volume_size_in_gbs" {
  type = number
  default = 50
}

variable "control_plane_boot_volume_size_in_gbs" {
  type = number
  default = 50
}

variable "arm_master_count" {
  type = number
  default = 1
}

variable "arm_worker_count" {
  type = number
  default = 1
}

variable "arm_node_shape" {
  type = string
  default = "VM.Standard.A1.Flex"
}

variable "arm_image_id" {
  type = string
  default = "ocid1.image.oc1.ap-chuncheon-1.aaaaaaaajq5kz4shjxerevwal6ky4b6xn5vpct62mneuoiawtkb2lt6t2rdq"
  description = "Canonical-Ubuntu-20.04-aarch64-2023.02.15-0"
}

variable "arm_master_shape_config" {
  default = {
    ocpus = 2
    memory_in_gbs = 4
  }
}

variable "arm_worker_shape_config" {
  default = {
    ocpus = 2
    memory_in_gbs = 8
  }
}

variable "compartment_id" {
  type = string
}

variable "vcn_id" {
  type = string
}

variable "public_subnet_id" {
  type = string
}

variable "ssh_public_key_path" {
  type = string
}
variable "ssh_private_key_path" {
  type = string
}

variable "domain" {
  type = string
}

variable "tool_server_domain" {
  type = string
}

variable "admin_email" {
  type = string
}
variable "vpn_server_password" {
  type = string
}

variable "boot_volume_size_in_gbs" {
  type = number
}

variable "node_shape" {
  type = string
  default = "VM.Standard.A1.Flex"
}
variable "shape_config" {
  default = {
    ocpus = 4
    memory_in_gbs = 24
  }
}
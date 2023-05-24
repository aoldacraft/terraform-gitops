variable "tenancy_id" {
  type = string
}

variable "domain_compartment_id" {
  type = string
}

variable "env" {
  type = string
}

########
# Network
########

variable "vcn_display_name" {
  type = string
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

variable "private_subnet_cidr_block" {
  type = string
}

variable "private_subnet_display_name" {
  type = string
  default = "private"
}
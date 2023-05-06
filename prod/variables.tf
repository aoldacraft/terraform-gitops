#core
variable "compartment_id" {
  type = string
}
variable "tenancy_ocid" {
  type = string
}
variable "user_ocid" {
  type = string
}
variable "private_key_path" {
  type = string
}
variable "fingerprint" {
  type = string
}
variable "region" {
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
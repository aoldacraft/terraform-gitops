#core
variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "region" {}
variable "domain" {type = string}
variable "env" {type = string}
variable "cidr_mid" {type = string}

# control_plane
variable "control_plane_count" {
  type = number
  default = 1
}

variable "k8s_token" {
  type = string
  default = "asd21e1dqw.adjqwdji189d1wq21"
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

# dev only
variable "user_namespace" {
  type = string
}
variable "tool_server_domain" {
  type = string
}
variable "domain_endpoint" {
  type = string
}
variable "admin_email" {
  type = string
}
variable "admin_password" {
  type = string
}

variable "cloudflare_api_token" {
  type = string
}
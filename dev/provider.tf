locals {
  provider_oci_key_file_path = "${path.cwd}/secrets/oci_private.pem"
}

terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.0"
    }
  }
}

provider "oci" {
  tenancy_ocid = var.tenancy_ocid
  user_ocid = var.user_ocid
  private_key_path= local.provider_oci_key_file_path
  fingerprint = var.fingerprint
  region = var.region
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

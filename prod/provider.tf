terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
    }
  }
}

provider "oci" {
  tenancy_ocid = "<tenancy-ocid>"
  user_ocid = "<user-ocid>"
  private_key_path = "<rsa-private-key-path>"
  fingerprint = "<fingerprint>"
  region = "<region-identifier>"
}
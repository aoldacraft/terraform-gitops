data "oci_identity_tenancy" "root" {
  tenancy_id = var.tenancy_id
}

resource "oci_identity_compartment" "vpn" {
  compartment_id = data.oci_identity_tenancy.root.tenancy_id
  description = "vpn group compartment"
  name        = "vpn"
}
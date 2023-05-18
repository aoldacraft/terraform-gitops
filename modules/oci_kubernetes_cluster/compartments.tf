data "oci_identity_tenancy" "root" {
  tenancy_id = var.tenancy_id
}

resource "oci_identity_compartment" "project" {
  compartment_id = data.oci_identity_tenancy.root.id
  enable_delete = true
  description = "subroot compartment"
  name        = var.env
}
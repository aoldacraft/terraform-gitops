data "oci_identity_tenancy" "root" {
  tenancy_id = var.tenancy_id
}

resource "oci_identity_compartment" "compute" {
  compartment_id = data.oci_identity_tenancy.root.id
  description = "compute compartment"
  name        = "compute"
}

resource "oci_identity_compartment" "network" {
  compartment_id = data.oci_identity_tenancy.root.id
  description = "network compartment"
  name        = "network"
}
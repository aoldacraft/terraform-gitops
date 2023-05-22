data "oci_identity_tenancy" "root" {
  tenancy_id = var.tenancy_id
}

resource "oci_identity_compartment" "domain" {
  compartment_id = data.oci_identity_tenancy.root.tenancy_id
  enable_delete = true
  description = "domain"
  name        = var.domain
}

resource "oci_identity_compartment" "project" {
  compartment_id = oci_identity_compartment.domain.id
  enable_delete = true
  description = "env compartment"
  name        = var.env
}
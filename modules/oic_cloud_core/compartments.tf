data "oci_identity_compartment" "domain" {
  id = var.domain_compartment_id
}

resource "oci_identity_compartment" "env" {
  compartment_id = data.oci_identity_compartment.domain.id
  enable_delete = true
  description = "env compartment"
  name        = var.env
}
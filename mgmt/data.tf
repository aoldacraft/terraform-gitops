data "oci_identity_compartment" "admin" {
  id = var.compartment_id
}

data "oci_identity_availability_domain" "main" {
  count = 1
  compartment_id = data.oci_identity_compartment.admin.id
  ad_number = count.index + 1
  # id = "jEnN:AP-CHUNCHEON-1-AD-1"
}
data "oci_core_vcn" "vpn" {
  vcn_id = var.vcn_id
}

data "oci_identity_availability_domains" "azs" {
  compartment_id = data.oci_identity_compartment.vpn.id
}

data "oci_core_subnet" "public" {
  subnet_id = var.public_subnet_id
}
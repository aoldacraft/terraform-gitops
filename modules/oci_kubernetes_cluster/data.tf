data "oci_identity_availability_domains" "azs" {
  compartment_id = data.oci_identity_compartment.domain.id
}

data "oci_core_vcn" "prov" {
  vcn_id = var.vcn_id
}
data "oci_identity_compartment" "domain" {
  id = var.domain_compartment_id
}
data "oci_identity_compartment" "env" {
  id = var.env_compartment_id
}


data "oci_core_subnet" "public" {
  subnet_id = var.public_subnet_id
}
data "oci_core_subnet" "control_plane" {
  subnet_id = var.control_plane_subnet_id
}
data "oci_core_subnet" "worker" {
  subnet_id = var.worker_subnet_id
}
data "oci_core_subnet" "private" {
  subnet_id = var.private_subnet_id
}
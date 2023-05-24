resource "oci_core_vcn" "main_vcn" {
  compartment_id = oci_identity_compartment.env.id

  cidr_block = var.vcn_cidr_block
  display_name = var.vcn_display_name
  dns_label = var.vcn_display_name
}

resource "oci_core_subnet" "control_plane" {
  cidr_block = var.control_plane_subnet_cidr_block
  compartment_id = oci_identity_compartment.env.id
  vcn_id = oci_core_vcn.main_vcn.id
  display_name = var.control_plane_subnet_display_name

  prohibit_public_ip_on_vnic = true
  route_table_id = oci_core_route_table.nat.id
}

resource "oci_core_subnet" "worker" {
  cidr_block = var.worker_subnet_cidr_block
  compartment_id = oci_identity_compartment.env.id
  vcn_id = oci_core_vcn.main_vcn.id
  display_name = var.worker_subnet_display_name

  prohibit_public_ip_on_vnic = true
  route_table_id = oci_core_route_table.nat.id
}

resource "oci_core_subnet" "public" {
  cidr_block = var.public_subnet_cidr_block
  compartment_id = oci_identity_compartment.env.id
  vcn_id = oci_core_vcn.main_vcn.id
  display_name = var.public_subnet_display_name

  prohibit_internet_ingress = false
  prohibit_public_ip_on_vnic = false
  route_table_id = oci_core_route_table.public.id
}

resource "oci_core_subnet" "private" {
  cidr_block = var.private_subnet_cidr_block
  compartment_id = oci_identity_compartment.env.id
  vcn_id = oci_core_vcn.main_vcn.id
  display_name = var.private_subnet_display_name

  prohibit_public_ip_on_vnic = true
  route_table_id = oci_core_route_table.nat.id
}
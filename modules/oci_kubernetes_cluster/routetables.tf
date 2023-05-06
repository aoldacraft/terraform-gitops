resource "oci_core_route_table" "public" {
  compartment_id = var.compartment_id
  vcn_id = oci_core_vcn.main_vcn.id

  display_name = "public_route_table"
  route_rules {
    network_entity_id = oci_core_internet_gateway.public_igw.id

    description = "route to public internet"
    destination = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
  }
}

resource "oci_core_route_table" "nat" {
  compartment_id = var.compartment_id
  vcn_id = oci_core_vcn.main_vcn.id

  display_name = "nat_route_table"
  route_rules {
    network_entity_id = oci_core_nat_gateway.nat_gw.id

    description = "route to public internet"
    destination = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
  }
}
resource "oci_core_internet_gateway" "public_igw" {
  #Required
  compartment_id = var.compartment_id
  vcn_id = oci_core_vcn.main_vcn.id

  #Optional
  enabled = true
  display_name = "public_igw"
  //route_table_id = oci_core_route_table.public.id
}

resource "oci_core_nat_gateway" "nat_gw" {
  #Required
  compartment_id = var.compartment_id
  vcn_id = oci_core_vcn.main_vcn.id

  #Optional
  block_traffic = false
  display_name = "public_natgw"
  //route_table_id = oci_core_route_table.nat.id
}

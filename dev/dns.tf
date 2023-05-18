locals {
  dns_compartment_id = var.tenancy_ocid
}

resource "oci_dns_view" "core" {
  #Required
  compartment_id = local.dns_compartment_id

  display_name = "core-dns"
  scope        = "PRIVATE"
}

resource "oci_dns_zone" "private" {
  #Required
  compartment_id = local.dns_compartment_id
  name = var.private_dns_name
  zone_type = "PRIMARY"
  scope = "PRIVATE"
  view_id = oci_dns_view.core.id
}

resource "oci_dns_resolver" "core" {
  resolver_id = data.oci_core_vcn_dns_resolver_association.main_dns.dns_resolver_id
  display_name = "private-dns"
  scope       = "PRIVATE"
  attached_views {
    view_id = oci_dns_view.core.id
  }
}
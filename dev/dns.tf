locals {
  dns_compartment_id = module.kubernetes_cluster.domain_compartment_id
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
  name = "${var.domain}.in"
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

/*
resource "oci_dns_rrset" "worker_record" {
  #Required
  domain = var.rrset_domain
  rtype = var.rrset_rtype
  zone_name_or_id = oci_dns_zone.test_zone.id

  #Optional
  compartment_id = var.compartment_id
  items {
    #Required
    domain = var.rrset_items_domain
    rdata = var.rrset_items_rdata
    rtype = var.rrset_items_rtype
    ttl = var.rrset_items_ttl
  }
  scope = var.rrset_scope
  view_id = oci_dns_view.test_view.id
}
*/
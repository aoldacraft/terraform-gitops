data "oci_core_vcn" "main" {
  vcn_id = module.kubernetes_cluster.vcn_id
}

data "oci_core_vcn_dns_resolver_association" "main_dns" {
  vcn_id = data.oci_core_vcn.main.vcn_id
}
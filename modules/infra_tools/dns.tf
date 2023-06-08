data "cloudflare_zone" "infra_domain" {
  name = var.tool_server_domain
}

resource "cloudflare_record" "wildcard" {
  zone_id = data.cloudflare_zone.infra_domain.id
  name    = "*"
  value   = oci_core_instance.public_server.public_ip
  type    = "A"
  proxied = false
}

resource "cloudflare_record" "infra" {
  zone_id = data.cloudflare_zone.infra_domain.id
  name    = "infra"
  value   = oci_core_instance.public_server.private_ip
  type    = "A"
  proxied = false
}


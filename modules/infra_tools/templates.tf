locals {
  vpn_server_endpoint = "vpn.${var.tool_server_domain}"
  ldap_endpoint = "auth.${var.tool_server_domain}"
  harbor_endpoint = "cr.${var.tool_server_domain}"
  jenkins_endpoint = "jenkins.${var.tool_server_domain}"
  argocd_endpoint = "argocd.${var.tool_server_domain}"
}

data "template_file" "docker-compose" {
  template = file("${path.module}/templates/docker-compose.yaml")
  vars = {
    DOMAIN = var.domain
    VPN_SERVER_ENDPOINT = local.vpn_server_endpoint
    LDAP_ENDPOINT = local.ldap_endpoint
    PUBLIC_IP = oci_core_instance.public_server.public_ip
    PASSWORD = var.vpn_server_password
  }
}

data "template_file" "nginx-conf" {
  template = file("${path.module}/templates/nginx.conf")
  vars = {
    VPN_SERVER_ENDPOINT = local.vpn_server_endpoint
  }
}

data "template_file" "install-vpn-server" {
  template = file("${path.module}/templates/install-vpn-server.sh")
  vars = {
    PUBLIC_IP = oci_core_instance.public_server.public_ip
    VPN_SERVER_ENDPOINT = local.vpn_server_endpoint
    ADMIN_EMAIL = var.admin_email
  }
}
locals {
  dev_endpoint = var.tool_server_domain
  gateway_endpoint = "npm.${var.tool_server_domain}"
  vpn_endpoint = "vpn.${var.tool_server_domain}"
  ldap_endpoint = "ldap.${var.tool_server_domain}"
  jenkins_endpoint = "jenkins.${var.tool_server_domain}"
  argocd_endpoint = "argocd.${var.tool_server_domain}"
  harbor_endpoint = "harbor.${var.tool_server_domain}"
}

data "template_file" "docker-compose" {
  template = file("${path.module}/templates/docker-compose.yaml")
  vars = {
    DOMAIN = var.domain
    DOMAIN_ENDPOINT = var.domain_endpoint
    VPN_ENDPOINT = local.vpn_endpoint
    LDAP_ENDPOINT = local.ldap_endpoint
    EMAIL = var.admin_email
    PASSWORD = var.admin_password
  }
}

data "template_file" "init-docker" {
  template = file("${path.module}/templates/init-docker.sh")
}

data "template_file" "init-server" {
  template = file("${path.module}/templates/init-server.sh")
  vars = {
    VPN_SERVER_ENDPOINT = local.vpn_endpoint
    ADMIN_EMAIL = var.admin_email
  }
}

data "template_file" "init-proxy" {
  template = file("${path.module}/templates/init-proxy.sh")
  vars = {
    ROOT_EMAIL = var.admin_email
    CLOUDFLARE_TOKEN = var.cloudflare_api_token
    DEV_ENDPOINT = local.dev_endpoint
    GATEWAY_ENDPOINT = local.gateway_endpoint
    VPN_ENDPOINT = local.vpn_endpoint
    LDAP_ENDPOINT = local.ldap_endpoint
    JENKINS_ENDPOINT = local.jenkins_endpoint
    ARGOCD_ENDPOINT = local.argocd_endpoint
    HARBOR_ENDPOINT = local.harbor_endpoint
  }
}

data "template_file" "cloud_config" {
  template = <<YAML
#cloud-config
write_files:
- content: |
    ${indent(4, data.template_file.docker-compose.rendered)}
  path: "/tmp/docker-compose.yaml"
  owner: root:root
  permissions: '0755'
- content: |
    ${indent(4, data.template_file.init-docker.rendered)}
  path: "/tmp/init-docker.sh"
  owner: root:root
  permissions: '0755'
- content: |
    ${indent(4, data.template_file.init-server.rendered)}
  path: "/tmp/init-server.sh"
  owner: root:root
  permissions: '0755'
- content: |
    ${indent(4, data.template_file.init-proxy.rendered)}
  path: "/tmp/init-proxy.sh"
  owner: root:root
  permissions: '0755'
runcmd:
 - bash /tmp/init-docker.sh
 - bash /tmp/init-server.sh
 - bash /tmp/init-proxy.sh
YAML
}
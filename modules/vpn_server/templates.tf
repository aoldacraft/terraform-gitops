data "template_file" "docker-compose" {
  template = file("${path.module}/templates/docker-compose.yaml")
  vars = {
    VPN_SERVER_ENDPOINT = var.vpn_server_fqdn
    PASSWORD = var.vpn_server_password
  }
}

data "template_file" "nginx-conf" {
  template = file("${path.module}/templates/wg-easy.conf")
  vars = {
    VPN_SERVER_ENDPOINT = var.vpn_server_fqdn
  }
}
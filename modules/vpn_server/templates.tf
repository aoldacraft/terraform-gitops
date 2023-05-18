data "template_file" "docker-compose" {
  template = file("${path.module}/templates/docker-compose.yaml")
  vars = {
    VPN_SERVER_ENDPOINT = var.vpn_server_fqdn
    PUBLIC_IP = oci_core_instance.vpn_server.public_ip
    PASSWORD = var.vpn_server_password
  }
}

data "template_file" "nginx-conf" {
  template = file("${path.module}/templates/wg-easy.conf")
  vars = {
    VPN_SERVER_ENDPOINT = var.vpn_server_fqdn
  }
}

data "template_file" "install-vpn-server" {
  template = file("${path.module}/templates/install-vpn-server.sh")
  vars = {
    PUBLIC_IP = oci_core_instance.vpn_server.public_ip
    VPN_SERVER_ENDPOINT = var.vpn_server_fqdn
    ADMIN_EMAIL = var.admin_email
  }
}
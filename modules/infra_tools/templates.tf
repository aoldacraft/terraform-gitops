data "template_file" "docker-compose" {
  template = file("${path.module}/templates/docker-compose.yaml")
  vars = {
    VPN_SERVER_ENDPOINT = var.tool_server_domain
    PUBLIC_IP = oci_core_instance.public_server.public_ip
    PASSWORD = var.vpn_server_password
  }
}

data "template_file" "nginx-conf" {
  template = file("${path.module}/templates/nginx.conf")
  vars = {
    VPN_SERVER_ENDPOINT = var.tool_server_domain
  }
}

data "template_file" "install-vpn-server" {
  template = file("${path.module}/templates/install-vpn-server.sh")
  vars = {
    PUBLIC_IP = oci_core_instance.public_server.public_ip
    VPN_SERVER_ENDPOINT = var.tool_server_domain
    ADMIN_EMAIL = var.admin_email
  }
}
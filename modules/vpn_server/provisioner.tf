resource "null_resource" "provisioning" {
  triggers = {
    vm = oci_core_instance.vpn_server.id
  }
  connection {
    type = "ssh"
    host = oci_core_instance.vpn_server.public_ip
    user = "ubuntu"
    private_key = file(var.ssh_private_key_path)
  }
  provisioner "file" {
    content = data.template_file.docker-compose.rendered
    destination = "/tmp/docker-compose.yaml"
  }
  provisioner "file" {
    content = data.template_file.nginx-conf.rendered
    destination = "/tmp/wg-easy.conf"
  }
  provisioner "file" {
    source = "${path.module}/scripts/init-docker.sh"
    destination = "/tmp/init-docker.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "bash /tmp/init-docker.sh"
    ]
  }
}
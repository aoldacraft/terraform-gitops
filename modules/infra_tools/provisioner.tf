/*
resource "null_resource" "provisioning" {
  triggers = {
    id = oci_core_instance.public_server.id
  }
  connection {
    type = "ssh"
    host = oci_core_instance.public_server.public_ip
    user = "ubuntu"
    private_key = file(var.ssh_private_key_path)
  }
  provisioner "file" {
    content = data.template_file.docker-compose.rendered
    destination = "/tmp/docker-compose.yaml"
  }
  provisioner "file" {
    content = data.template_file.nginx-conf.rendered
    destination = "/tmp/nginx.conf"
  }
  provisioner "file" {
    content = data.template_file.install-vpn-server.rendered
    destination = "/tmp/init-server.sh"
  }
  provisioner "file" {
    source = "${path.module}/templates/init-docker.sh"
    destination = "/tmp/init-docker.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "bash /tmp/init-docker.sh",
      "bash /tmp/init-server.sh"
    ]
  }
}
*/
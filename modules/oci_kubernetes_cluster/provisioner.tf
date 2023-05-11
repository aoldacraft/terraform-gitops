locals {
  ssh_port = 9027
}
locals {
  inventory = templatefile("${path.module}/templates/inventory.ini", { master_addrs = oci_core_instance.control_plane.*.private_ip, worker_addrs = oci_core_instance.worker_node.*.private_ip})
}

data "template_file" "bastion_tunneling" {
  depends_on = [oci_bastion_session.cp_session, local.inventory]
  template = file("${path.module}/scripts/ssh-tunneling.sh")
  vars = {
    SSH_TUNNELING_SCRIPT = "${replace(replace(oci_bastion_session.cp_session.ssh_metadata["command"], "<privateKey>", var.ssh_private_key_path), "<localPort>", local.ssh_port)} -o StrictHostKeyChecking=no >/dev/null 2>&1 &"
  }
}

resource "local_file" "bastion_tunneling_sh" {
  depends_on = [data.template_file.bastion_tunneling]
  content = data.template_file.bastion_tunneling.rendered
  filename = "${path.cwd}/outputs/ssh-tunneling.sh"
}

resource "null_resource" "init_connect" {
  triggers = {
    inv = local.inventory
  }
  depends_on = [local_file.bastion_tunneling_sh]
  provisioner "local-exec" {
    command = "bash ${path.cwd}/outputs/ssh-tunneling.sh"
  }
}

resource "null_resource" "run_ansible" {
  triggers = {
    inv = local.inventory
  }
  depends_on = [
    null_resource.init_connect
  ]

  connection {
    type = "ssh"
    host = "localhost"
    user = "ubuntu"
    port = local.ssh_port
    private_key = file(var.ssh_private_key_path)
  }
  provisioner "file" {
    content = local.inventory
    destination = "/tmp/inventory.ini"
  }
  provisioner "file" {
    source = pathexpand(var.ssh_private_key_path)
    destination = "/tmp/private.key"
  }
  provisioner "file" {
    source = "${path.module}/templates/ansible.cfg"
    destination = "/tmp/.ansible.cfg"
  }
  provisioner "file" {
    source = "${path.module}/scripts/master-init.sh"
    destination = "/tmp/master-init.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "bash /tmp/master-init.sh"
    ]
  }
}
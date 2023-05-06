resource "oci_bastion_bastion" "control_plane_bastion" {
  #Required
  bastion_type = "STANDARD"
  compartment_id = var.compartment_id
  target_subnet_id = oci_core_subnet.control_plane.id
  name = "control_plane_bastion"

  #Optional
  client_cidr_block_allow_list = ["0.0.0.0/0"]
}

resource "oci_bastion_session" "cp_session" {
  #Required
  bastion_id = oci_bastion_bastion.control_plane_bastion.id
  key_details {
    public_key_content = file(pathexpand(var.ssh_public_key_path))
  }
  target_resource_details {
    #Required
    session_type = "PORT_FORWARDING"

    #Optional
    target_resource_id = oci_core_instance.control_plane.0.id
    target_resource_port = "22"
  }

  #Optional
  display_name = "control_plane_session"
  session_ttl_in_seconds = "3600"
}
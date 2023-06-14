# terraform-gitops

### Description
IaC project to set up Dev and Prod environments on Oracle Cloud

### Create Reasource (Completed - dev, prod module)

<image src="./images/image.png">


### Requirements

1. save file '<prod,dev ..>/secrets/<private.key, public.key>'
2. permission set 
   ```bash
   sudo chmod 600 '<prod,dev ..>/secrets/<oci_private.pem, private.key, public.key>'
   ```
### Execute
1. init
   ```shell
   cd dev
   terraform init
   ```
2. write ./{prod,dev}/terraform.tfvars
   ```text
   user_ocid = "{USER_OCID}"
   fingerprint = "{FINGERPRINT}"
   tenancy_ocid = "{TENANCY_OCID}"
   region = "{REGION}"
   
   vpn_server_fqdn = "{FQDN}"
   vpn_server_admin_email = "{EMAIL}"
   vpn_server_password = "{PASSWORD}"
   
   control_plane_count = 1
   worker_count = 1
   ```
3. plan
   ```shell
   terraform plan
   ```
4. apply
   ```shell
   terraform apply --auto-approve
   ```
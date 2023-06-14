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
   user_ocid = "ocid1.user.oc1..."
   fingerprint = "..."
   tenancy_ocid = "ocid1.tenancy.oc1..aa..."
   region = "ap-..."
   
   cloudflare_api_token = "abc..."
   
   user_namespace = "asd..."
   tool_server_domain = "dev-blabla.com"
   admin_email = "blabla@example.com"
   admin_password = "blabla"
   
   domain = "imdomain"
   domain_endpoint = "imdomain.com"
   
   env = "dev or prod"
   cidr_mid = "10"
   k8s_token = "07401b.f3imsecret"
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
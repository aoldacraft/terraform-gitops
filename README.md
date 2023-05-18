# terraform-gitops

### Reference
k8s ansible: https://github.com/sigee-min/kubernetes-ansible <br/>

### Description
IAC project to set up Dev and Prod environments on Oracle Cloud

### Create Reasource (Completed - dev, prod module)
* 1 vcn
* 1 compartment
* 3 Subnet (2 private, 1 public)
* 1 NAT Gateway (2 private subnet -> public internet)
* 1 Internet Gateway
* 1 Bastion (ssh tunneling to control-plane)
* 1 NLB (public internet -> k8s worker nodes, NodePort)
* Security Groups (control plane, worker node)
* Route tables -> NAT, IGW
* 2 VM(default setting), 1 Control-Plane, 1 Worker-Node (ARM Arch)

### Create Resource (Completed - Only dev)
* 1 DNS (Internal)
* 1 Vpn Server (wireguard, public)
* Security Group (vpn server)

### Not Complete or Yet
* DNS Record
* Harbor (swift api)
* ArgoCD (by terraform)
* Jenkins (terraform controller)
* (X) OpenLDAP
* PROD Environment
* Cluster Autoscaler



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
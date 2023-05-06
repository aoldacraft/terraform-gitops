# terraform-gitops

## Requirements

1. save file '<prod,dev ..>/secrets/secret.tfvars'
```
user=${USER_ID}
fingerprint=${FINGERPRINT}
tenancy=${TENANCY_ID}
region=${REGION_ID}
key_file=${PRIVATE_KEY_FILE_PATH}
```

## Execute
1. init
```shell
cd prod
terraform init
```
2. write ./{prod,dev}/terraform.tfvars
```text
compartment_id = "ocid1.tenancy.oc1..aaaafeqfoqemfiop13..."

ssh_public_key_path = "~/Documents/secrets/ssh/minshigee.key.pub"
ssh_private_key_path= "~/Documents/secrets/ssh/minshigee.key"

control_plane_count = 1
worker_count = 1
```
3. plan
```shell
terraform plan
```
3. apply
```shell
terraform apply -var-file="./secrets/secrets.tfvars"
```
# terraform-gitops

## Requirements

1. save file '~/.oci/config'
    ```
    # [DEV, MGMT, PROD]
    [PROD]
    user_ocid=${USER_ID}
    fingerprint=${FINGERPRINT}
    tenancy_ocid=${TENANCY_ID}
    region=${REGION_ID}
    private_key_path=${PRIVATE_KEY_FILE_PATH}
    [DEV]
    ...
    ```

2. save file '<prod,dev ..>/secrets/<private.key, public.key>'
3. permission set 
   ```bash
   sudo chmod 600 '<prod,dev ..>/secrets/<private.key, public.key>'
   ```
## Execute
1. init
```shell
cd prod
terraform init
```
2. write ./{prod,dev}/terraform.tfvars
```text
control_plane_count = 1
worker_count = 1
```
3. plan
```shell
terraform plan
```
3. apply
```shell
terraform apply --auto-approve
```
# Source this file to set env vars for Terraform's OCI provider

export TF_VAR_tenancy_ocid="ocid1.tenancy.FIXME"
export TF_VAR_user_ocid="ocid1.user.FIXME"
export TF_VAR_fingerprint="51:86:97:45:FIXME"
export TF_VAR_private_key_path="~/.ssh/oci_api_key.pem"
export TF_VAR_region="us-phoenix-1"
export TF_VAR_compartment_ocid="ocid1.compartment.FIXME"

### Public/private keys used on the instance
export TF_VAR_ssh_public_key=$(cat ${HOME}/.ssh/dhutty-orcl-2019.rsa.pub)
export TF_VAR_ssh_private_key=$(cat ${HOME}/.ssh/dhutty-orcl-2019.rsa)
## NOTE: These are not your api keys. More info on the right keys see
## https://docs.us-phoenix-1.oraclecloud.com/Content/Compute/Tasks/managingkeypairs.htm


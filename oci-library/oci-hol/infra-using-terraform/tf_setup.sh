#!/bin/bash

echo This script will install terraform plus additional commandline tools on Oracle Linux
echo WARNING - THIS SCRIPT WILL OVERWRITE ~/.ssh/id_rsa and ~/.ssh/id_rsa.pub
echo IMPORTANT - this script assumes the OCI CLI is already installed and configured
echo
read -p "Press enter to continue"

#sudo yum -y makecache
#sudo yum -y upgrade
#sudo yum -y update
sudo yum -y erase terraform-provider-oci

sudo yum -y install terraform bzip2 cpio zip unzip dos2unix dialog curl jq git golang iputils wget screen tmux byobu elinks

yes "y" | ssh-keygen -N "" -f ~/.ssh/id_rsa
openssl rsa -in ~/.oci/oci_api_key.pem -pubout -outform DER 2>/dev/null | openssl md5 -c | awk '{print $2}' > ~/.oci/oci_api_key_fingerprint

mkdir -p tflab

tenancy_id=$(oci iam compartment list --all --raw-output --query 'data[*]|[0]."compartment-id"')

command cat >~/tflab/tftest.tf <<'EOF'
variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "compartment_ocid" {}
variable "ssh_public_key" {}
variable "region" {}

provider "oci" {
  tenancy_ocid         = "${var.tenancy_ocid}"
  user_ocid            = "${var.user_ocid}"
  fingerprint          = "${var.fingerprint}"
  private_key_path     = "${var.private_key_path}"
  region               = "${var.region}"
  disable_auto_retries = "true"
}

data "oci_identity_availability_domains" "ADs" {
  compartment_id = "${var.tenancy_ocid}"
}

output "ADprint" {
  value = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[0],"name")}"
}
EOF

echo "export TF_VAR_tenancy_ocid=$tenancy_id" > ~/tflab/env-vars
command cat >> ~/tflab/env-vars << 'EOF'
export TF_VAR_user_ocid=[enter user OCID here]
export TF_VAR_compartment_ocid=[enter Compartment OCID here]

export TF_VAR_fingerprint=$(cat ~/.oci/oci_api_key_fingerprint)

export TF_VAR_private_key_path=~/.oci/oci_api_key.pem

export TF_VAR_ssh_public_key=$(cat ~/.ssh/id_rsa.pub)
export TF_VAR_ssh_private_key=$(cat ~/.ssh/id_rsa)

export TF_VAR_region=us-ashburn-1
EOF

echo
echo
echo Next Steps:
echo
echo 1 - cd into the subdirectory tflab created by the tfinstaller script - this contains the tftest.tf and env-vars files
echo
echo cd tflab
echo
echo 2 - Review env-vars file to ensure all of the correct values.
echo      You will not need to add / change anything unless you notice missing values.
echo
echo 3 - source env-vars
echo
echo source env-vars
echo
echo 4 - run terraform init
echo
echo terraform init
echo
echo 5 - run terraform apply
echo
echo terraform apply
echo
echo output will be the full name of your tenancy availability domain AD1

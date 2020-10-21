#!/bin/bash

# This script requires 6 arguments
# Arg1 : Tenant OCID
# Arg2 : Compartment OCID
# Arg3 : User OCID
# Arg4 : Fingerprint
# Arg5 : Private Pem Key
# Arg6 : Compute FQDN (with customer's public domain)

### Configure ords for the target database
# Set Variables 
TenantID=$1
CompartID=$2
UserID=$3
FP=$4
PEM=$5
ComFQDN=$6

### Setup oci_curl function to call REST API
# Download bash script
curl -L https://docs.cloud.oracle.com/iaas/Content/Resources/Assets/signing_sample_bash.txt > ~/oci_bash ; nkf --overwrite --oc=UTF-8 ~/oci_bash

# Update environment variables
mkdir ~/.oci

reptgt_tenancyId=`grep "local tenancyId=" ~/oci_bash | awk -F\" '{print $2}'`
reptgt_authUserId=`grep "local authUserId=" ~/oci_bash | awk -F\" '{print $2}'`
reptgt_keyFingerprint=`grep "local keyFingerprint=" ~/oci_bash | awk -F\" '{print $2}'`
reptgt_privateKeyPath=`grep "local privateKeyPath=" ~/oci_bash | awk -F\" '{print $2}'`

sed -i -e "s/${reptgt_tenancyId}/${TenantID}/" ~/oci_bash
sed -i -e "s/${reptgt_authUserId}/${UserID}/" ~/oci_bash
sed -i -e "s/${reptgt_keyFingerprint}/${FP}/" ~/oci_bash
sed -i -e "s|${reptgt_privateKeyPath}|$HOME/.oci/oci_api_key.pem|" ~/oci_bash

echo "${PEM}" > ~/.oci/oci_api_key.pem
chmod 600 ~/.oci/oci_api_key.pem 

# Source bash function oci_curl
echo "source ~/oci_bash" >> ~/.bash_profile
source ~/.bash_profile

### Install ACME Client acme.sh
# Download acme.sh
curl https://get.acme.sh | sh
source ~/.bashrc

# copy script for dns update to under ~/.acme.sh
cp dns_ocidns.sh ~/.acme.sh/dnsapi/

### Aquire a Certificate from Let's Encrypt
export OCIDNS_C=${CompartID}
~/.acme.sh/acme.sh --issue --dnssleep 15 --dns dns_ocidns -d ${ComFQDN}
# Debug mode
# ~/.acme.sh/acme.sh --issue --debug 2 --dnssleep 15 --dns dns_ocidns -d ${ComFQDN}


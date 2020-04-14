#!/bin/bash
#
# LICENSE UPL 1.0
#
# Copyright (c) 1982-2018 Oracle and/or its affiliates. All rights reserved.
#
# Since: February 2019
# Author: travis.m.mitchell@oracle.com
# Description: Updates Oracle Linux to the latest version and installs OCI and hashicorp tooling
#
# DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS HEADER.
#


# enable yum config
yum install yum-utils -y

echo 'Installing EPEL, Oracle Public Yum Repo, Python OCI SDK, OCI CLI, Ansible, Terraform, Terraform OCI Provider, OracleInstantClient'

yum install curl wget which tar unzip -y && \
wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && rpm -Uvh epel*.rpm && \
wget http://public-yum.oracle.com/public-yum-ol7.repo -O /etc/yum.repos.d/public-yum-ol7.repo && \
yum install git python-pip -y && wget https://github.com/oracle/oci-python-sdk/releases/download/v2.1.0/oci-python-sdk-2.1.0.zip && \
unzip oci*.zip && cd oci-python-sdk && pip install --upgrade --force-reinstall pip==9.0.3 && pip install requests[security]==2.18.4 && \
pip install oci-*-py2.py3-none-any.whl && yum install ansible -y && pip install oci-cli && \
git clone https://github.com/oracle/oci-ansible-modules.git && cd oci-ansible-modules && bash -c ./install.py && \
yum-config-manager --enable ol7_developer && yum install terraform -y && yum install terraform-provider-oci -y && \
wget https://releases.hashicorp.com/packer/1.3.3/packer_1.3.3_linux_amd64.zip -O /usr/local/bin/packer_1.3.3_linux_amd64.zip && \
cd /usr/local/bin && unzip /usr/local/bin/packer_1.3.3_linux_amd64.zip && \
yum-config-manager --enable ol7_oracle_instantclient && \
yum -y install oracle-instantclient18.3-basic oracle-instantclient18.3-devel oracle-instantclient18.3-sqlplus && \
rm -rf /var/cache/yum && \
echo /usr/lib/oracle/18.3/client64/lib > /etc/ld.so.conf.d/oracle-instantclient18.3.conf && \
ldconfig

echo 'export PATH=$PATH::/usr/lib/oracle/18.3/client64/bin' >> /etc/profile

echo 'INSTALLER: Python OCI SDK, OCI CLI, Ansible, Ansible OCI Modules, Packer, Terraform, Terraform OCI Provider, OracleInstantClient installed'

cat > /etc/motd << EOF

Welcome to Oracle Linux Server release 7.6 Bastion Example
OCI Development Tools:
 - Ansible
 - OCI Ansible Modules
 - OCI Python SDK
 - OCI CLI
 - Hashicorp Packer
 - Hashicorp Terraform
 - Terraform OCI Provider
 - Oracle Instant Client 18.3 (sqlplus)

Gather your OCI Tenancy/Compartment details and configure the OCI cli and test the installed tools are working

    * oci setup config (follow the prompts)
       - https://docs.cloud.oracle.com/iaas/Content/API/Concepts/apisigningkey.htm#Other
    * terraform version
    * packer version
    * ansible-doc oci_bucket_facts
    * sqlplus -version


EOF

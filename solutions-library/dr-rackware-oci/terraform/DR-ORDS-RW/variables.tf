// Copyright (c) 2019, Oracle and/or its affiliates. All rights reserved.
// Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.

# OCI Provider variables
variable "tenancy_ocid" {}
variable "region" {}
variable "URL_APEX_file" {
  description = "url for the apex.zip file in object storage"
}
variable "URL_ORDS_file" {
  description = "url for the ords.war file in object storage"
}

# Deployment variables
variable "compartment_ocid" {
  type        = string
  description = "ocid of the compartment to deploy the bastion host in"
}

variable "dr_region" {
  type        = string
  description = "dr region name for disaster recovery"
}

variable "freeform_tags" {
  type        = map
  description = "map of freeform tags to apply to all resources"
  default = {
    "Environment" = "dr"
  }
}

variable "defined_tags" {
  type        = map
  description = "map of defined tags to apply to all resources"
  default     = {}
}

variable "dr_vcn_cidr_block" {
  type        = string
  description = "secondary vcn cidr block - Example: 192.168.x.x/16"
  default     = "10.0.0.0/16"
}

variable "vcn_cidr_block" {
  type        = string
  description = "primary vcn cidr block - Example: 10.0.x.x/16"
  default     = "192.168.0.0/16"
}

variable "vcn_dns_label" {
  description = "DNS label for Virtual Cloud Network (VCN)"
  default     = "drvcn"
}

variable "ssh_public_key_file" {
  type        = string
  description = "path to public ssh key for all instances deployed in the environment"
}

variable "ssh_private_key_file" {
  type        = string
  description = "path to private ssh key to acccess all instance in the deployed environment"
}

variable bastion_server_shape {
  type        = string
  description = "oci shape for the instance"
  default     = "VM.Standard2.1"
}

variable "db_display_name" {
  type        = string
  description = "display name of app server2"
  default     = "ActiveDBSystem"
}

variable "db_system_shape" {
  type        = string
  description = "shape of database instance"
  default     = "VM.Standard2.2"
}

variable "db_admin_password" {
  type        = string
  description = "password for SYS, SYSTEM, PDB Admin and TDE Wallet."
}

variable "zonename" {
  type        = string
  description = "A template that determines the total pre-provisioned bandwidth (ingress plus egress). Choose appropriate value based on the shapes available for the tenancy"
  default     = ""
}

variable "com_port" {
  type        = string
  description = "A template that determines the total pre-provisioned bandwidth (ingress plus egress). Choose appropriate value based on the shapes available for the tenancy"
  default     = "8888"
}

variable "display_name" {
  description = "display name of the instance"
  default     = "ORDS-Comp"
}

variable "hostname_label" {
  description = "hostname of the instance"
  default     = "ords-comp"
}



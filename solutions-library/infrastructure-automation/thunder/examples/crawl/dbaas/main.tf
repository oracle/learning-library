// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.
provider "oci" {
  tenancy_ocid     = var.provider_oci.tenancy
  user_ocid        = var.provider_oci.user_id
  fingerprint      = var.provider_oci.fingerprint
  private_key_path = var.provider_oci.key_file_path
  region           = var.provider_oci.region
}

module "dbaas" {
  source               = "../../../modules/dbaas"
  database_params      = var.database_params
  compartment_ids      = var.compartment_ids
  subnet_ids           = var.subnet_ids
}

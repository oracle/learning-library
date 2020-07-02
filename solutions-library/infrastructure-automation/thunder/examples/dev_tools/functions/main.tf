// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.
provider "oci" {
  tenancy_ocid     = var.provider_oci.tenancy
  user_ocid        = var.provider_oci.user_id
  fingerprint      = var.provider_oci.fingerprint
  private_key_path = var.provider_oci.key_file_path
  region           = var.provider_oci.region
}

module "functions" {
  source          = "../../../modules/functions"
  compartment_ids = var.compartment_ids
  subnet_ids      = var.subnet_ids
  app_params      = var.app_params
  fn_params       = var.fn_params
}



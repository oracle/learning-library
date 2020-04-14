// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.
provider "oci" {
  tenancy_ocid     = var.provider_oci.tenancy
  user_ocid        = var.provider_oci.user_id
  fingerprint      = var.provider_oci.fingerprint
  private_key_path = var.provider_oci.key_file_path
  region           = var.provider_oci.region
}


module "fss" {
  source        = "../../../modules/fss"
  compartments  = var.compartment_ids
  subnets       = var.subnet_ids
  fss_params    = var.fss_params
  mt_params     = var.mt_params
  export_params = var.export_params
  kms_key_ids   = var.kms_key_ids
}

// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.
provider "oci" {
  tenancy_ocid     = var.provider_oci.tenancy
  user_ocid        = var.provider_oci.user_id
  fingerprint      = var.provider_oci.fingerprint
  private_key_path = var.provider_oci.key_file_path
  region           = var.provider_oci.region
}

module "object-storage" {
  source        = "../../../modules/object-storage"
  compartments  = var.compartments
  bucket_params = var.bucket_params
  oci_provider  = var.provider_oci
  kms_key_ids   = var.kms_key_ids
}

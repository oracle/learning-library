// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.
provider "oci" {
  tenancy_ocid     = var.provider_oci.tenancy
  user_ocid        = var.provider_oci.user_id
  fingerprint      = var.provider_oci.fingerprint
  private_key_path = var.provider_oci.key_file_path
  region           = var.provider_oci.region
}

module "compute" {
  source              = "../../../modules/instances"
  compartment_ids     = var.compartment_ids
  subnet_ids          = var.subnet_ids
  instance_params     = var.instance_params
  bv_params           = var.bv_params
  win_instance_params = var.win_instance_params
  win_bv_params       = var.win_bv_params
  region              = var.provider_oci.region
  linux_images        = var.linux_images
  windows_images      = var.windows_images
  kms_key_ids         = module.kms.kms_key_ids
}

module "fss" {
  source        = "../../../modules/fss"
  compartments  = var.compartment_ids
  subnets       = var.subnet_ids
  fss_params    = var.fss_params
  mt_params     = var.mt_params
  export_params = var.export_params
  kms_key_ids   = module.kms.kms_key_ids
}

module "object-storage" {
  source        = "../../../modules/object-storage"
  compartments  = var.compartment_ids
  bucket_params = var.bucket_params
  oci_provider  = var.provider_oci
  kms_key_ids   = module.kms.kms_key_ids
}

module "kms" {
  source          = "../../../modules/kms"
  compartment_ids = var.compartment_ids
  vault_params    = var.vault_params
  key_params      = var.key_params
}

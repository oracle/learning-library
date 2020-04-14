// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.
provider "oci" {
  tenancy_ocid     = var.provider_oci.tenancy
  user_ocid        = var.provider_oci.user_id
  fingerprint      = var.provider_oci.fingerprint
  private_key_path = var.provider_oci.key_file_path
  region           = var.provider_oci.region
}

module "network" {
  source           = "../../../modules/network"
  vcn_params       = var.vcn_params
  compartment_ids  = var.compartment_ids
  igw_params       = var.igw_params
  ngw_params       = var.ngw_params
  rt_params        = var.rt_params
  sl_params        = var.sl_params
  nsg_params       = var.nsg_params
  nsg_rules_params = var.nsg_rules_params
  subnet_params    = var.subnet_params
  lpg_params       = var.lpg_params
  drg_params       = var.drg_params
}

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


module "compute" {
  source              = "../../../modules/instances"
  compartment_ids     = var.compartment_ids
  subnet_ids          = module.network.subnets_ids
  instance_params     = var.instance_params
  bv_params           = var.bv_params
  win_instance_params = var.win_instance_params
  win_bv_params       = var.win_bv_params
  linux_images        = var.linux_images
  windows_images      = var.windows_images
  region              = var.provider_oci.region
  kms_key_ids         = var.kms_key_ids
  nsgs                = module.network.nsgs
}

module "ipsec" {
  source       = "../../../modules/ipsec"
  ipsec_params = var.ipsec_params
  compartments = var.compartment_ids
  drgs         = module.network.drgs
}

# module "fastconnect" {
#   source                   = "../../../modules/fastconnect"
#   compartments             = var.compartment_ids
#   drgs                     = module.network.drgs 
#   cc_group                 = var.cc_group
#   cc                       = var.cc
#   private_vc_no_provider   = var.private_vc_no_provider
#   private_vc_with_provider = var.private_vc_with_provider
#   public_vc_no_provider    = var.public_vc_no_provider
#   public_vc_with_provider  = var.public_vc_with_provider
# }

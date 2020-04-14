// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.

# Region 1 components
provider "oci" {
  alias  = "first"
  region = var.provider_oci.region

  tenancy_ocid         = var.provider_oci.tenancy
  user_ocid            = var.provider_oci.user_id
  fingerprint          = var.provider_oci.fingerprint
  private_key_path     = var.provider_oci.key_file_path
  private_key_password = var.provider_oci.private_key_password
}

module "network" {
  source           = "../../../modules/network"
  providers        = { oci = oci.first }
  compartment_ids  = var.compartment_ids
  vcn_params       = var.vcn_params
  igw_params       = var.igw_params
  ngw_params       = var.ngw_params
  rt_params        = var.rt_params
  sl_params        = var.sl_params
  nsg_params       = var.nsg_params
  nsg_rules_params = var.nsg_rules_params
  subnet_params    = var.subnet_params
  lpg_params       = var.lpg_params
}

# Region 2 components
provider "oci" {
  alias  = "second"
  region = var.provider_oci.region2

  tenancy_ocid         = var.provider_oci.tenancy
  user_ocid            = var.provider_oci.user_id
  fingerprint          = var.provider_oci.fingerprint
  private_key_path     = var.provider_oci.key_file_path
  private_key_password = var.provider_oci.private_key_password
}

module "network_region2" {
  source           = "../../../modules/network"
  providers        = { oci = oci.second }
  compartment_ids  = var.compartment_ids
  vcn_params       = var.vcn_params_second
  igw_params       = var.igw_params_second
  ngw_params       = var.ngw_params_second
  rt_params        = var.rt_params_second
  sl_params        = var.sl_params_second
  nsg_params       = var.nsg_params_second
  nsg_rules_params = var.nsg_rules_params_second
  subnet_params    = var.subnet_params_second
  lpg_params       = var.lpg_params_second
}

# VCN remote peering
module "remote_peering" {
  source                         = "../../../modules/remote-peering"
  provider_path                  = var.provider_path
  compartment_ids                = var.compartment_ids
  vcns                           = module.network.vcns
  vcns2                          = module.network_region2.vcns
  rpg_params                     = var.rpg_params
  tenancy_id                     = var.provider_oci.tenancy
  requestor_region               = var.provider_oci.region
  requestor_user_id              = var.provider_oci.user_id
  requestor_fingerprint          = var.provider_oci.fingerprint
  requestor_private_key_path     = var.provider_oci.key_file_path
  requestor_private_key_password = var.provider_oci.private_key_password
  acceptor_region                = var.provider_oci.region2
  acceptor_user_id               = var.provider_oci.user_id
  acceptor_fingerprint           = var.provider_oci.fingerprint
  acceptor_private_key_path      = var.provider_oci.key_file_path
  acceptor_private_key_password  = var.provider_oci.private_key_password
}

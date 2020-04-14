// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.
provider "oci" {
  tenancy_ocid     = var.provider_oci.tenancy
  user_ocid        = var.provider_oci.user_id
  fingerprint      = var.provider_oci.fingerprint
  private_key_path = var.provider_oci.key_file_path
  region           = var.provider_oci.region
}

module "iam" {
  source        = "../../modules/iam"
  comp_params   = var.comp_params
  user_params   = var.user_params
  group_params  = var.group_params
  policy_params = var.policy_params
  auth_provider = var.provider_oci
}

module "network" {
  source           = "../../modules/network"
  vcn_params       = var.vcn_params
  compartment_ids  = module.iam.compartments
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

module "adw" {
  source          = "../../modules/adw"
  adw_params      = var.adw_params
  compartment_ids = module.iam.compartments
}

module "compute" {
  source              = "../../modules/instances"
  compartment_ids     = module.iam.compartments
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

# module "dbaas" {
#   source               = "../../modules/dbaas"
#   database_params      = var.database_params
#   compartment_ids      = module.iam.compartments
#   subnet_ids           = module.network.subnets_ids
# }


module "fss" {
  source        = "../../modules/fss"
  compartments  = module.iam.compartments
  subnets       = module.network.subnets_ids
  fss_params    = var.fss_params
  mt_params     = var.mt_params
  export_params = var.export_params
  kms_key_ids   = var.kms_key_ids
}

module "instance-principal" {
  source                    = "../../modules/instance-principal"
  instance_principal_params = var.instance_principal_params
  instances                 = module.compute.all_instances
  auth_provider             = var.provider_oci
}

module "load-balancer" {
  source               = "../../modules/load-balancer"
  compartment_ids      = module.iam.compartments
  subnet_ids           = module.network.subnets_ids
  lb_params            = var.lb_params
  backend_sets         = var.backend_sets
  listeners            = var.listeners
  certificates         = var.certificates
  backend_params       = var.backend_params
  private_ip_instances = module.compute.all_private_ips
}

module "object-storage" {
  source        = "../../modules/object-storage"
  compartments  = module.iam.compartments
  bucket_params = var.bucket_params
  oci_provider  = var.provider_oci
  kms_key_ids   = var.kms_key_ids
}

module "dns" {
  source               = "../../modules/dns"
  zone_params          = var.zone_params
  dns_records_params   = var.dns_records_params
  compartments         = module.iam.compartments
  instances            = module.compute.all_private_ips
  load_balancer_params = module.load-balancer.lbs
}

 //Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.

provider "oci" {
  tenancy_ocid     = var.provider_oci.tenancy
  user_ocid        = var.provider_oci.user_id
  fingerprint      = var.provider_oci.fingerprint
  private_key_path = var.provider_oci.key_file_path
  region           = var.provider_oci.region
}

provider "oci" {
  alias            = "region2"
  tenancy_ocid     = var.provider_oci.tenancy
  user_ocid        = var.provider_oci.user_id
  fingerprint      = var.provider_oci.fingerprint
  private_key_path = var.provider_oci.key_file_path
  region           = var.provider_oci.region2
}

module "glusterfs_region_1" {
  source          = "../../../modules/glusterfs"
  gluster_params  = var.gluster_params
  ssh_public_key  = var.ssh_public_key
  ssh_private_key = var.ssh_private_key
  instance_params = var.instance_params
  bv_params       = var.bv_params
  region          = var.provider_oci.region
  images          = var.images
}

module "glusterfs_region_2" {
  source = "../../../modules/glusterfs"
  providers = {
    oci = "oci.region2"
  }
  gluster_params  = var.gluster_params
  ssh_public_key  = var.ssh_public_key
  ssh_private_key = var.ssh_private_key
  instance_params = var.instance_params_2
  bv_params       = var.bv_params_2
  region          = var.provider_oci.region2
  images          = var.images
}

module "georeplication" {
  source = "../../../modules/georeplication"

  ssh_private_key    = var.ssh_private_key
  masters_private_ip = module.glusterfs_region_1.private_ips
  slaves_private_ip  = module.glusterfs_region_2.private_ips
}

// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.

provider "oci" {
  tenancy_ocid     = var.provider_oci.tenancy
  user_ocid        = var.provider_oci.user_id
  fingerprint      = var.provider_oci.fingerprint
  private_key_path = var.provider_oci.key_file_path
  region           = var.provider_oci.region
}

data "oci_identity_tenancy" "existing" {
  tenancy_id = var.provider_oci.tenancy
}

data "oci_identity_regions" "existing" {
  filter {
    name   = "key"
    values = [data.oci_identity_tenancy.existing.home_region_key]
  }
}

module "grafana" {
  source                    = "./modules/grafana"
  instance_params           = var.instance_params
  ssh_public_key            = var.ssh_public_key
  ssh_private_key           = var.ssh_private_key
  auth_provider             = var.provider_oci
  home_region               = data.oci_identity_regions.existing.regions[0].name
  instance_principal_params = var.instance_principal_params
  images                    = var.images
}

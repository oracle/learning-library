// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.
provider "oci" {
  tenancy_ocid     = var.provider_oci.tenancy
  user_ocid        = var.provider_oci.user_id
  fingerprint      = var.provider_oci.fingerprint
  private_key_path = var.provider_oci.key_file_path
  region           = var.provider_oci.region
}

module "instance-principal" {
  source                    = "../../../modules/instance-principal"
  instance_principal_params = var.instance_principal_params
  instances                 = var.instances
  auth_provider             = var.provider_oci
}

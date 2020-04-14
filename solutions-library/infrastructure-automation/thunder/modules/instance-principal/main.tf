// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.
provider "oci" {
  tenancy_ocid     = var.auth_provider.tenancy
  user_ocid        = var.auth_provider.user_id
  fingerprint      = var.auth_provider.fingerprint
  private_key_path = var.auth_provider.key_file_path
  region           = data.oci_identity_regions.existing.regions[0].name
  alias            = "home"
}

data "oci_identity_tenancy" "existing" {
  tenancy_id = var.auth_provider.tenancy
}

data "oci_identity_regions" "existing" {
  filter {
    name   = "key"
    values = [data.oci_identity_tenancy.existing.home_region_key]
  }
}

resource "oci_identity_dynamic_group" "instance_principal_dg" {
  provider       = oci.home
  for_each       = var.instance_principal_params
  compartment_id = var.auth_provider.tenancy
  description    = each.value.dg_description
  matching_rule  = "instance.id = '${var.instances[each.value.instance_name]}'"
  name           = each.value.dg_name
}

resource "oci_identity_policy" "this" {
  provider       = oci.home
  for_each       = var.instance_principal_params
  compartment_id = var.auth_provider.tenancy
  description    = each.value.policy_description
  name           = each.value.policy_name
  statements     = ["Allow dynamic-group ${oci_identity_dynamic_group.instance_principal_dg[each.value.dg_name].name} to manage all-resources in tenancy"]
}

// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.
data "oci_identity_availability_domains" "ads" {
  compartment_id = var.compartments[var.fss_params[keys(var.fss_params)[0]].compartment_name]
}

resource "oci_file_storage_file_system" "this" {
  for_each            = var.fss_params
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[each.value.ad - 1].name
  compartment_id      = var.compartments[each.value.compartment_name]
  display_name        = each.value.name
  kms_key_id          = length(var.kms_key_ids) == 0 || each.value.kms_key_name == "" ? "" : var.kms_key_ids[each.value.kms_key_name]
}

resource "oci_file_storage_mount_target" "this" {
  for_each            = var.mt_params
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[each.value.ad - 1].name
  display_name        = each.value.name
  compartment_id      = var.compartments[each.value.compartment_name]
  subnet_id           = var.subnets[each.value.subnet_name]
}


resource "oci_file_storage_export_set" "this" {
  for_each        = var.mt_params
  mount_target_id = oci_file_storage_mount_target.this[each.key].id
  display_name    = each.value.name
}


resource "oci_file_storage_export" "this" {
  for_each       = var.export_params
  export_set_id  = oci_file_storage_export_set.this[each.value.export_set_name].id
  file_system_id = oci_file_storage_file_system.this[each.value.filesystem_name].id
  path           = each.value.path

  dynamic "export_options" {
    iterator = exp_options
    for_each = each.value.export_options
    content {
      source                         = exp_options.value.source
      access                         = exp_options.value.access
      identity_squash                = exp_options.value.identity
      require_privileged_source_port = exp_options.value.use_port
    }
  }
}

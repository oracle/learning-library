// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.
data "oci_objectstorage_namespace" "this" {
  compartment_id = var.oci_provider["tenancy"]
}

resource "oci_objectstorage_bucket" "this" {
  for_each              = var.bucket_params
  compartment_id        = var.compartments[each.value.compartment_name]
  name                  = each.value.name
  namespace             = data.oci_objectstorage_namespace.this.namespace
  access_type           = each.value.access_type
  storage_tier          = each.value.storage_tier
  object_events_enabled = each.value.events_enabled
  kms_key_id            = length(var.kms_key_ids) == 0 || each.value.kms_key_name == "" ? "" : var.kms_key_ids[each.value.kms_key_name]
}

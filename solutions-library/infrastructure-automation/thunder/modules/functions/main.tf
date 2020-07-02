// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.

data "oci_identity_availability_domains" "ads" {
  compartment_id = var.compartment_ids[var.app_params[keys(var.app_params)[0]].compartment_name]
}

resource "oci_functions_application" "this" {
  for_each       = var.app_params
  compartment_id = var.compartment_ids[each.value.compartment_name]
  subnet_ids     = [for i in each.value.subnet_name : var.subnet_ids[i]]
  display_name   = each.value.display_name
  config         = each.value.config
  freeform_tags  = each.value.freeform_tags
}


data "oci_functions_applications" "existing" {
  for_each = var.app_params
  compartment_id = var.compartment_ids[each.value.compartment_name]
  id       = oci_functions_application.this[each.value.display_name].id
}

# Terraform will take 40 minutes after destroying a function due to a known service issue.
# please refer: https://docs.cloud.oracle.com/iaas/Content/Functions/Tasks/functionsdeleting.htm
resource "oci_functions_function" "this" {
  for_each           = var.fn_params
  application_id     = oci_functions_application.this[each.value.function_app].id
  display_name       = each.value.display_name
  image              = each.value.image
  memory_in_mbs      = "128"
  config             = each.value.config
  image_digest       = each.value.image_digest
  timeout_in_seconds = "30"
  freeform_tags      = each.value.freeform_tags
}

data "oci_functions_functions" "existing" {
  for_each       = var.fn_params
  application_id = oci_functions_application.this[each.value.function_app].id
}
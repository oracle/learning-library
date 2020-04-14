// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.
resource "random_string" "autonomous_database_wallet_password" {
  for_each         = var.adw_params
  length           = 16
  special          = true
  min_upper        = 3
  min_lower        = 3
  min_numeric      = 3
  min_special      = 3
  override_special = "{}#^*<>[]%~"
}

data "oci_database_autonomous_database_wallet" "autonomous_database_wallet" {
  for_each               = var.adw_params
  autonomous_database_id = oci_database_autonomous_database.adw[each.value.db_name].id
  password               = random_string.autonomous_database_wallet_password[each.value.db_name].result
  base64_encode_content  = "false"
}
resource "oci_database_autonomous_database" "adw" {
  for_each                 = var.adw_params
  admin_password           = random_string.autonomous_database_wallet_password[each.value.db_name].result
  compartment_id           = var.compartment_ids[each.value.compartment_name]
  cpu_core_count           = each.value.cpu_core_count
  data_storage_size_in_tbs = each.value.size_in_tbs
  db_name                  = each.value.db_name
  display_name             = each.value.db_name
  db_workload              = each.value.db_workload
  is_auto_scaling_enabled  = each.value.enable_auto_scaling
  is_free_tier             = each.value.is_free_tier
}
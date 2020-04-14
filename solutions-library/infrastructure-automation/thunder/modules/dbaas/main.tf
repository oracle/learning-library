// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.
data "oci_identity_availability_domains" "ads" {
  compartment_id = var.compartment_ids[var.database_params[keys(var.database_params)[0]].compartment_name]
}

resource "oci_database_db_system" "this" {
  for_each            = var.database_params
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[each.value.ad -1].name
  compartment_id      = var.compartment_ids[each.value.compartment_name]
  cpu_core_count      = each.value.cpu_core_count
  database_edition    = each.value.db_edition

  lifecycle {
    ignore_changes = [cpu_core_count, ssh_public_keys]
  }

  db_home {
    database {
      admin_password = each.value.db_admin_password
      db_name        = each.value.db_name
      db_workload    = each.value.db_workload
      pdb_name       = each.value.pdb_name

      db_backup_config {
        auto_backup_enabled = each.value.enable_auto_backup
      }
    }

    db_version   = each.value.db_version
    display_name = each.value.display_name
  }

  disk_redundancy         = each.value.disk_redundancy
  shape                   = each.value.shape
  subnet_id               = var.subnet_ids[each.value.subnet_name]
  ssh_public_keys         = [file(each.value.ssh_public_key)]
  display_name            = each.value.display_name
  hostname                = each.value.hostname
  data_storage_size_in_gb = each.value.data_storage_size_in_gb
  license_model           = each.value.license_model
  node_count              = each.value.node_count
}

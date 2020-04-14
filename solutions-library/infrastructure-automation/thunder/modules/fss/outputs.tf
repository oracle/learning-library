// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.
output "filesystems" {
  value = {for fs in oci_file_storage_file_system.this:
    fs.display_name => fs.id  
  }
}

data "oci_core_private_ip" "existing" {
  for_each      = oci_file_storage_mount_target.this
  private_ip_id = oci_file_storage_mount_target.this[each.key].private_ip_ids[0]
}

output "mount_targets" {
  value = {for index, mt in oci_file_storage_mount_target.this:
    mt.display_name => data.oci_core_private_ip.existing[index].ip_address
  }
}


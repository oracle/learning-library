// Copyright (c) 2019, Oracle and/or its affiliates. All rights reserved.
// Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.

output dr_vcn {
  description = "the `oci_core_vcn` resource"
  value       = oci_core_vcn.dr_vcn
}

output dr_db_subnet_id {
  description = "db_subnet_id"
  value       = oci_core_subnet.db_subnet.id
}

output dr_access_subnet_id {
  description = "access_subnet_id"
  value       = oci_core_subnet.access_subnet.id
}

output dr_ping_all_id {
  description = "ping_all_id"
  value       = oci_core_network_security_group.ping_all.id
}

output dr_remote_peering_id {
  description = "remote_peering_id"
  value       = concat(oci_core_remote_peering_connection.dr_remote_peering_connection.*.id, [null])[0]
}

output dr_remote_peering_id_1 {
  description = "remote_peering_id"
  value       = concat(oci_core_remote_peering_connection.dr_remote_peering_setup.*.id, [null])[0]
}

output dr_availability_domains {
  description = "list of AD's of remote destination region"
  value       = data.oci_identity_availability_domains.AD.availability_domains
}
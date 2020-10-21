output db_hostname {
  value = oci_database_db_system.db_system.hostname
}

output db_node_private_ip {
  value = data.oci_core_vnic.node_ip.private_ip_address
}

output "db_domain" {
  value = oci_database_db_system.db_system.domain
}

output "pdb_name" {
  value = var.pdb_name
}

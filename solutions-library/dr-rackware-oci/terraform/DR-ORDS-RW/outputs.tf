// Copyright (c) 2019, Oracle and/or its affiliates. All rights reserved.
// Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.

### Standby Region Outputs

output "dr_bastion" {
  description = "ip address for secondary bastion"
  value       = module.dr_bastion_instance.dr_instance_ip
}

### Primary Region Outputs

output "primary_bastion" {
  description = "ip address for primary bastion"
  value       = module.bastion_instance.dr_instance_ip
}


### ords Information
output "ords_public_ip" {
  description = "ip address for ords instance"
  value       = module.ords.InstancePublicIP
}

### Database Information

output "db_ip" {
  description = "Ip address for database"
  value       = module.database.db_node_private_ip
}

output "URL_for_Apex" {
  description = "URL for APEX"
  value       = "https://${module.ords.InstancePublicIP}:${var.com_port}/ords/${module.database.pdb_name}"
}


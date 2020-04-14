// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.
output "linux_instances" {
  value = module.compute.linux_instances
}

output "windows_instances" {
  value = module.compute.windows_instances
}

output "kms_vault_ids" {
  value = module.kms.kms_vault_ids
}

output "kms_key_ids" {
  value = module.kms.kms_key_ids
}

output "keys_versions_map" {
  value = module.kms.keys_versions_map
}

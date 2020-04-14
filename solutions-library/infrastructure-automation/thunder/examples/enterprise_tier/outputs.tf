// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.
output "iam_users" {
  value = module.iam.users
}

output "iam_compartments" {
  value = module.iam.compartments
}

output "iam_groups" {
  value = module.iam.groups
}

output "iam_policies" {
  value = module.iam.policies
}

output "network_vcns" {
  value = module.network.vcns
}

output "network_subnets" {
  value = module.network.subnets
}

output "autonomous" {
  value = module.adw.ad
}

output "compute_linux_instances" {
  value = module.compute.linux_instances
}

output "compute_windows_instances" {
  value = module.compute.windows_instances
}

output "all_instances" {
  value = module.compute.all_instances
}

output "all_private_ips" {
  value = module.compute.all_private_ips
}
#
# # output "database" {
# #   value = module.dbaas.database
# # }
#
output "dns_zones" {
  value = module.dns.zones
}

output "dns_records" {
  value = module.dns.records
}

output "fss_filesystems" {
  value = module.fss.filesystems
}

output "fss_mount_targets" {
  value = module.fss.mount_targets
}

output "load_balancer_lbs" {
  value = module.load-balancer.load_balancers
}

output "load_balancer_backend_sets" {
  value = module.load-balancer.backend_sets
}

output "buckets" {
  value = module.object-storage.buckets
}

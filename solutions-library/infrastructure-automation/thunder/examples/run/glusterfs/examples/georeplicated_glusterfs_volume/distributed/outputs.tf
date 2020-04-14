 //Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.

output "private_ips_region1" {
  value = module.glusterfs_region_1.private_ips
}

output "private_ips_region2" {
  value = module.glusterfs_region_2.private_ips
}
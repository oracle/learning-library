 //Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.

output "private_ips_region1" {
  value = module.glusterfs_striped.private_ips
}
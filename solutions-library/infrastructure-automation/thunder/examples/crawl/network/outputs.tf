// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.
output "vcns" {
  value = module.network.vcns
}

output "subnets" {
  value = module.network.subnets
}

output "nsgs" {
  value = module.network.nsgs
}
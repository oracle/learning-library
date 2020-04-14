// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.
output "nw_vcns" {
  value = module.network.vcns
}

output "nw_subnets" {
  value = module.network.subnets
}

output "nw_ipsec_tunnel_ips" {
  value = module.ipsec.ipsec_tunnel_ips
}

output "compute_linux_instances" {
  value = module.compute.linux_instances
}
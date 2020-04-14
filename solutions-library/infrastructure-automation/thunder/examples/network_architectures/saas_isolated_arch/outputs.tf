// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.
output "vcns" {
  value = module.network.vcns
}

output "subnets" {
  value = module.network.subnets
}

output "compute_linux_instances" {
  value = module.compute.linux_instances
}

output "load_balancer_lbs" {
  value = module.load-balancer.load_balancers
}

output "nw_ipsec_tunnel_ips" {
  value = module.ipsec.ipsec_tunnel_ips
}

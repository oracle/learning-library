// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.
output "load_balancers" {
  value = module.load-balancer.load_balancers
}

output "backend_sets" {
  value = module.load-balancer.backend_sets
}
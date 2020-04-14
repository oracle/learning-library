// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.
output "users" {
  value = module.iam.users
}

output "compartments" {
  value = module.iam.compartments
}

output "groups" {
  value = module.iam.groups
}

output "policies" {
  value = module.iam.policies
}
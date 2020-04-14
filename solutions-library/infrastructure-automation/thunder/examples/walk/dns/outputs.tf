// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.

output "zones" {
  value = module.dns.zones
}

output "records" {
  value = module.dns.records
}
// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.

output "waas" {
  value = module.waas.waas
}

output "cname" {
  value = module.waas.cname
}

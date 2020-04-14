// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.
output "linux_instances" {
  value = module.compute.linux_instances
}

output "windows_instances" {
  value = module.compute.windows_instances
}
// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.
output "filesystems" {
  value = module.fss.filesystems
}

output "mount_targets" {
  value = module.fss.mount_targets
}
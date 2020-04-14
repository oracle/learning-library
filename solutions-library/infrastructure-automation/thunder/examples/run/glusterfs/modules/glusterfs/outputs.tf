 //Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.

output "private_ips" {
  value = [for key, value in oci_core_instance.this : value.private_ip]
}
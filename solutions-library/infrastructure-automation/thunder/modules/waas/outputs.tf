// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.

output "cname" {
  value = { for waas in oci_waas_waas_policy.this :
    waas.display_name => waas.cname
  }
}

output "waas" {
  value = { for waas in oci_waas_waas_policy.this :
    waas.display_name => waas.id
  }
}

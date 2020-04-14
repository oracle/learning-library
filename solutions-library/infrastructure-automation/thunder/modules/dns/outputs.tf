// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.

output "zones" {
  value = [for zone in oci_dns_zone.this:
    {"id": zone.id, "name": zone.name}
  ]
}

output "records" {
  value = [for record in oci_dns_record.this:
    {"domain": record.domain, "data": record.rdata}
  ]
}
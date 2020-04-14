// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.
output "vcns" {
  value = {
    for vcn in oci_core_virtual_network.vcn :
    vcn.display_name => map("id", vcn.id, "cidr", vcn.cidr_block)
  }
}

output "subnets" {
  value = {
    for subnet in oci_core_subnet.subnets :
    subnet.display_name => map(subnet.id, subnet.cidr_block)
  }
}

output "subnets_ids" {
  value = {
    for subnet in oci_core_subnet.subnets :
    subnet.display_name => subnet.id
  }
}

output "drgs" {
  value = {
    for drg in oci_core_drg.this:
      drg.display_name => drg.id
  }
}

output "nsgs" {
  value = {
    for nsg in oci_core_network_security_group.nsg:
      nsg.display_name => nsg.id
  }
}
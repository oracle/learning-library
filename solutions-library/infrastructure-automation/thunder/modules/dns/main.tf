// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.

resource "oci_dns_zone" "this" {
  for_each       = var.zone_params
  compartment_id = var.compartments[each.value.compartment_name]
  name           = each.value.zone_name
  zone_type      = each.value.zone_type
  dynamic "external_masters" {
    iterator = ip
    for_each = each.value.external_masters
    content {
      address = ip.value.ip
    }
  }
}

data "oci_load_balancer_load_balancers" "existing" {
  for_each       = var.load_balancer_params
  compartment_id = each.value.comp_id
  filter          {
    name  = "id"
    values = [each.value.lb_id]
  }
}

resource "oci_dns_record" "this" {
  for_each          = var.dns_records_params
  zone_name_or_id   = oci_dns_zone.this[each.value.zone_name].id
  domain            = each.value.domain
  rtype             = each.value.rtype
  ttl               = each.value.ttl
  rdata             = each.value.use_instance ? var.instances[each.value.instance_name] : each.value.use_lb ? data.oci_load_balancer_load_balancers.existing[each.value.lb_name].load_balancers[0].ip_address_details[0].ip_address : each.value.rdata
}

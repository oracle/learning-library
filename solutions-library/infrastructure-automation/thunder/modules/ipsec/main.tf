// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.

resource "oci_core_cpe" "this" {
  for_each       = var.ipsec_params
  compartment_id = var.compartments[each.value.comp_name]
  ip_address     = each.value.cpe_ip_address
  display_name   = each.value.name
}


resource "oci_core_ipsec" "this" {
  for_each       = var.ipsec_params
  compartment_id = var.compartments[each.value.comp_name]
  cpe_id         = oci_core_cpe.this[each.value.name].id
  drg_id         = var.drgs[each.value.drg_name]
  static_routes  = each.value.static_routes
}

data "oci_core_ipsec_connection_tunnels" "this" {
  for_each = oci_core_ipsec.this
  ipsec_id = each.value.id
}
// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.


variable "compartments" {
  type = map(string)
}

variable "drgs" {
  type = map(string)
}

variable "cc_group" {
  type = map(object({
    comp_name = string
    name      = string
  }))
}

variable "cc" {
  type = map(object({
    comp_name             = string
    name                  = string
    location_name         = string
    port_speed_shape_name = string
    cc_group_name         = string
  }))
}

variable "private_vc_no_provider" {
  type = map(object({
    comp_name             = string
    name                  = string
    type                  = string
    bw_shape              = string
    cc_group_name         = string
    cust_bgp_peering_ip   = string
    oracle_bgp_peering_ip = string
    vlan                  = string
    drg                   = string
  }))
}

variable "private_vc_with_provider" {
  type = map(object({
    comp_name             = string
    name                  = string
    type                  = string
    bw_shape              = string
    cc_group_name         = string
    cust_bgp_peering_ip   = string
    oracle_bgp_peering_ip = string
    vlan                  = string
    drg                   = string
    private_service_id    = string
    private_service_key   = string
  }))
}

variable "public_vc_no_provider" {
  type = map(object({
    comp_name             = string
    name                  = string
    type                  = string
    bw_shape              = string
    cidr_block            = string
    cc_group_name         = string
    vlan                  = string
  }))
}

variable "public_vc_with_provider" {
  type = map(object({
    comp_name             = string
    name                  = string
    type                  = string
    bw_shape              = string
    cidr_block            = string
    cc_group_name         = string
    vlan                  = string
    private_service_id    = string
    private_service_key   = string
  }))
}
// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.

variable "ipsec_params" {
  type = map(object({
    comp_name      = string
    cpe_ip_address = string
    name           = string
    drg_name       = string
    static_routes  = list(string)
  }))
}

variable "compartments" {
  type = map(string)
}

variable "drgs" {
  type = map(string)
}
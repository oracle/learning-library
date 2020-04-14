// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.

variable "vcn_params" {
  description = "VCN Parameters: vcn_cidr, display_name, dns_label"
  type = map(object({
    vcn_cidr         = string
    compartment_name = string
    display_name     = string
    dns_label        = string
  }))
}

variable "compartment_ids" {
  type = map(string)
}

variable "igw_params" {
  description = "Placeholder for vcn index association and igw name"
  type = map(object({
    vcn_name     = string
    display_name = string
  }))
}

variable "ngw_params" {
  description = "Placeholder for vcn index association and ngw name"
  type = map(object({
    vcn_name     = string
    display_name = string
  }))
}

variable "rt_params" {
  description = "Placeholder for vcn index association, rt name, route rules"
  type = map(object({
    vcn_name     = string
    display_name = string
    route_rules = list(object({
      destination = string
      use_igw     = bool
      igw_name    = string
      ngw_name    = string
    }))
  }))
}

variable "sl_params" {
  description = "Security List Params"
  type = map(object({
    vcn_name     = string
    display_name = string
    egress_rules = list(object({
      stateless   = string
      protocol    = string
      destination = string
    }))
    ingress_rules = list(object({
      stateless   = string
      protocol    = string
      source      = string
      source_type = string
      tcp_options = list(object({
        min = number
        max = number
      }))
      udp_options = list(object({
        min = number
        max = number
      }))
    }))
  }))
}


variable "nsg_params" {
  type = map(object({
    vcn_name     = string
    display_name = string
  }))
}

variable "nsg_rules_params" {
  type = map(object({
    nsg_name         = string
    protocol         = string
    stateless        = string
    direction        = string
    source           = string
    source_type      = string
    destination      = string
    destination_type = string
    tcp_options = list(object({
      destination_ports = list(object({
        min = number
        max = number
      }))
      source_ports = list(object({
        min = number
        max = number
      }))
    }))
    udp_options = list(object({
      destination_ports = list(object({
        min = number
        max = number
      }))
      source_ports = list(object({
        min = number
        max = number
      }))
    }))
  }))
}


variable "subnet_params" {
  type = map(object({
    display_name      = string
    cidr_block        = string
    dns_label         = string
    is_subnet_private = bool
    sl_name           = string
    rt_name           = string
    vcn_name          = string
  }))
}

variable "lpg_params" {
  type = map(object({
    acceptor     = string
    requestor    = string
    display_name = string
  }))
}

variable "drg_params" {
  type = map(object({
    name        = string
    vcn_name    = string
    cidr_rt     = string
    rt_names    = list(string)
  }))
}
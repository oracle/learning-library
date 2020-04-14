// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.

variable "compartments" {
  type = map(string)
}

variable "instances" {
  type = map(any)
}

variable "load_balancer_params" {
  type = map(object({
    lb_id             = string
    comp_id           = string
  }))
}
variable "zone_params" {
  description = "The parameters of the zones: zone_name, zone_type, compartment_id"
  type        = map(object({
    compartment_name  = string
    zone_name         = string
    zone_type         = string
    external_masters  = list(object({
      ip    = string
    }))
  }))
}

variable "dns_records_params" {
  description = "The DNS records for the domains(zones)"
  type        = map(object({
    zone_name      = string
    domain         = string
    rtype          = string
    ttl            = number
    rdata          = string
    use_lb         = bool
    use_instance   = bool
    lb_name        = string
    instance_name  = string
  }))
}

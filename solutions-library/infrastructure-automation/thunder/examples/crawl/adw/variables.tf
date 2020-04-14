// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.
variable "provider_oci" {
  type = map(string)
}

variable "adw_params" {
  type = map(object({
    compartment_name    = string
    cpu_core_count      = number
    size_in_tbs         = number
    db_name             = string
    db_workload         = string
    enable_auto_scaling = bool
    is_free_tier        = bool
  }))
}

variable "compartment_ids" {
  type = map(string)
}
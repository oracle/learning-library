// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.
variable "oci_provider" {
  type = map(string)
}

variable "bucket_params" {
  type = map(object({
    compartment_name = string
    name             = string
    access_type      = string
    storage_tier     = string
    events_enabled   = bool
    kms_key_name     = string
  }))
}

variable "compartments" {
  type = map(string)
}

variable "kms_key_ids" {
  type = map(string)
}

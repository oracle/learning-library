// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.
variable "provider_oci" {
  type = map(string)
}

variable "compartment_ids" {
  type = map(string)
}

variable "subnet_ids" {
  type = map(string)
}

variable "fss_params" {
  type = map(object({
    ad               = number
    compartment_name = string
    name             = string
    kms_key_name     = string
  }))
}

variable "mt_params" {
  type = map(object({
    ad               = number
    compartment_name = string
    name             = string
    subnet_name      = string
  }))
}

variable "export_params" {
  type = map(object({
    export_set_name = string
    filesystem_name = string
    path            = string
    export_options = list(object({
      source   = string
      access   = string
      identity = string
      use_port = bool
    }))
  }))
}

variable "kms_key_ids" {
  type = map(string)
}

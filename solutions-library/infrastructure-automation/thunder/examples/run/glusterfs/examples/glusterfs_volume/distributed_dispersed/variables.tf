 //Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.

variable "provider_oci" {
  type = map(string)
}

variable "gluster_params" {
  type = map(string)
}

variable "images" {
  type = map(string)
}

variable "instance_params" {
  type = map(object({
    ad                   = number
    comp_id              = string
    shape                = string
    hostname             = string
    subnet_id            = string
    hostname             = string
    preserve_boot_volume = string
  }))
}

variable "bv_params" {
  type = map(object({
    name          = string
    instance_name = string
    size_in_gbs   = number
  }))
}

variable "ssh_public_key" {
  type = string
}

variable "ssh_private_key" {
  type = string
}
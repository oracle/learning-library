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

variable "linux_images" {
  type = map(string)
}

variable "instance_params" {
  description = "Placeholder for the parameters of the instances"
  type = map(object({
    ad                   = number
    shape                = string
    hostname             = string
    boot_volume_size     = number
    assign_public_ip     = bool
    preserve_boot_volume = bool
    compartment_name     = string
    subnet_name          = string
    ssh_public_key       = string
    device_disk_mappings = string
    freeform_tags        = map(string)
    kms_key_name         = string
  }))
}

variable "bv_params" {
  description = "Placeholder the bv parameters"
  type = map(object({
    ad            = number
    display_name  = string
    bv_size       = number
    instance_name = string
    device_name   = string
    freeform_tags = map(string)
    kms_key_name  = string
  }))
}

variable "windows_images" {
  type = map(string)
}

variable "win_instance_params" {
  description = "Placeholder for windows instances"
  type = map(object({
    ad                   = number
    shape                = string
    hostname             = string
    boot_volume_size     = number
    assign_public_ip     = bool
    preserve_boot_volume = bool
    compartment_name     = string
    subnet_name          = string
    device_disk_mappings = string
    freeform_tags        = map(string)
    kms_key_name         = string
  }))
}

variable "win_bv_params" {
  description = "Placeholder for windows bv"
  type = map(object({
    ad            = number
    display_name  = string
    bv_size       = number
    instance_name = string
    freeform_tags = map(string)
    kms_key_name  = string
  }))
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

variable "vault_params" {
  type = map(object({
    compartment_name = string
    display_name     = string
    vault_type       = string
  }))

}

variable "key_params" {
  type = map(object({
    compartment_name        = string
    display_name            = string
    vault_name              = string
    key_shape_algorithm     = string
    key_shape_size_in_bytes = number
    rotation_version        = number
  }))
}

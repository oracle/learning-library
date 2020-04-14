// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.

variable "provider_path" {
  type = string
}

variable "compartment_ids" {
  type = map(string)
}

variable "vcns" {
  description = "The list of vnc's"
  type        = map(map(string))
}

variable "vcns2" {
  description = "The list of vnc's"
  type        = map(map(string))
}

variable "rpg_params" {
  description = "The parameters for the DRG"
  type = list(object({
    compartment_name   = string
    vcn_name_requestor = string
    vcn_name_acceptor  = string
  }))
}

variable "tenancy_id" {}
variable "requestor_region" {}
variable "requestor_user_id" {}
variable "requestor_fingerprint" {}
variable "requestor_private_key_path" {}
variable "requestor_private_key_password" {}
variable "acceptor_region" {}
variable "acceptor_user_id" {}
variable "acceptor_fingerprint" {}
variable "acceptor_private_key_path" {}
variable "acceptor_private_key_password" {}

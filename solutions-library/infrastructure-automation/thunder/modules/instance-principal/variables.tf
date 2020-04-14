// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.
variable "instance_principal_params" {
  type = map(object({
    dg_description      = string
    dg_name             = string
    policy_description  = string
    policy_name         = string
    instance_name       = string
  }))
}

variable "instances" {
  type = map(string)
}

variable "auth_provider" {
  type = map(string)
}

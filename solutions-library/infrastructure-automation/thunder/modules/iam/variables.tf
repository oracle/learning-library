// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.
variable "comp_params" {
  type = map(object({
    name          = string
    description   = string
    enable_delete = bool
  }))
}

variable "user_params" {
  type = map(object({
    name          = string
    description   = string
    group_name    = string
  }))
}

variable "group_params" {
  type = map(object({
    name          = string
    description   = string
  }))
}

variable "policy_params" {
  type = map(object({
    name           = string
    description    = string
    statements     = list(string)
  }))
}

variable "auth_provider" {
  type = map(string)
}

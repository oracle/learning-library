# Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.

variable "provider_oci" {
  type = map(string)
}

variable "compartment_ids" {
  type = map(string)
}

variable "subnet_ids" {
  type = map(string)
}

variable "images" {
  type = map(string)
}

variable "backend_sets" {
  type = map(string)
}

variable "load_balancer_ids" {
  type = map(string)
}

variable "asg_params" {
  type = map(object({
    compartment_name = string
    name             = string
    freeform_tags    = map(string)
    shape            = string
    assign_public_ip = bool
    ssh_public_key   = string
    hostname         = string
    size             = number
    state            = string # Can be RUNNING or STOPPED
    p_config         = list(object({
      ad     = number
      subnet = string
    }))
    lb_config        = list(object({
      backend_set_name = string
      lb_name          = string
      lb_port          = number
    }))
    policy_name      = string
    initial_capacity = number
    max_capacity     = number
    min_capacity     = number
    policy_type      = string
    rules            = list(object({
      rule_name    = string
      action_type  = string
      action_value = number # Negative number for scale down, Positive number for scale up
      metrics      = list(object({
        metric_type     = string
        metric_operator = string # GT, GTE, LT, LTE
        threshold_value = number
      }))
    }))
    cool_down_in_seconds   = number
    is_autoscaling_enabled = bool
  }))
}
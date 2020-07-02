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

variable "function_ids" {
  type = map(string)
}

variable "apigw_params" {
  type = map(object({
    compartment_name = string
    subnet_name      = string
    display_name     = string
    endpoint_type    = string
  }))
}

variable "gwdeploy_params" {
  description = "API Gateway Deployment Params"
  type = map(object({
    compartment_name = string
    gateway_name     = string
    display_name     = string
    path_prefix      = string
    access_log       = bool
    exec_log_lvl     = string
    function_routes = list(object({
      type          = string
      path          = string
      methods       = list(string)
      function_name = string
    }))
    http_routes = list(object({
      type            = string
      path            = string
      methods         = list(string)
      url             = string
      connect_timeout = number
      ssl_verify      = bool
      read_timeout    = number
      send_timeout    = number
    }))
    stock_routes = list(object({
      type    = string
      path    = string
      methods = list(string)
      status  = number
      body    = string
      headers = list(object({
        name  = string
        value = string
      }))
    }))
  }))
}

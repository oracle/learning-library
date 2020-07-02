// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.
output "gateways" {
  value = module.api-gateway.gateways
}

output "deployments" {
  value = module.api-gateway.deployments
}

output "api_endpoints" {
  value = module.api-gateway.routes
}
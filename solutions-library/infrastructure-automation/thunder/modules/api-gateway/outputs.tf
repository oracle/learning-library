// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.

output "gateways" {
  value = {
    for gw in oci_apigateway_gateway.this :
    gw.display_name => { "compartment_id" : gw.compartment_id, "ocid" : gw.id, "subnet" : gw.subnet_id }
  }
}

output "deployments" {
  value = {
    for dpl in oci_apigateway_deployment.this :
    dpl.display_name => { "ocid" : dpl.id, "Invoke endpoint" : dpl.endpoint }
  }
}

#output that concatenates the endpoint with the path
output "routes" {
  value = flatten([
    for d in oci_apigateway_deployment.this :
    flatten(formatlist("%s%s", d.endpoint, flatten(d.specification[*].routes[*].path)))
  ])
}




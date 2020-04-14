// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.

output "grafana_instance" {
  value = module.grafana.grafana_instance
}

output "grafana_connection_url" {
  value = module.grafana.grafana_connection_url
}
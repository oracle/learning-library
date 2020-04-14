// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.
resource "oci_load_balancer" "this" {
  for_each       = var.lb_params
  shape          = each.value.shape
  compartment_id = var.compartment_ids[each.value.compartment_name]
  subnet_ids     = [for index in each.value.subnet_names: var.subnet_ids[index]]
  display_name   = each.value.display_name
  is_private     = each.value.is_private
}


resource "oci_load_balancer_backendset" "this" {
  for_each         = var.backend_sets
  name             = each.value.name
  load_balancer_id = oci_load_balancer.this[each.value.lb_name].id
  policy           = each.value.policy
  health_checker {
    port                = each.value.hc_port
    protocol            = each.value.hc_protocol
    url_path            = each.value.hc_url
  }
}

resource "oci_load_balancer_listener" "this" {
  for_each                 = var.listeners
  load_balancer_id         = oci_load_balancer.this[each.value.lb_name].id
  name                     = each.value.name
  default_backend_set_name = oci_load_balancer_backendset.this[each.value.backend_set_name].name
  port                     = each.value.port
  protocol                 = each.value.protocol

  dynamic "ssl_configuration" {
    iterator = ssl

    for_each = each.value.ssl

    content {
      certificate_name        = ssl.value.cert_name
      verify_peer_certificate = ssl.value.verify_peer_cert
    }
  }
}

resource "oci_load_balancer_certificate" "this" {
  for_each           = var.certificates
  certificate_name   = each.value.name
  load_balancer_id   = oci_load_balancer.this[each.value.lb_name].id
  private_key        = file(each.value.private_key_path)
  public_certificate = file(each.value.public_key_path)
  passphrase         = each.value.passphrase != null ? each.value.passphrase : ""

  // The certificate name has to be changed if the certificate data has changed or it will trigger a name conflict
  lifecycle {
    create_before_destroy = true
  }
}

resource "oci_load_balancer_backend" "this" {
  for_each         = var.backend_params
  backendset_name  = oci_load_balancer_backendset.this[each.value.backendset_name].name
  ip_address       = each.value.use_instance ? var.private_ip_instances[each.value.instance_name] : oci_load_balancer.this[each.value.lb_backend_name].ip_address_details.ip_address
  load_balancer_id = oci_load_balancer.this[each.value.lb_name].id
  port             = each.value.port
}

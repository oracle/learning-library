# Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.

data "oci_identity_availability_domains" "ads" {
  compartment_id = var.compartment_ids[var.asg_params[keys(var.asg_params)[0]].compartment_name]
}

resource oci_core_instance_configuration this {
  for_each       = var.asg_params
  compartment_id = var.compartment_ids[each.value.compartment_name]
  display_name   = each.value.name
  freeform_tags  = each.value.freeform_tags

  instance_details {
    instance_type = "compute"

    launch_details {
      compartment_id = var.compartment_ids[each.value.compartment_name]
      shape          = each.value.shape
      display_name   = each.value.name

      create_vnic_details {
        assign_public_ip       = each.value.assign_public_ip
      }

      source_details {
        source_type = "image"
        image_id    = var.images[var.region]
      }

      metadata = {
        ssh_authorized_keys = file(each.value.ssh_public_key)
      }
    }
  }

}

resource oci_core_instance_pool this {
  for_each                  = var.asg_params
  compartment_id            = oci_core_instance_configuration.this[each.value.name].compartment_id
  instance_configuration_id = oci_core_instance_configuration.this[each.value.name].id
  size                      = each.value.size
  state                     = each.value.state
  display_name              = each.value.name

  dynamic "placement_configurations" {
    iterator            = pc
    for_each            = each.value.p_config
    content {
      availability_domain = data.oci_identity_availability_domains.ads.availability_domains[pc.value.ad -1].name
      primary_subnet_id   = var.subnet_ids[pc.value.subnet]
    }
  }

  dynamic "load_balancers" {
    iterator         = lb
    for_each         = each.value.lb_config
    content {
      backend_set_name = var.backend_sets[lb.value.backend_set_name].name
      load_balancer_id = var.load_balancer_ids[lb.value.lb_name].id
      port             = lb.value.lb_port
      vnic_selection   = "PrimaryVnic"
    }
  }
}

resource oci_autoscaling_auto_scaling_configuration this {
  for_each       = var.asg_params
  compartment_id = oci_core_instance_configuration.this[each.value.name].compartment_id
  auto_scaling_resources {
    id   = oci_core_instance_pool.this[each.value.name].id
    type = "instancePool"
  }
  freeform_tags  = each.value.freeform_tags
  policies {
    display_name = each.value.policy_name
    capacity {
      initial = each.value.initial_capacity
      max     = each.value.max_capacity
      min     = each.value.min_capacity
    }
    policy_type = each.value.policy_type

    dynamic "rules" {
      iterator = rules
      for_each = each.value.rules
      content {
        action {
          type  = rules.value.action_type
          value = rules.value.action_value
        }
        display_name = rules.value.rule_name
        dynamic "metric" {
          iterator = metric
          for_each = rules.value.metrics
          content {
            metric_type = metric.value.metric_type
            threshold {
              operator = metric.value.metric_operator
              value    = metric.value.threshold_value
            }
          }
        }
      }
    }
  }
  cool_down_in_seconds = each.value.cool_down_in_seconds
  display_name         = each.value.name
  is_enabled           = each.value.is_autoscaling_enabled
}
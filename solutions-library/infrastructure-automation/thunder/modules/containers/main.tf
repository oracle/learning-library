
data "oci_identity_availability_domains" "ads" {
  compartment_id = var.compartment_ids[var.cluster_params[keys(var.cluster_params)[0]].compartment_name]
}

resource "oci_containerengine_cluster" "k8s_cluster" {
  for_each           = var.cluster_params
  compartment_id     = var.compartment_ids[each.value.compartment_name]
  kubernetes_version = each.value.kubernetes_version
  kms_key_id         = each.value.use_encryption == true ? each.value.kms_key_id : null
  name               = each.value.cluster_name
  vcn_id             = var.vcn_ids[each.value.vcn_name]

  options {
    add_ons {
      is_kubernetes_dashboard_enabled = each.value.is_kubernetes_dashboard_enabled
      is_tiller_enabled               = each.value.is_tiller_enabled
    }

    kubernetes_network_config {
      pods_cidr     = each.value.pods_cidr
      services_cidr = each.value.services_cidr
    }

    service_lb_subnet_ids = [for key, value in var.subnet_ids : value if contains(each.value.service_lb_subnet_names, key)]
  }
}

resource "oci_containerengine_node_pool" "nodepool" {
  for_each       = var.nodepools_params
  compartment_id = var.compartment_ids[each.value.compartment_name]
  cluster_id     = oci_containerengine_cluster.k8s_cluster[each.value.cluster_name].id

  kubernetes_version = oci_containerengine_cluster.k8s_cluster[each.value.cluster_name].kubernetes_version
  name               = each.value.pool_name

  node_config_details {
      dynamic "placement_configs" {
      iterator = pc
      for_each = each.value.placement_configs
      content {
        availability_domain = data.oci_identity_availability_domains.ads.availability_domains[pc.value.ad - 1].name
        subnet_id           = var.subnet_ids[each.value.subnet_name]
      }
    }
    size = each.value.size
  }

  node_source_details {
    image_id    = var.linux_images[var.region]
    source_type = "image"
  }

  node_shape     = each.value.node_shape
  ssh_public_key = file(each.value.ssh_public_key)
}

locals {

  cluster_ids = {
    for oke in oci_containerengine_cluster.k8s_cluster :
    oke.name => oke.id
  }

  kubernetes_versions = {
    for oke in oci_containerengine_cluster.k8s_cluster :
    oke.name => oke.kubernetes_version
  }

  pods_cidrs = {
    for oke in oci_containerengine_cluster.k8s_cluster :
    oke.name => oke.options[0].kubernetes_network_config[0].pods_cidr
  }

  # map {oke.name => number_of_nodes} where we have number_of_nodes = sum(nodepool_i.size)
  number_of_nodes_list = {
    for oke in oci_containerengine_cluster.k8s_cluster :
    oke.name => [for nodepool in oci_containerengine_node_pool.nodepool : nodepool.node_config_details[0].size if nodepool.cluster_id == oke.id]
  }
  number_of_nodes = {
    for okename, list_sizes in local.number_of_nodes_list :
    okename => length(flatten([for e in list_sizes : range(e)]))
  }
}

output "cluster_ids" {
  value = local.cluster_ids
}

output "kubernetes_versions" {
  value = local.kubernetes_versions
}

output "pods_cidrs" {
  value = local.pods_cidrs
}

output "number_of_nodes" {
  value = local.number_of_nodes
}

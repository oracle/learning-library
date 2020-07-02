
output "cluster_ids" {
  value = module.oke.cluster_ids
}

output "pods_cidrs" {
  value = module.oke.pods_cidrs
}

output "number_of_nodes" {
  value = module.oke.number_of_nodes
}

# output "kubeconfig" {
#   value = module.okeadmin.kubeconfig
# }

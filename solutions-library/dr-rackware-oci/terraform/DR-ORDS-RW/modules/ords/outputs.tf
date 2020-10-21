output "InstancePrivateIP" {
  value = oci_core_instance.ORDS-Comp-Instance.private_ip
}

output "InstancePublicIP" {
  value = oci_core_instance.ORDS-Comp-Instance.public_ip
}


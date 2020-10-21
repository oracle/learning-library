resource "oci_core_instance" "ORDS-Comp-Instance" {
  availability_domain = var.availability_domain
  compartment_id      = var.compartment_id
  display_name        = var.display_name
  shape               = var.shape


  create_vnic_details {
    hostname_label = var.hostname_label
    subnet_id      = var.subnet_id
  }

  metadata = {
    ssh_authorized_keys = var.ssh_public_key
    user_data           = base64encode(file(var.BootStrapFile))
  }

  source_details {
    source_id   = var.source_id
    source_type = "image"
  }

  timeouts {
    create = "60m"
  }
}

// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.

data "oci_identity_availability_domains" "ads" {
  compartment_id = var.instance_params.compartment_id
}

resource "oci_core_instance" "this" {
  availability_domain  = data.oci_identity_availability_domains.ads.availability_domains[var.instance_params.ad -1].name
  compartment_id       = var.instance_params.compartment_id
  shape                = var.instance_params.shape
  display_name         = var.instance_params.hostname
  preserve_boot_volume = var.instance_params.preserve_boot_volume

  create_vnic_details {
    assign_public_ip = true
    subnet_id        = var.instance_params.subnet_id
    hostname_label   = var.instance_params.hostname
  }

  source_details {
    boot_volume_size_in_gbs = var.instance_params.boot_volume_size
    source_type             = var.instance_params.source_type
    source_id               = var.images[var.home_region]
  }

  metadata = {
    ssh_authorized_keys = file(var.ssh_public_key)
    user_data           = base64encode(data.template_file.grafana_template.rendered)
  }
}

provider "oci" {
  alias            = "home"
  tenancy_ocid     = var.auth_provider.tenancy
  user_ocid        = var.auth_provider.user_id
  fingerprint      = var.auth_provider.fingerprint
  private_key_path = var.auth_provider.key_file_path
  region           = var.home_region
}
resource "oci_identity_dynamic_group" "instance_principal_dg" {
  compartment_id = var.auth_provider.tenancy
  description    = var.instance_principal_params.dg_description
  matching_rule  = "instance.id = 'oci_core_instance.this.id'"
  name           = var.instance_principal_params.dg_name
}

resource "oci_identity_policy" "instance_principal_policy" {
  compartment_id = var.auth_provider.tenancy
  description    = var.instance_principal_params.policy_description
  name           = var.instance_principal_params.policy_name
  statements     = ["Allow dynamic-group ${oci_identity_dynamic_group.instance_principal_dg.name} to read metrics in tenancy", "Allow dynamic-group ${oci_identity_dynamic_group.instance_principal_dg.name} to read compartments in tenancy"]
}

data "template_file" "tenancy_template" {
  template = file("${path.module}/../../userdata/oci.yaml")

  vars = {
    defaultRegion = var.home_region
    tenancyOCID   = var.auth_provider.tenancy
  }
}

data "template_file" "grafana_template" {
  template = file("${path.module}/../../userdata/grafana.sh")
}

resource "null_resource" "install_grafana" {
  provisioner "remote-exec" {
    when = create

    inline = ["sleep 200",
      "sudo su -c 'echo \"${data.template_file.tenancy_template.rendered}\" > /etc/grafana/provisioning/datasources/oci.yaml'",
      "sudo systemctl restart grafana-server",
    ]

    connection {
      type        = "ssh"
      user        = "opc"
      host        = oci_core_instance.this.public_ip
      private_key = file(var.ssh_private_key)
      agent       = false
    }
  }
}

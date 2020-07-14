variable "tenancy_ocid" {}
variable "region" {}
variable "public_subnet_id" {}
variable "display_name" {}
variable "AD" {
  default = 1
  }
variable "image_id" {
  default="ocid1.image.oc1.iad.aaaaaaaauwpipy7yex62fvqix7a7ipdzdhc6pdz57vkowvc4jhkfrazm6bwa"
  }
variable "instance_shape" {
  default = "VM.Standard2.1"
  }
variable "compartment_ocid" {}
variable "ssh_public_key" {}
variable "num_instances" {
  default = "1"
  }

terraform {required_version = ">= 0.12.0"}
data "oci_identity_availability_domains" "ADs" {
    compartment_id = "${var.tenancy_ocid}"
}

provider "oci" {
  tenancy_ocid     = "${var.tenancy_ocid}"
  region           = "${var.region}"
}

# Defines the number of instances to deploy

resource "oci_core_instance" "vminstance" {
  count               = "${var.num_instances}"
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[var.AD - 1], "name")}"
  compartment_id      = "${var.compartment_ocid}"
  display_name        = "${var.display_name}"
  shape               = "${var.instance_shape}"

  create_vnic_details {
    subnet_id        = "${var.public_subnet_id}"
    display_name     = "Primaryvnic"
    assign_public_ip = true
    hostname_label   = "vminstance-${var.display_name}"
  }

  source_details {
    source_type = "image"
    source_id   = "${var.image_id}"
    //source_id   = "${var.instance_image_ocid[var.region]}"


  }

metadata = {
    ssh_authorized_keys = "${var.ssh_public_key}"
  }

timeouts {
    create = "60m"
  }
}

variable "tenancy_ocid" {}
#variable "user_ocid" {}
#variable "fingerprint" {}
#variable "private_key_path" {}
variable "region" {}
variable "public_subnet_id" {}
variable "display_name" {}
variable "AD" {default = 1}
variable "Image-Id" {default="ocid1.image.oc1..aaaaaaaat3a7crj3xn2dbqshdbxo4eiwtlqaqu5ozdzmf2os352n4cj2s2xa"}

variable "instance_shape" {
  default = "VM.Standard2.2"
}

variable "compartment_ocid" {}
variable "ssh_public_key" {}
//variable "ssh_private_key" {}

terraform {
  required_version = ">= 0.12.0"
}

data "oci_identity_availability_domains" "ADs" {
    compartment_id = "${var.tenancy_ocid}"
}

provider "oci" {
  tenancy_ocid     = "${var.tenancy_ocid}"
  # user_ocid        = "${var.user_ocid}"
  # fingerprint      = "${var.fingerprint}"
  # private_key_path = "${var.private_key_path}"
  region           = "${var.region}"
}

# Defines the number of instances to deploy
variable "num_instances" {
  default = "1"
}
/*
Hard coding image-id - Map not working with Resource Manager
variable "instance_image_ocid" {
  type = "map"

  default = {
    # See https://docs.us-phoenix-1.oraclecloud.com/images/
    # Oracle-provided image "Oracle-Linux-7.5-2018.10.16-0"
    us-ashburn-1   = "ocid1.image.oc1..aaaaaaaat3a7crj3xn2dbqshdbxo4eiwtlqaqu5ozdzmf2os352n4cj2s2xa"
    eu-frankfurt-1 = "ocid1.image.oc1..aaaaaaaat3a7crj3xn2dbqshdbxo4eiwtlqaqu5ozdzmf2os352n4cj2s2xa"
    uk-london-1    = "ocid1.image.oc1..aaaaaaaat3a7crj3xn2dbqshdbxo4eiwtlqaqu5ozdzmf2os352n4cj2s2xa"
  }
}
*/

resource "oci_core_instance" "dbroadshow_instance" {
  count               = "${var.num_instances}"
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[var.AD - 1], "name")}"
  compartment_id      = "${var.compartment_ocid}"
 // display_name        = "dproadshow-compute-${count.index}"
  display_name        = "${var.display_name}"
  shape               = "${var.instance_shape}"

  create_vnic_details {
    subnet_id        = "${var.public_subnet_id}"
    display_name     = "Primaryvnic"
    assign_public_ip = true
    hostname_label   = "dbroadshow-${count.index}-${var.display_name}"
  }

  source_details {
    source_type = "image"
    source_id   = "${var.Image-Id}"

  }

  metadata = {
    ssh_authorized_keys = "${var.ssh_public_key}"
  }
}

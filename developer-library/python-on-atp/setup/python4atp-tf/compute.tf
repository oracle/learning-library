
resource "oci_core_instance" "developer_instance" {
  availability_domain = "${data.oci_identity_availability_domain.ad.name}"
  compartment_id      = "${oci_identity_compartment.python4dev.id}"
  display_name        = "${var.instance_display_name}"
  shape               = "${var.instance_shape}"

  metadata = {
    ssh_authorized_keys = "${var.ssh_public_key}" /* add path to public ssh key */
  }

  source_details {
    source_type = "image"
    source_id   = "${lookup(data.oci_core_app_catalog_subscriptions.CloudDevImg_catalog_subscriptions.app_catalog_subscriptions[0], "listing_resource_id")}"
  }

  create_vnic_details {
    assign_public_ip = true
    display_name     = "primaryVnic"
    subnet_id        = "${oci_core_subnet.test_subnet.id}"
    hostname_label   = "instance"
  }
}

resource "oci_core_vcn" "py4devvcn" {
  cidr_block = "10.0.0.0/16"
  dns_label = "${var.vcn_display_name}"
  compartment_id = "${oci_identity_compartment.python4dev.id}"
  display_name = "${var.vcn_display_name}"
}

resource "oci_core_internet_gateway" "internet_gateway" {
    #Required
    compartment_id = "${oci_identity_compartment.python4dev.id}"
    vcn_id = "${oci_core_vcn.py4devvcn.id}"

    #Optional
    display_name = "${var.internet_gateway_display_name}"
}

resource "oci_core_default_route_table" "default-route-table-options" {
  manage_default_resource_id = "${oci_core_vcn.py4devvcn.default_route_table_id}"

route_rules {
  #Required
  network_entity_id = "${oci_core_internet_gateway.internet_gateway.id}"

  #Optional
  cidr_block = "0.0.0.0/0"
  }
}

resource "oci_core_subnet" "test_subnet" {
  availability_domain = "${data.oci_identity_availability_domain.ad.name}"
  cidr_block          = "10.0.2.0/24"
  display_name        = "${var.subnet_display_name}"
  dns_label           = "p4dsubnet"
  security_list_ids   = ["${oci_core_security_list.securitylist1.id}"]
  compartment_id      = "${oci_identity_compartment.python4dev.id}"
  vcn_id              = "${oci_core_vcn.py4devvcn.id}"
  route_table_id      = "${oci_core_vcn.py4devvcn.default_route_table_id}"
  dhcp_options_id     = "${oci_core_vcn.py4devvcn.default_dhcp_options_id}"
}

resource "oci_core_security_list" "securitylist1" {
  display_name   = "securitylist1"
  compartment_id = "${oci_identity_compartment.python4dev.id}"
  vcn_id         = "${oci_core_vcn.py4devvcn.id}"

  egress_security_rules {
    protocol    = "all"
    destination = "0.0.0.0/0"
  }

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      min = 22
      max = 22
    }
  }

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      min = 5901
      max = 5901
    }
  }
}

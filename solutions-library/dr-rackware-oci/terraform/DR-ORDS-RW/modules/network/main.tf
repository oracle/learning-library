// Copyright (c) 2019, Oracle and/or its affiliates. All rights reserved.
// Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.

/*
 * Create the VCN and related resources.
 */

provider oci {
  alias = "destination"
}

# Availability Domains
data oci_identity_availability_domains AD {
  provider       = oci.destination
  compartment_id = var.tenancy_ocid
}

locals {
  // VCN is /16
  vcn_subnet_cidr_offset = 8
  bastion_subnet_prefix  = "${cidrsubnet("${var.vcn_cidr_block}", local.vcn_subnet_cidr_offset, 0)}"
  db_subnet_prefix       = "${cidrsubnet("${var.vcn_cidr_block}", local.vcn_subnet_cidr_offset, 4)}"
}

/*
 * Create the VCN and related resources.
 */

# VCN
resource oci_core_vcn dr_vcn {
  provider = oci.destination

  compartment_id = var.compartment_id
  display_name   = var.vcn_name
  dns_label      = var.dns_label
  cidr_block     = var.vcn_cidr_block
  defined_tags   = var.defined_tags
  freeform_tags  = var.freeform_tags
}

# Internet Gateway
resource oci_core_internet_gateway dr_igw {
  provider       = oci.destination
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.dr_vcn.id
  display_name   = var.igw_name
  defined_tags   = var.defined_tags
  freeform_tags  = var.freeform_tags
}

# NAT Gateway
resource oci_core_nat_gateway dr_nat {
  provider       = oci.destination
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.dr_vcn.id
  display_name   = var.nat_name
  defined_tags   = var.defined_tags
  freeform_tags  = var.freeform_tags
}

data "oci_core_services" "dr_services" {
  provider = oci.destination
  filter {
    name   = "name"
    values = ["All .* Services In Oracle Services Network"]
    regex  = true
  }
}

# Service Gateway
resource "oci_core_service_gateway" "dr_service_gateway" {
  provider = oci.destination
  #Required
  compartment_id = var.compartment_id

  services {
    service_id = lookup(data.oci_core_services.dr_services.services[0], "id")
  }

  vcn_id       = oci_core_vcn.dr_vcn.id
  display_name = var.sgw_name
}

# Dynamic Routing Gateway
resource "oci_core_drg" "dr_drg" {
  depends_on = [oci_core_vcn.dr_vcn]

  provider       = oci.destination
  compartment_id = var.compartment_id

  display_name  = var.drg_name
  defined_tags  = var.defined_tags
  freeform_tags = var.freeform_tags
}

# Attachmennt of Dynamic Routing Gateway
resource "oci_core_drg_attachment" "dr_drg_attachment" {
  depends_on = [oci_core_vcn.dr_vcn, oci_core_drg.dr_drg]

  provider = oci.destination

  drg_id = oci_core_drg.dr_drg.id
  vcn_id = oci_core_vcn.dr_vcn.id

  display_name = var.drg_attachment_name
}

# Route Table for the lb subnet with IGW
resource oci_core_route_table public_route_table {
  provider       = oci.destination
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.dr_vcn.id
  display_name   = var.public_rte_name
  defined_tags   = var.defined_tags
  freeform_tags  = var.freeform_tags

  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_internet_gateway.dr_igw.id
  }
}

# Ping port uses across all VNICS: 
resource oci_core_network_security_group ping_all {
  provider       = oci.destination
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.dr_vcn.id
  display_name   = "ping_all"
}

resource "oci_core_network_security_group_security_rule" "ping_all" {
  provider                  = oci.destination
  network_security_group_id = oci_core_network_security_group.ping_all.id

  description = "Ping across all instances"
  direction   = "INGRESS"
  protocol    = 1
  source_type = "CIDR_BLOCK"
  source      = "0.0.0.0/0"
}

# Route Table for the subnet with NAT
resource oci_core_route_table private_route_table {
  provider       = oci.destination
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.dr_vcn.id
  display_name   = var.private_rte_name
  defined_tags   = var.defined_tags
  freeform_tags  = var.freeform_tags

  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_nat_gateway.dr_nat.id
  }

  # Route to peering network
  route_rules {
    destination_type  = "CIDR_BLOCK"
    destination       = var.remote_app_vcn_cidr
    network_entity_id = oci_core_drg.dr_drg.id
  }

  # Route to service gateway network
  route_rules {
    destination_type  = "SERVICE_CIDR_BLOCK"
    destination       = lookup(data.oci_core_services.dr_services.services[0], "cidr_block")
    network_entity_id = oci_core_service_gateway.dr_service_gateway.id
  }
}


# Network Security List for the Access (bastion) Subnet
resource oci_core_security_list access_security_list {
  provider       = oci.destination
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.dr_vcn.id
  display_name   = "access_security_list"
  defined_tags   = var.defined_tags
  freeform_tags  = var.freeform_tags

  // allow outbound tcp traffic on all ports
  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "6"
  }

  // allow inbound icmp traffic of a specific type
  ingress_security_rules {
    protocol = 1
    source   = "0.0.0.0/0"
  }

  // allow inbound HTTP traffic
  ingress_security_rules {
    tcp_options {
      min = "80"
      max = "80"
    }
    protocol = "6"
    source   = "0.0.0.0/0"
  }

  // allow inbound HTTP traffic
  ingress_security_rules {
    tcp_options {
      min = "443"
      max = "443"
    }
    protocol = "6"
    source   = "0.0.0.0/0"
  }

  // allow ords traffic
  ingress_security_rules {
    tcp_options {
      min = var.com_port
      max = var.com_port
    }
    protocol = "6"
    source   = "0.0.0.0/0"
  }
}

# Network Security List for the Database Subnet
resource oci_core_security_list dr_database_sec_list {
  provider       = oci.destination
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.dr_vcn.id
  display_name   = "dr_db_sec_list"
  defined_tags   = var.defined_tags
  freeform_tags  = var.freeform_tags

  // allow outbound tcp traffic on all ports
  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "6"
  }

  // allow inbound HTTP traffic
  ingress_security_rules {
    tcp_options {
      min = "1521"
      max = "1522"
    }
    protocol = "6"
    source   = var.vcn_cidr_block
  }

  // allow inbound HTTP traffic
  ingress_security_rules {
    tcp_options {
      min = "1521"
      max = "1522"
    }
    protocol = "6"
    source   = var.remote_app_vcn_cidr
  }

  // allow ords traffic
  ingress_security_rules {
    tcp_options {
      min = var.com_port
      max = var.com_port
    }
    protocol = "6"
    source   = "0.0.0.0/0"
  }
}

/*
 * SUBNETS
 */

# Access (bastion) Subnet
resource oci_core_subnet access_subnet {
  provider       = oci.destination
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.dr_vcn.id
  display_name   = var.access_subnet_name
  dns_label      = var.access_subnet_dns_label
  cidr_block     = local.bastion_subnet_prefix
  route_table_id = oci_core_route_table.public_route_table.id
  security_list_ids = [
    oci_core_vcn.dr_vcn.default_security_list_id,
    oci_core_security_list.access_security_list.id
  ]
  defined_tags  = var.defined_tags
  freeform_tags = var.freeform_tags
}

# dr db Subnet
resource oci_core_subnet db_subnet {
  provider       = oci.destination
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.dr_vcn.id
  display_name   = var.db_subnet_name
  dns_label      = var.db_subnet_dns_label
  cidr_block     = local.db_subnet_prefix
  route_table_id = oci_core_route_table.private_route_table.id
  security_list_ids = [
    oci_core_vcn.dr_vcn.default_security_list_id,
    oci_core_security_list.dr_database_sec_list.id
  ]
  prohibit_public_ip_on_vnic = true
  defined_tags               = var.defined_tags
  freeform_tags              = var.freeform_tags
}

# create remote peering connection
resource "oci_core_remote_peering_connection" "dr_remote_peering_connection" {
  count = var.create_remote_peering ? 1 : 0

  depends_on = [oci_core_vcn.dr_vcn, oci_core_drg.dr_drg, oci_core_drg_attachment.dr_drg_attachment]
  provider   = oci.destination

  compartment_id = var.compartment_id
  drg_id         = oci_core_drg.dr_drg.id
}

# create and setup remote peering connection
resource "oci_core_remote_peering_connection" "dr_remote_peering_setup" {
  count = var.create_remote_peering ? 0 : 1

  depends_on = [oci_core_vcn.dr_vcn, oci_core_drg.dr_drg, oci_core_drg_attachment.dr_drg_attachment]
  provider   = oci.destination

  compartment_id = var.compartment_id
  drg_id         = oci_core_drg.dr_drg.id

  display_name     = var.peering_name
  peer_id          = var.remote_peering_connection_id
  peer_region_name = var.remote_peering_connection_peer_region_name
}

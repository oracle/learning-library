// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.

provider "oci" {
  alias                = "requestor"
  region               = var.requestor_region
  tenancy_ocid         = var.tenancy_id
  user_ocid            = var.requestor_user_id
  fingerprint          = var.requestor_fingerprint
  private_key_path     = var.requestor_private_key_path
  private_key_password = var.requestor_private_key_password
}

provider "oci" {
  alias                = "acceptor"
  region               = var.acceptor_region
  tenancy_ocid         = var.tenancy_id
  user_ocid            = var.acceptor_user_id
  fingerprint          = var.acceptor_fingerprint
  private_key_path     = var.acceptor_private_key_path
  private_key_password = var.acceptor_private_key_password
}

resource "oci_core_drg" "requestor_drg" {
  count          = var.requestor_region == var.acceptor_region ? 0 : 1
  provider       = oci.requestor
  compartment_id = var.compartment_ids[var.rpg_params[count.index].compartment_name]
}

resource "oci_core_drg_attachment" "requestor_drg_attachment" {
  count    = var.requestor_region == var.acceptor_region ? 0 : 1
  provider = oci.requestor
  drg_id   = oci_core_drg.requestor_drg[0].id
  vcn_id   = var.vcns[var.rpg_params[count.index].vcn_name_requestor].id
}

resource "oci_core_remote_peering_connection" "requestor" {
  count            = var.requestor_region == var.acceptor_region ? 0 : 1
  provider         = oci.requestor
  compartment_id   = var.compartment_ids[var.rpg_params[count.index].compartment_name]
  drg_id           = oci_core_drg.requestor_drg[0].id
  display_name     = "remotePeeringConnectionRequestor"
  peer_id          = oci_core_remote_peering_connection.acceptor[0].id
  peer_region_name = var.acceptor_region
}

resource "oci_core_drg" "acceptor_drg" {
  count          = var.requestor_region == var.acceptor_region ? 0 : 1
  provider       = oci.acceptor
  compartment_id = var.compartment_ids[var.rpg_params[count.index].compartment_name]
}

resource "oci_core_drg_attachment" "acceptor_drg_attachment" {
  count    = var.requestor_region == var.acceptor_region ? 0 : 1
  provider = oci.acceptor
  drg_id   = oci_core_drg.acceptor_drg[0].id
  vcn_id   = var.vcns2[var.rpg_params[count.index].vcn_name_acceptor].id
}

resource "oci_core_remote_peering_connection" "acceptor" {
  count          = var.requestor_region == var.acceptor_region ? 0 : 1
  provider       = oci.acceptor
  compartment_id = var.compartment_ids[var.rpg_params[count.index].compartment_name]
  drg_id         = oci_core_drg.acceptor_drg[0].id
  display_name   = "remotePeeringConnectionAcceptor"
}


###### Update the routing tables and security lists to allow/route traffic for the DRGs

resource "null_resource" "remote_peering_rt_sl_rules" {
  count      = var.requestor_region == var.acceptor_region ? 0 : 1
  depends_on = [oci_core_remote_peering_connection.requestor]

  provisioner "local-exec" {
    command = <<CMD
    python3 ../../../${path.root}/userdata/peering_rules.py \
    -req_compartment ${var.compartment_ids[var.rpg_params[count.index].compartment_name]} \
    -req_vcn_id ${var.vcns[var.rpg_params[count.index].vcn_name_requestor].id} \
    -req_drg ${oci_core_drg.requestor_drg[0].id} \
    -req_cidr ${var.vcns[var.rpg_params[count.index].vcn_name_requestor].cidr} \
    -acc_cidr ${var.vcns2[var.rpg_params[count.index].vcn_name_acceptor].cidr} \
    -acc_compartment ${var.compartment_ids[var.rpg_params[count.index].compartment_name]} \
    -acc_vcn_id ${var.vcns2[var.rpg_params[count.index].vcn_name_acceptor].id} \
    -acc_drg ${oci_core_drg.acceptor_drg[0].id} \
    -tfvars_file ${path.root}/${var.provider_path} \
    -action add
CMD

    when = create
  }
}

##### Remove the DRG rules from the routing tables and security lists

resource "null_resource" "remove_remote_peering_rt_sl_rules" {
  count      = var.requestor_region == var.acceptor_region ? 0 : 1
  depends_on = [oci_core_remote_peering_connection.requestor]

  provisioner "local-exec" {
    command = <<CMD
    python3 ../../../${path.root}/userdata/peering_rules.py \
    -req_compartment ${var.compartment_ids[var.rpg_params[count.index].compartment_name]} \
    -req_vcn_id ${var.vcns[var.rpg_params[count.index].vcn_name_requestor].id} \
    -req_drg ${oci_core_drg.requestor_drg[0].id} \
    -req_cidr ${var.vcns[var.rpg_params[count.index].vcn_name_requestor].cidr} \
    -acc_cidr ${var.vcns2[var.rpg_params[count.index].vcn_name_acceptor].cidr} \
    -acc_compartment ${var.compartment_ids[var.rpg_params[count.index].compartment_name]} \
    -acc_vcn_id ${var.vcns2[var.rpg_params[count.index].vcn_name_acceptor].id} \
    -acc_drg ${oci_core_drg.acceptor_drg[0].id} \
    -tfvars_file ${path.root}/${var.provider_path} \
    -action remove
CMD

    when = destroy
  }
}

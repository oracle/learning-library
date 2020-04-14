// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.
locals {
  linux_boot_volumes      = [for instance in var.instance_params : instance.boot_volume_size >= 50 ? null : file(format("\n\nERROR: The boot volume size for linux instance %s is less than 50GB which is not permitted. Please add a boot volume size of 50GB or more", instance.hostname))]
  windows_boot_volumes    = [for instance in var.win_instance_params : instance.boot_volume_size >= 256 ? null : file(format("\n\nERROR: The boot volume size for windows instance %s is less than 256GB which is not permitted. Please add a boot volume size of 256GB or more", instance.hostname))]
  linux_block_volumes     = [for block in var.bv_params : block.bv_size >= 50 && block.bv_size <= 32768 ? null : file(format("\n\nERROR: Block volume size %s for block volume %s should be between 50GB and 32768GB", block.bv_size, block.display_name))]
  windows_block_volumes   = [for block in var.win_bv_params : block.bv_size >= 50 && block.bv_size <= 32768 ? null : file(format("\n\nERROR: Block volume size %s for block volume %s should be between 50GB and 32768GB", block.bv_size, block.display_name))]
  block_performance       = {
    Low      = "0"
    Balanced = "10"
    High     = "20"
  }
}

data "oci_identity_availability_domains" "ads" {
  compartment_id = var.compartment_ids[var.instance_params[keys(var.instance_params)[0]].compartment_name]
}


data "template_file" "block_volumes_templates" {
  for_each = var.instance_params
  template = file("${path.module}/../../userdata/linux_mount.sh")

  vars = {
    length               = (length(split(" ", each.value.device_disk_mappings)) - 1)
    device_disk_mappings = each.value.device_disk_mappings
    block_vol_att_type   = each.value.block_vol_att_type
  }
}

data "template_cloudinit_config" "config" {
  for_each      = var.instance_params
  gzip          = false
  base64_encode = true

  # Main cloud-config configuration file.
  part {
    filename     = "cloudinit.sh"
    content_type = "text/x-shellscript"
    content      = data.template_file.block_volumes_templates[each.value.hostname].rendered
  }
}

resource "oci_core_instance" "this" {
  for_each                            = var.instance_params
  availability_domain                 = data.oci_identity_availability_domains.ads.availability_domains[each.value.ad - 1].name
  compartment_id                      = var.compartment_ids[each.value.compartment_name]
  shape                               = each.value.shape
  display_name                        = each.value.hostname
  preserve_boot_volume                = each.value.preserve_boot_volume
  freeform_tags                       = each.value.freeform_tags
  is_pv_encryption_in_transit_enabled = each.value.encrypt_in_transit
  fault_domain                        = format("FAULT-DOMAIN-%s", each.value.fd)


  create_vnic_details {
    assign_public_ip = each.value.assign_public_ip
    subnet_id        = var.subnet_ids[each.value.subnet_name]
    hostname_label   = each.value.hostname
    nsg_ids          = [for nsg in each.value.nsgs: var.nsgs[nsg]]
  }

  source_details {
    boot_volume_size_in_gbs = each.value.boot_volume_size
    source_type             = "image"
    source_id               = var.linux_images[var.region][each.value.image_version]
    kms_key_id              = length(var.kms_key_ids) == 0 || each.value.kms_key_name == "" ? "" : var.kms_key_ids[each.value.kms_key_name]
  }

  metadata = {
    ssh_authorized_keys = file(each.value.ssh_public_key)
    user_data           = data.template_cloudinit_config.config[each.value.hostname].rendered
  }
}

resource "oci_core_volume" "block" {
  for_each            = var.bv_params
  availability_domain = oci_core_instance.this[each.value.instance_name].availability_domain
  compartment_id      = oci_core_instance.this[each.value.instance_name].compartment_id
  display_name        = each.value.display_name
  size_in_gbs         = each.value.bv_size
  freeform_tags       = each.value.freeform_tags
  vpus_per_gb         = local.block_performance[each.value.performance]
  kms_key_id          = length(var.kms_key_ids) == 0 || each.value.kms_key_name == "" ? "" : var.kms_key_ids[each.value.kms_key_name]
}

resource "oci_core_volume_attachment" "attachment" {
  for_each                            = var.bv_params
  attachment_type                     = var.instance_params[each.value.instance_name].block_vol_att_type
  instance_id                         = oci_core_instance.this[each.value.instance_name].id
  volume_id                           = oci_core_volume.block[each.value.display_name].id
  device                              = each.value.device_name
  is_pv_encryption_in_transit_enabled = var.instance_params[each.value.instance_name].block_vol_att_type == "paravirtualized" ? each.value.encrypt_in_transit : false
}


# Generating random password
resource "random_string" "win_pass" {
  for_each = var.win_instance_params
  length   = 13
  special  = true
}

data "template_file" "win_block_volumes_templates" {
  for_each = var.win_instance_params
  template = file("${path.module}/../../userdata/win_mount.ps1")

  vars = {
    device_disk_mappings = each.value.device_disk_mappings
    block_vol_att_type   = each.value.block_vol_att_type
    password             = random_string.win_pass[each.value.hostname].result
    enable_admin         = each.value.enable_admin
  }
}

data "template_cloudinit_config" "win_config" {
  for_each      = var.win_instance_params
  gzip          = false
  base64_encode = true

  # Main cloud-config configuration file.
  part {
    filename     = "cloudinit.ps1"
    content_type = "text/x-shellscript"
    content      = data.template_file.win_block_volumes_templates[each.value.hostname].rendered
  }
}

resource "oci_core_instance" "win_this" {
  for_each                            = var.win_instance_params
  availability_domain                 = data.oci_identity_availability_domains.ads.availability_domains[each.value.ad - 1].name
  compartment_id                      = var.compartment_ids[each.value.compartment_name]
  shape                               = each.value.shape
  display_name                        = each.value.hostname
  preserve_boot_volume                = each.value.preserve_boot_volume
  freeform_tags                       = each.value.freeform_tags
  is_pv_encryption_in_transit_enabled = each.value.encrypt_in_transit
  fault_domain                        = format("FAULT-DOMAIN-%s", each.value.fd)


  create_vnic_details {
    assign_public_ip = each.value.assign_public_ip
    subnet_id        = var.subnet_ids[each.value.subnet_name]
    hostname_label   = each.value.hostname
    nsg_ids          = [for nsg in each.value.nsgs: var.nsgs[nsg]]
  }

  source_details {
    boot_volume_size_in_gbs = each.value.boot_volume_size
    source_type             = "image"
    source_id               = var.windows_images[var.region][each.value.image_version]
    kms_key_id              = length(var.kms_key_ids) == 0 || each.value.kms_key_name == "" ? "" : var.kms_key_ids[each.value.kms_key_name]
  }

  metadata = {
    user_data = data.template_cloudinit_config.win_config[each.value.hostname].rendered
  }
}

data "oci_core_instance_credentials" "windows_credentials" {
  for_each    = var.win_instance_params
  instance_id = oci_core_instance.win_this[each.value.hostname].id
}

resource "oci_core_volume" "win_block" {
  for_each            = var.win_bv_params
  availability_domain = oci_core_instance.win_this[each.value.instance_name].availability_domain
  compartment_id      = oci_core_instance.win_this[each.value.instance_name].compartment_id
  display_name        = each.value.display_name
  size_in_gbs         = each.value.bv_size
  freeform_tags       = each.value.freeform_tags
  kms_key_id          = length(var.kms_key_ids) == 0 || each.value.kms_key_name == "" ? "" : var.kms_key_ids[each.value.kms_key_name]
  vpus_per_gb         = local.block_performance[each.value.performance]
}

resource "oci_core_volume_attachment" "win_attachment" {
  for_each                            = var.win_bv_params
  attachment_type                     = var.win_instance_params[each.value.instance_name].block_vol_att_type
  instance_id                         = oci_core_instance.win_this[each.value.instance_name].id
  volume_id                           = oci_core_volume.win_block[each.value.display_name].id
  is_pv_encryption_in_transit_enabled = var.win_instance_params[each.value.instance_name].block_vol_att_type == "paravirtualized" ? each.value.encrypt_in_transit : false
}

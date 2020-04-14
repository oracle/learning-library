// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.
variable "provider_oci" {
  type = map(string)
}

variable "vcn_params" {
  description = "VCN Parameters: vcn_cidr, display_name, dns_label"
  type = map(object({
    vcn_cidr         = string
    compartment_name = string
    display_name     = string
    dns_label        = string
  }))
}

variable "compartment_ids" {
  type = map(string)
}

variable "igw_params" {
  description = "Placeholder for vcn index association and igw name"
  type = map(object({
    vcn_name     = string
    display_name = string
  }))
}

variable "ngw_params" {
  description = "Placeholder for vcn index association and ngw name"
  type = map(object({
    vcn_name     = string
    display_name = string
  }))
}

variable "rt_params" {
  description = "Placeholder for vcn index association, rt name, route rules"
  type = map(object({
    vcn_name     = string
    display_name = string
    route_rules = list(object({
      destination = string
      use_igw     = bool
      igw_name    = string
      ngw_name    = string
    }))
  }))
}

variable "sl_params" {
  description = "Security List Params"
  type = map(object({
    vcn_name     = string
    display_name = string
    egress_rules = list(object({
      stateless   = string
      protocol    = string
      destination = string
    }))
    ingress_rules = list(object({
      stateless   = string
      protocol    = string
      source      = string
      source_type = string
      tcp_options = list(object({
        min = number
        max = number
      }))
      udp_options = list(object({
        min = number
        max = number
      }))
    }))
  }))
}


variable "nsg_params" {
  type = map(object({
    vcn_name     = string
    display_name = string
  }))
}

variable "nsg_rules_params" {
  type = map(object({
    nsg_name         = string
    protocol         = string
    stateless        = string
    direction        = string
    source           = string
    source_type      = string
    destination      = string
    destination_type = string
    tcp_options = list(object({
      destination_ports = list(object({
        min = number
        max = number
      }))
      source_ports = list(object({
        min = number
        max = number
      }))
    }))
    udp_options = list(object({
      destination_ports = list(object({
        min = number
        max = number
      }))
      source_ports = list(object({
        min = number
        max = number
      }))
    }))
  }))
}


variable "subnet_params" {
  type = map(object({
    display_name      = string
    cidr_block        = string
    dns_label         = string
    is_subnet_private = bool
    sl_name           = string
    rt_name           = string
    vcn_name          = string
  }))
}

variable "lpg_params" {
  type = map(object({
    acceptor     = string
    requestor    = string
    display_name = string
  }))
}

variable "drg_params" {
  type = map(object({
    name     = string
    vcn_name = string
    cidr_rt  = string
    rt_names = list(string)
  }))
}

variable "linux_images" {
  type = map(map(string))
}

variable "instance_params" {
  description = "Placeholder for the parameters of the instances"
  type = map(object({
    ad                   = number
    shape                = string
    hostname             = string
    boot_volume_size     = number
    assign_public_ip     = bool
    preserve_boot_volume = bool
    compartment_name     = string
    subnet_name          = string
    ssh_public_key       = string
    device_disk_mappings = string
    freeform_tags        = map(string)
    kms_key_name         = string
    block_vol_att_type   = string
    encrypt_in_transit   = bool
    fd                   = number
    image_version        = string
    nsgs                 = list(string)
  }))
}

variable "bv_params" {
  description = "Placeholder the bv parameters"
  type = map(object({
    ad                 = number
    display_name       = string
    bv_size            = number
    instance_name      = string
    device_name        = string
    freeform_tags      = map(string)
    kms_key_name       = string
    performance        = string
    encrypt_in_transit = bool
  }))
}

variable "windows_images" {
  type = map(map(string))
}

variable "win_instance_params" {
  description = "Placeholder for windows instances"
  type = map(object({
    ad                   = number
    shape                = string
    hostname             = string
    boot_volume_size     = number
    assign_public_ip     = bool
    preserve_boot_volume = bool
    compartment_name     = string
    subnet_name          = string
    device_disk_mappings = string
    freeform_tags        = map(string)
    kms_key_name         = string
    block_vol_att_type   = string
    encrypt_in_transit   = bool
    enable_admin         = string # set this to yes if you want to enable the Administrator
    fd                   = number
    image_version        = string
    nsgs                 = list(string)
  }))
}

variable "win_bv_params" {
  description = "Placeholder for windows bv"
  type = map(object({
    ad                 = number
    display_name       = string
    bv_size            = number
    instance_name      = string
    freeform_tags      = map(string)
    kms_key_name       = string
    performance        = string
    encrypt_in_transit = bool
  }))
}

variable "ipsec_params" {
  type = map(object({
    comp_name      = string
    cpe_ip_address = string
    name           = string
    drg_name       = string
    static_routes  = list(string)
  }))
}


variable "cc_group" {
  type = map(object({
    comp_name = string
    name      = string
  }))
}

variable "cc" {
  type = map(object({
    comp_name             = string
    name                  = string
    location_name         = string
    port_speed_shape_name = string
    cc_group_name         = string
  }))
}

variable "private_vc_no_provider" {
  type = map(object({
    comp_name             = string
    name                  = string
    type                  = string
    bw_shape              = string
    cc_group_name         = string
    cust_bgp_peering_ip   = string
    oracle_bgp_peering_ip = string
    vlan                  = string
    drg                   = string
  }))
}

variable "private_vc_with_provider" {
  type = map(object({
    comp_name             = string
    name                  = string
    type                  = string
    bw_shape              = string
    cc_group_name         = string
    cust_bgp_peering_ip   = string
    oracle_bgp_peering_ip = string
    vlan                  = string
    drg                   = string
    private_service_id    = string
    private_service_key   = string
  }))
}

variable "public_vc_no_provider" {
  type = map(object({
    comp_name     = string
    name          = string
    type          = string
    bw_shape      = string
    cidr_block    = string
    cc_group_name = string
    vlan          = string
  }))
}

variable "public_vc_with_provider" {
  type = map(object({
    comp_name           = string
    name                = string
    type                = string
    bw_shape            = string
    cidr_block          = string
    cc_group_name       = string
    vlan                = string
    private_service_id  = string
    private_service_key = string
  }))
}

variable "kms_key_ids" {
  type = map(string)
}

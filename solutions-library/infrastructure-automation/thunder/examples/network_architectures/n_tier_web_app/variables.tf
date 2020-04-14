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

variable "database_params" {
  description = "The paramaters for the database"
  type = map(object({
    compartment_name        = string
    ad                      = number
    cpu_core_count          = number
    db_edition              = string
    db_admin_password       = string
    db_name                 = string
    db_workload             = string
    pdb_name                = string
    enable_auto_backup      = bool
    db_version              = string
    display_name            = string
    disk_redundancy         = string
    shape                   = string
    subnet_name             = string
    ssh_public_key          = string
    hostname                = string
    data_storage_size_in_gb = number
    license_model           = string
    node_count              = number
  }))
}

variable "lb_params" {
  type = map(object({
    shape            = string
    compartment_name = string
    subnet_names     = list(string)
    display_name     = string
    is_private       = bool
  }))
}

variable "backend_sets" {
  type = map(object({
    name        = string
    lb_name     = string
    policy      = string
    hc_port     = number
    hc_protocol = string
    hc_url      = string
  }))
}

# Using list(any) due to the fact that we have some optional parameters in the maps
variable "listeners" {
  type = map(any)
}

variable "certificates" {
  type = map(any)
}

variable "backend_params" {
  type = map(any)
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

variable "kms_key_ids" {
  type = map(string)
}

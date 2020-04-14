// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.
variable "database_params" {
  description = "The paramaters for the database"
  type        = map(object({
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

variable "compartment_ids" {
  type = map(string)
}

variable "subnet_ids" {
  type = map(string)
}

// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.

compartment_ids = {
  sandbox = "ocid1.compartment.oc1..aaaaaaaaiu3vfcpbjwwgpil3xakqts4jhtjq42kktmisriiszdvvouwsirgq"
}

subnet_ids      = {
  hur1pub = "ocid1.subnet.oc1.iad.aaaaaaaanqbpaze4zgpkk22uocphhwlqr2qkhql66bo66rqtx2ylqulvfbeq"
}

database_params = {
  hur1db = {
    compartment_name        = "sandbox"
    ad                      = 1
    cpu_core_count          = 2
    db_edition              = "ENTERPRISE_EDITION"
    db_name                 = "hur1db"
    db_admin_password       = "BEstrO0ng_#11"
    db_workload             = "OLTP"
    pdb_name                = "hur1pdb"
    enable_auto_backup      = true
    db_version              = "12.1.0.2"
    display_name            = "hur1db"
    disk_redundancy         = "HIGH"
    shape                   = "VM.Standard2.8"
    subnet_name             = "hur1pub"
    ssh_public_key          = "/root/.ssh/id_rsa.pub"
    hostname                = "hur1"
    data_storage_size_in_gb = 256
    license_model           = "BRING_YOUR_OWN_LICENSE"
    node_count              = 1
  },
  hur2db = {
    compartment_name        = "sandbox"
    ad                      = 1
    cpu_core_count          = 2
    db_edition              = "ENTERPRISE_EDITION_EXTREME_PERFORMANCE"
    db_name                 = "hur2db"
    db_admin_password       = "BEstrO0ng_#11"
    db_workload             = "OLTP"
    pdb_name                = "hur2pdb"
    enable_auto_backup      = true
    db_version              = "12.1.0.2"
    display_name            = "hur2db"
    disk_redundancy         = "NORMAL"
    shape                   = "VM.Standard2.8"
    subnet_name             = "hur1pub"
    ssh_public_key          = "/root/.ssh/id_rsa.pub"
    hostname                = "hur2"
    data_storage_size_in_gb = 256
    license_model           = "BRING_YOUR_OWN_LICENSE"
    node_count              = 1
  },
}

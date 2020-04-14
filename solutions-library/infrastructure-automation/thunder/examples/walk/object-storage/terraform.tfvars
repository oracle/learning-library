// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.

compartments = {
  sandbox = "ocid1.compartment.oc1..aaaaaaaaiu3vfcpbjwwgpil3xakqts4jhtjq42kktmisriiszdvvouwsirgq"
}

bucket_params = {
  hur-buck-1 = {
    compartment_name = "sandbox"
    name             = "hur-buck-1"
    access_type      = "NoPublicAccess"
    storage_tier     = "Standard"
    events_enabled   = false
    kms_key_name     = ""
  }
}

kms_key_ids = {}

// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.
compartment_ids = {
  sandbox = "ocid1.compartment.oc1..aaaaaaaaiu3vfcpbjwwgpil3xakqts4jhtjq42kktmisriiszdvvouwsirgq"
}

subnet_ids = {
  hur1pub = "ocid1.subnet.oc1.eu-frankfurt-1.aaaaaaaaka6k2tp7dtasvyp7rly4ypevudwtahtoozsumjnazjl52xpbsrpq"
}

fss_params = {
  thunder1 = {
    ad               = 1
    compartment_name = "sandbox"
    name             = "thunder1"
    kms_key_name     = ""
  }
}

mt_params = {
  mt1 = {
    ad               = 1
    compartment_name = "sandbox"
    name             = "mt1"
    subnet_name      = "hur1pub"
  }

  mt2 = {
    ad               = 1
    compartment_name = "sandbox"
    name             = "mt2"
    subnet_name      = "hur1pub"
  }
}

export_params = {
  mt1 = {
    export_set_name = "mt1"
    filesystem_name = "thunder1"
    path            = "/media"

    export_options = [
      {
        source   = "10.0.1.0/24"
        access   = "READ_WRITE"
        identity = "ROOT"
        use_port = true
      },
    ]
  }
}

kms_key_ids = {}

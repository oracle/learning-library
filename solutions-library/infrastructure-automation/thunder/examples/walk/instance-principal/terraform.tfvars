// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.

instances = {
  hur1 = "ocid1.instance.oc1.eu-frankfurt-1.antheljsuvrz6sqckiihatrzthfbuk4fasdsih5672yay37q4rq5kyz7w74a"
}

instance_principal_params = {
  web = {
    dg_description     = "instance principal web"
    dg_name            = "web"
    policy_description = "web"
    policy_name        = "web"
    instance_name      = "hur1"
  }
}

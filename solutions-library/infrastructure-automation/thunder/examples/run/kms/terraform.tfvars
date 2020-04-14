// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.

compartment_ids = {
  # sandbox = "ocid1.compartment.oc1..aaaaaaaaiu3vfcpbjwwgpil3xakqts4jhtjq42kktmisriiszdvvouwsirgq"
  sandbox = "ocid1.compartment.oc1..aaaaaaaaqshlrjj5smecdetmeuuav37jagpfhfmcthltrxumz24mvb63jutq" # MS -> irimia
}
subnet_ids = {
  # hur1pub = 
  hur1pub = "ocid1.subnet.oc1.ap-mumbai-1.aaaaaaaazukwyasfhaqzvq6lgqlkqbzrmlqlwksgnbryx2rqtsmo3ncktswq" # irimia
  # hur1priv = 
  hur1priv = "ocid1.subnet.oc1.ap-mumbai-1.aaaaaaaamo5pgtzuvx5qhhrrxqtegexgco5llwi4l5qo3c6yomsmpsfbcjuq" # irimia
}

linux_images = {
  ap-mumbai-1    = "ocid1.image.oc1.ap-mumbai-1.aaaaaaaa46gx23hrdtxenjyt4p5cc3c4mbvyiqxcb3mmrxnmjn3rfxgvqcma"
  ap-seoul-1     = "ocid1.image.oc1.ap-seoul-1.aaaaaaaavwjewurl3nvcyq6bgpbrapk4wfwu6qz2ljlrj2yk3cfqexeq64na"
  ap-sydney-1    = "ocid1.image.oc1.ap-sydney-1.aaaaaaaae5qy5o6s2ve2lt4aetmd7s4ydpupowhs6fdl25w4qpkdidbuva5q"
  ap-tokyo-1     = "ocid1.image.oc1.ap-tokyo-1.aaaaaaaa54xb7m4f42vckxkrmtlpys32quyjfldbkhq5zsbmw2r6v5hzgvkq"
  ca-toronto-1   = "ocid1.image.oc1.ca-toronto-1.aaaaaaaagupuj5dfue6gvpmlzzppvwryu4gjatkn2hedocbxbvrtrsmnc5oq"
  eu-frankfurt-1 = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaa3bu75jht762mfvwroa2gdck6boqwyktztyu5dfhftcycucyp63ma"
  eu-zurich-1    = "ocid1.image.oc1.eu-zurich-1.aaaaaaaadx6lizhaqdnuabw4m5dvutmh5hkzoih373632egxnitybcripb2a"
  sa-saopaulo-1  = "ocid1.image.oc1.sa-saopaulo-1.aaaaaaaa3ke6hsjwdshzoh4mtjq3m6f7rhv4c4dkfljr53kjppvtiio7nv3q"
  uk-london-1    = "ocid1.image.oc1.uk-london-1.aaaaaaaasutdhza5wtsrxa236ewtmfa6ixezlaxwxbw7vti2wyi5oobsgoeq"
  us-ashburn-1   = "ocid1.image.oc1.iad.aaaaaaaaox73mjjcopg6damp7tssjccpp5opktr3hwgr63u2lacdt2nver5a"
  us-langley-1   = "ocid1.image.oc2.us-langley-1.aaaaaaaaxyipolnyhfw3t34nparhtlez5cbslyzbvlwxky6ph4mh4s22zmnq"
  us-luke-1      = "ocid1.image.oc2.us-luke-1.aaaaaaaa5dtevrzzxk35dwslew5e6zcqljtfu5hzolcedr467gzuqdg3ls5a"
  us-phoenix-1   = "ocid1.image.oc1.phx.aaaaaaaauuj2b3bvpbtpcyrfdvxu7tuajrwsmajhn6uhvx4oquecap63jywa"
}

instance_params = {
  hur1 = {
    ad                   = 1
    shape                = "VM.Standard2.8"
    hostname             = "hur1"
    boot_volume_size     = 120
    preserve_boot_volume = false
    assign_public_ip     = true
    compartment_name     = "sandbox"
    subnet_name          = "hur1pub"
    ssh_public_key       = "/home/ionut/Documents/personal/keys/id_rsa.pub"
    device_disk_mappings = "/u01:/dev/oracleoci/oraclevdb /u02:/dev/oracleoci/oraclevdc"
    freeform_tags = {
      "client" : "hurricane",
      "department" : "hurricane"
    }
    kms_key_name = "key-hur1"
  }
}

bv_params = {
  bv10 = {
    ad            = 1
    display_name  = "bv10"
    bv_size       = 50
    instance_name = "hur1"
    device_name   = "/dev/oracleoci/oraclevdb"
    freeform_tags = {
      "client" : "hurricane",
      "department" : "hurricane"
    }
    kms_key_name = "key-hur2"
  }
  bv11 = {
    ad            = 1
    display_name  = "bv11"
    bv_size       = 60
    instance_name = "hur1"
    device_name   = "/dev/oracleoci/oraclevdc"
    freeform_tags = {
      "client" : "hurricane",
      "department" : "hurricane"
    }
    kms_key_name = ""
  }
}

windows_images = {
  ap-mumbai-1    = "ocid1.image.oc1.ap-mumbai-1.aaaaaaaa4eoqz2o7ssqm63dkzvny5sld5tibr2ynvmyyp6mwoeblfdcjjtkq"
  ap-seoul-1     = "ocid1.image.oc1.ap-seoul-1.aaaaaaaakb7oq5eiao3rlyha6kf7emogydoy32p3mb22hn3gbwsm7ussfaca"
  ap-sydney-1    = "ocid1.image.oc1.ap-sydney-1.aaaaaaaah4oxmrdqptmcbpdigixfhrxii7rkaspmpq4fppnn3wc6xas2simq"
  ap-tokyo-1     = "ocid1.image.oc1.ap-tokyo-1.aaaaaaaagltuwbdjcdfmvj4gkzb7e32g5aedu6yfdzbmmqkxrrv4d7shixia"
  ca-toronto-1   = "ocid1.image.oc1.ca-toronto-1.aaaaaaaa2iaism6emqvjzgszpnpi7v725herq7u2fdiwswgrplcv4u3g4w6a"
  eu-frankfurt-1 = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaa2rsmgdpbkbo5yrkpynd7mbl5nxpwhyrkp4nd4ev3hzcpfmkosu3q"
  eu-zurich-1    = "ocid1.image.oc1.eu-zurich-1.aaaaaaaawo4g3t6s34okuj7huyrixkucmxtfaqeiqhvsfiok4gxhe3pdpmaa"
  sa-saopaulo-1  = "ocid1.image.oc1.sa-saopaulo-1.aaaaaaaanunxttcfebrg3t34jupfsiy2dqry4wkoaak5h3pckpitylzm44qq"
  uk-london-1    = "ocid1.image.oc1.uk-london-1.aaaaaaaaanixvr63v5v5vvz5qv2c73m6vvc6okwrrqggfvqthyygalm536ra"
  us-ashburn-1   = "ocid1.image.oc1.iad.aaaaaaaaizov2horgjtlxsklhi3cxxjxbcpxzxmtfj5jiftygo76fetussuq"
  us-langley-1   = "ocid1.image.oc2.us-langley-1.aaaaaaaafiwiumrgcipjddg7cha7otxo46dd5hiw7za5llbwnugrgclxqbga"
  us-luke-1      = "ocid1.image.oc2.us-luke-1.aaaaaaaaelf7bq6rtwsxhvkjh6eumoa77ebniwkbyntfti5gtkgvwqnk6dsq"
  us-phoenix-1   = "ocid1.image.oc1.phx.aaaaaaaatte3vcpa7kkogul7zbvnxfjsgwzptmbx7n7qqrzk62skron5on7a"
}

win_instance_params = {
  win01 = {
    ad                   = 1
    shape                = "VM.Standard2.4"
    hostname             = "win01"
    boot_volume_size     = 400
    assign_public_ip     = true
    preserve_boot_volume = false
    compartment_name     = "sandbox"
    subnet_name          = "hur1pub"
    device_disk_mappings = "D:50GB E:60GB"
    freeform_tags = {
      "client" : "hurricane",
      "department" : "hurricane"
    }
    kms_key_name = "key-hur3"
  }
}

win_bv_params = {
  winbv10 = {
    ad            = 1
    display_name  = "winbv10"
    bv_size       = 50
    instance_name = "win01"
    freeform_tags = {
      "client" : "hurricane",
      "department" : "hurricane"
    }
    kms_key_name = "key-hur2"
  }
  winbv11 = {
    ad            = 1
    display_name  = "winbv11"
    bv_size       = 60
    instance_name = "win01"
    freeform_tags = {
      "client" : "hurricane",
      "department" : "hurricane"
    }
    kms_key_name = ""
  }
}

fss_params = {
  thunder1 = {
    ad               = 1
    compartment_name = "sandbox"
    name             = "thunder1"
    kms_key_name     = "key-hur1"
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
        source   = "0.0.0.0/0"
        access   = "READ_WRITE"
        identity = "NONE"
        use_port = false
      },
    ]
  }
}

bucket_params = {
  hur-buck-1 = {
    compartment_name = "sandbox"
    name             = "hur-buck-1"
    access_type      = "NoPublicAccess"
    storage_tier     = "Standard"
    events_enabled   = false
    kms_key_name     = "key-hur2"
  }
}

vault_params = {
  vault-hur1 = {
    compartment_name = "sandbox"
    display_name     = "vault-hur1"
    vault_type       = "DEFAULT"
  }
}

key_params = {
  key-hur1 = {
    compartment_name        = "sandbox"
    display_name            = "key-hur1"
    vault_name              = "vault-hur1"
    key_shape_algorithm     = "AES"
    key_shape_size_in_bytes = 16
    rotation_version        = 0
  }
  key-hur2 = {
    compartment_name        = "sandbox"
    display_name            = "key-hur2"
    vault_name              = "vault-hur1"
    key_shape_algorithm     = "AES"
    key_shape_size_in_bytes = 24
    rotation_version        = 0
  }
  key-hur3 = {
    compartment_name        = "sandbox"
    display_name            = "key-hur3"
    vault_name              = "vault-hur1"
    key_shape_algorithm     = "AES"
    key_shape_size_in_bytes = 32
    rotation_version        = 0
  }
}

 //Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.

gluster_params = {
  replica_number = 3
  volume_type    = "dispersed"
}

ssh_public_key  = "/home/opc/.ssh/id_rsa.pub"
ssh_private_key = "/home/opc/.ssh/id_rsa"

images = {
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
  gfstest1 = {
    ad                   = 1
    shape                = "VM.Standard2.8"
    hostname             = "gfstest1"
    preserve_boot_volume = true
    comp_id              = "ocid1.compartment.oc1..aaaaaaaaiu3vfcpbjwwgpil3xakqts4jhtjq42kktmisriiszdvvouwsirgq"
    subnet_id            = "ocid1.subnet.oc1.iad.aaaaaaaaf4cnazybkfevcu7jj7mxy5oyaek6mjt4rmsfseohb6xmhiipaoma"
  }
  gfstest2 = {
    ad                   = 2
    shape                = "VM.Standard2.8"
    hostname             = "gfstest2"
    preserve_boot_volume = true
    comp_id              = "ocid1.compartment.oc1..aaaaaaaaiu3vfcpbjwwgpil3xakqts4jhtjq42kktmisriiszdvvouwsirgq"
    subnet_id            = "ocid1.subnet.oc1.iad.aaaaaaaaf4cnazybkfevcu7jj7mxy5oyaek6mjt4rmsfseohb6xmhiipaoma"
  }
  gfstest3 = {
    ad                   = 2
    shape                = "VM.Standard2.8"
    hostname             = "gfstest3"
    preserve_boot_volume = true
    comp_id              = "ocid1.compartment.oc1..aaaaaaaaiu3vfcpbjwwgpil3xakqts4jhtjq42kktmisriiszdvvouwsirgq"
    subnet_id            = "ocid1.subnet.oc1.iad.aaaaaaaaf4cnazybkfevcu7jj7mxy5oyaek6mjt4rmsfseohb6xmhiipaoma"
  }
}

bv_params = {
  gfstest11 = {
    name          = "gfstest11"
    size_in_gbs   = 100
    instance_name = "gfstest1"
  }
  gfstest21 = {
    name          = "gfstest21"
    size_in_gbs   = 100
    instance_name = "gfstest2"
  }
  gfstest31 = {
    name          = "gfstest31"
    size_in_gbs   = 100
    instance_name = "gfstest3"
  }
}

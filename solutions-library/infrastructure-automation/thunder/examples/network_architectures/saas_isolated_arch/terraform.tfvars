// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.

compartment_ids = {
  sandbox = "ocid1.compartment.oc1..aaaaaaaaiu3vfcpbjwwgpil3xakqts4jhtjq42kktmisriiszdvvouwsirgq"
}

vcn_params = {
  customer1 = {
    compartment_name = "sandbox"
    display_name     = "customer1"
    vcn_cidr         = "10.0.0.0/16"
    dns_label        = "customer1"
  }
  customer2 = {
    compartment_name = "sandbox"
    display_name     = "customer2"
    vcn_cidr         = "11.0.0.0/16"
    dns_label        = "customer2"
  }
}

igw_params = {
  customer1 = {
    display_name = "customer1"
    vcn_name     = "customer1"
  }
  customer2 = {
    display_name = "customer2"
    vcn_name     = "customer2"
  }
}

ngw_params = {}

rt_params = {
  customer1_pub_rt = {
    display_name = "customer1_pub_rt"
    vcn_name     = "customer1"
    route_rules = [
      {
        destination = "0.0.0.0/0"
        use_igw     = true
        ngw_name    = null
        igw_name    = "customer1"
      }
    ]
  }
  customer1_priv_rt = {
    display_name = "customer1_priv_rt"
    vcn_name     = "customer1"
    route_rules  = []
  }

  customer2_pub_rt = {
    display_name = "customer2_pub_rt"
    vcn_name     = "customer2"
    route_rules = [
      {
        destination = "0.0.0.0/0"
        use_igw     = true
        ngw_name    = null
        igw_name    = "customer2"
      }
    ]
  }
  customer2_priv_rt = {
    display_name = "customer2_priv_rt"
    vcn_name     = "customer2"
    route_rules  = []
  }
}

sl_params = {
  customer1_pub_sl = {
    vcn_name     = "customer1"
    display_name = "customer1_pub_sl"

    egress_rules = [
      {
        stateless   = "false"
        protocol    = "all"
        destination = "0.0.0.0/0"
      }
    ]

    ingress_rules = [
      {
        stateless   = "false"
        protocol    = "all"
        source      = "0.0.0.0/0"
        source_type = "CIDR_BLOCK"

        tcp_options = []
        udp_options = []
      }
    ]
  }
  customer1_priv_sl = {
    vcn_name     = "customer1"
    display_name = "customer1_priv_sl"

    egress_rules = [
      {
        stateless   = "false"
        protocol    = "all"
        destination = "0.0.0.0/0"
      }
    ]

    ingress_rules = [
      {
        stateless   = "false"
        protocol    = "6"
        source      = "0.0.0.0/0"
        source_type = "CIDR_BLOCK"

        tcp_options = [
          {
            min = "22"
            max = "22"
          }
        ]
        udp_options = []
      }
    ]
  }
  customer2_pub_sl = {
    vcn_name     = "customer2"
    display_name = "customer2_pub_sl"

    egress_rules = [
      {
        stateless   = "false"
        protocol    = "all"
        destination = "0.0.0.0/0"
      }
    ]

    ingress_rules = [
      {
        stateless   = "false"
        protocol    = "all"
        source      = "0.0.0.0/0"
        source_type = "CIDR_BLOCK"

        tcp_options = []
        udp_options = []
      }
    ]
  }
  customer2_priv_sl = {
    vcn_name     = "customer2"
    display_name = "customer2_priv_sl"

    egress_rules = [
      {
        stateless   = "false"
        protocol    = "all"
        destination = "0.0.0.0/0"
      }
    ]

    ingress_rules = [
      {
        stateless   = "false"
        protocol    = "6"
        source      = "0.0.0.0/0"
        source_type = "CIDR_BLOCK"

        tcp_options = [
          {
            min = "22"
            max = "22"
          }
        ]
        udp_options = []
      }
    ]
  }
}



nsg_params = {}

nsg_rules_params = {}


subnet_params = {
  subnet1A = {
    display_name      = "subnet1A"
    cidr_block        = "10.0.1.0/24"
    dns_label         = "subnet1a"
    is_subnet_private = false
    sl_name           = "customer1_pub_sl"
    rt_name           = "customer1_pub_rt"
    vcn_name          = "customer1"
  }
  subnet1B = {
    display_name      = "subnet1B"
    cidr_block        = "10.0.2.0/24"
    dns_label         = "subnet1b"
    is_subnet_private = true
    sl_name           = "customer1_priv_sl"
    rt_name           = "customer1_priv_rt"
    vcn_name          = "customer1"
  }
  subnet2A = {
    display_name      = "subnet2A"
    cidr_block        = "11.0.1.0/24"
    dns_label         = "subnet2a"
    is_subnet_private = false
    sl_name           = "customer2_pub_sl"
    rt_name           = "customer2_pub_rt"
    vcn_name          = "customer2"
  }
  subnet2B = {
    display_name      = "subnet2B"
    cidr_block        = "11.0.2.0/24"
    dns_label         = "subnet1b"
    is_subnet_private = true
    sl_name           = "customer2_priv_sl"
    rt_name           = "customer2_priv_rt"
    vcn_name          = "customer2"
  }
}

lpg_params = {}

drg_params = {
  customer1_drg = {
    name     = "customer1_drg"
    vcn_name = "customer1"
    cidr_rt  = "13.0.0.0/24"
    rt_names = ["customer1_priv_rt"]
  }
  customer2_drg = {
    name     = "customer2_drg"
    vcn_name = "customer2"
    cidr_rt  = "12.0.0.0/24"
    rt_names = ["customer2_priv_rt"]
  }
}




#------------ Compute --------------
linux_images = {
  ap-melbourne-1  = {
    centos6 = "ocid1.image.oc1.ap-melbourne-1.aaaaaaaas4synyw646enlkqbgunmevfw3npohtccrpam6iqvtljesbtsqdoa"
    centos7 = "ocid1.image.oc1.ap-melbourne-1.aaaaaaaa3wpbl3xl6jfgk3gat3gnesw7wvafzvbxl2zybh3zclr3lahllilq"
    oel6    = "ocid1.image.oc1.ap-melbourne-1.aaaaaaaat52asmaafbfz6vdkgmopvbkwsucokrwqmxgdr5qjcwu6zutvic7a"
    oel7    = "ocid1.image.oc1.ap-melbourne-1.aaaaaaaavpiybmiqoxcohpiih2gasjgqpsiyz4ggylyhhitmrmf3j2ycucrq"
  }
  ap-mumbai-1     = {
    centos6 = "ocid1.image.oc1.ap-mumbai-1.aaaaaaaaorpgj2wcaaawpi3sdisrsz7ahhx6k7yq27bzrcun6ohehvsp5kuq"
    centos7 = "ocid1.image.oc1.ap-mumbai-1.aaaaaaaafr2lbi3vkymk2os3t3xqg2xp42xfqll7x73rv3j4msfuwwrbxmta"
    oel6    = "ocid1.image.oc1.ap-mumbai-1.aaaaaaaahkxsdgr2piceahkowh7jmimywdvfe4wdc3ujizzrgmdpuansjlva"
    oel7    = "ocid1.image.oc1.ap-mumbai-1.aaaaaaaarrsp6bazleeeghz6jcifatswozlqkoffzwxzbt2ilj2f65ngqi6a"
  }
  ap-osaka-1      = {
    centos6 = "ocid1.image.oc1.ap-osaka-1.aaaaaaaausl3ucj5slnzpjr6zc5hulnd7637eqakcscl45zc673fz3repgnq"
    centos7 = "ocid1.image.oc1.ap-osaka-1.aaaaaaaaws7jyd6nfsd6negf5ojd27m3v7xosspil7mkcnf3wfcbf3w3iq6a"
    oel6    = "ocid1.image.oc1.ap-osaka-1.aaaaaaaajoqvhi7dd776bch4uspb2xuzzhaoobrt6xh45rs3o4mv3ya4e5tq"
    oel7    = "ocid1.image.oc1.ap-osaka-1.aaaaaaaafa5rhs2n3dyuncddh5oynk6gisvotvcvch3e6xwplji7phwtbqqa"
  }
  ap-seoul-1     = {
    centos6 = "ocid1.image.oc1.ap-seoul-1.aaaaaaaajfn2tg23h6bspxhn3xlby6f6tsksagemmoaycoylxa5ivbf2prhq"
    centos7 = "ocid1.image.oc1.ap-seoul-1.aaaaaaaajsolmhhy7xjgfscxb4vpyet6k2sop6wdtwmn3dkc3fy7eyt3m24a"
    oel6    = "ocid1.image.oc1.ap-seoul-1.aaaaaaaa4rk36ectfyj2psdo3xcatz4z3x7ctber6l74vohqkbyfwoxdz3iq"
    oel7    = "ocid1.image.oc1.ap-seoul-1.aaaaaaaadrnhec6655uedkshgcklewzikoqcwr65sevbu27z7vzagniihfha"
  }
  ap-sydney-1    = {
    centos6 = "ocid1.image.oc1.ap-sydney-1.aaaaaaaaeevmpmgwugan2qljntoteqihc6ygfycwxui3nigeob7snaikuaiq"
    centos7 = "ocid1.image.oc1.ap-sydney-1.aaaaaaaayblorjjncrno3r5wh73lzmpu4ioro72oymd4eeu2hu4fsscumqha"
    oel6    = "ocid1.image.oc1.ap-sydney-1.aaaaaaaav4ooak5wysyydz4aezicqstgx3jxmjanjpdj7jonla3tk3npgzda"
    oel7    = "ocid1.image.oc1.ap-sydney-1.aaaaaaaaplq4fjdnoooudaqwgzaidh6r3lp3xdhqulx454jivy33t53hokga"
  }
  ap-tokyo-1     = {
    centos6 = "ocid1.image.oc1.ap-tokyo-1.aaaaaaaai2umweqozk36atwr4cxaicukqjomfbueojr74fdbxe74fi75egca"
    centos7 = "ocid1.image.oc1.ap-tokyo-1.aaaaaaaarkipypzhscxniq3uqr2jqc55maelnt7vgjikemck3k5vl5iabzrq"
    oel6    = "ocid1.image.oc1.ap-tokyo-1.aaaaaaaadnxbyomirzk3rsp4ctmoi65n4dso3olkyf4pfdymslouoq5jcjha"
    oel7    = "ocid1.image.oc1.ap-tokyo-1.aaaaaaaa5mpgmnwqwacey5gvczawugmo3ldgrjqnleckmnsokrqytcfkzspa"
  }
  ca-montreal-1  = {
    centos6 = "ocid1.image.oc1.ca-montreal-1.aaaaaaaafwemmq6tz6zwxfz7bvlwb6iyi7y2hzzu2mv54ngrldh6hhnyxama"
    centos7 = "ocid1.image.oc1.ca-montreal-1.aaaaaaaajxxgx4af4rcudk2avldhbebctl7e5v445ycs35wk6boneut423nq"
    oel6    = "ocid1.image.oc1.ca-montreal-1.aaaaaaaasm46wajq5kmztlbzqclqohpj3nevbi4ep2zi627xbr4uudnxxpma"
    oel7    = "ocid1.image.oc1.ca-montreal-1.aaaaaaaaevu23evecil3r23q5illjliinkpyvtkbdq5nsxmcfqypvlewytra"
  }
  ca-toronto-1   = {
    centos6 = "ocid1.image.oc1.ca-toronto-1.aaaaaaaan2fmhw2mcc7nidx6dimfzrkzdln4ckirpfyvcdp4xldnwkrlq43q"
    centos7 = "ocid1.image.oc1.ca-toronto-1.aaaaaaaabqsazpmiu5xq23pxxw3c4r6ko5rjfewk4mqkm7tgtsq4uc2exxoa"
    oel6    = "ocid1.image.oc1.ca-toronto-1.aaaaaaaayqaoapktxol6igmw26oi73pdypvwtvzxjc73i5ly4sqj3ghwaafa"
    oel7    = "ocid1.image.oc1.ca-toronto-1.aaaaaaaai25l5mqlzvhjzxvb5n4ullqu333bmalyyg3ki53vt24yn6ld7pra"
  }
  eu-amsterdam-1 = {
    centos6 = "ocid1.image.oc1.eu-amsterdam-1.aaaaaaaa4xufymkiho5dlscdbtvsru5b22knjoxcnnflgo6xloqqodfx2tda"
    centos7 = "ocid1.image.oc1.eu-amsterdam-1.aaaaaaaat32fvq5hsmbljrvy77gr2xel7i3l3oc6g3bcnnd6mimzz5jqa7ka"
    oel6    = "ocid1.image.oc1.eu-amsterdam-1.aaaaaaaacymg54gaxda5hwmf4tdaaxcmnmrfemiziweukau3c2gjqqzf77ga"
    oel7    = "ocid1.image.oc1.eu-amsterdam-1.aaaaaaaayd4knq4bdh23zqgatgjhoajiz3mx4fy3oy62e5f45ll7trwak5ga"
  }
  eu-frankfurt-1 = {
    centos6 = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaaf6ej4bn4wzvlocyybqn65x7osycxvobtjkcn7ya4urcsa6ql6rhq"
    centos7 = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaahkaj2rzfdpruxajpy77gohgczstwhygsimohss2plkfslbbh4xfa"
    oel6    = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaawrdkszzb56yo4nb4k42txyp2yvwusgsbraztcua2b5ebsk5iz7lq"
    oel7    = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaa4cmgko5la45jui5cuju7byv6dgnfnjbxhwqxaei3q4zjwlliptuq"
  }
  eu-zurich-1    = {
    centos6 = "ocid1.image.oc1.eu-zurich-1.aaaaaaaagmybtgdr33vlsaa245sulxmqvasf5pgoppbfkx2qtoonfd6pbwnq"
    centos7 = "ocid1.image.oc1.eu-zurich-1.aaaaaaaaedzqaa6w2b675og5go54nw2tmfoonqnk2kabhcdcuygbpy7habga"
    oel6    = "ocid1.image.oc1.eu-zurich-1.aaaaaaaafdub2llzurrq6ti2xff6po2x6ibm3aaabjhesgug6ceo73etquaq"
    oel7    = "ocid1.image.oc1.eu-zurich-1.aaaaaaaa4nwf5h6nl3u5cdauemg352itja6izecs7ol73z6jftsg4agpdsma"
  }
  me-jeddah-1    = {
    centos6 = "ocid1.image.oc1.me-jeddah-1.aaaaaaaac37rqyxwrl4lw2zcxkrplmkybkgykco2zzw4wbjjzbgzoj4emzxa"
    centos7 = "ocid1.image.oc1.me-jeddah-1.aaaaaaaa2hphaidibmfn6bomi756tjtb3ncakzroubrdrh4oteiexkgqzqxa"
    oel6    = "ocid1.image.oc1.me-jeddah-1.aaaaaaaa6ypmt4rwxpi2w3b5jvrzxsw6egopg3ckzhsddbbwjrdri4hyiara"
    oel7    = "ocid1.image.oc1.me-jeddah-1.aaaaaaaazrvioeng7va7w4qsuqny4jtxbvnxlf5hu7g2twn6rcwdu35u4riq"
  }
  sa-saopaulo-1   = {
    centos6 = "ocid1.image.oc1.sa-saopaulo-1.aaaaaaaaat6zylwbmjc3nt3opxgr54vjuolezmxmdlkhumdkrnfzjmcalena"
    centos7 = "ocid1.image.oc1.sa-saopaulo-1.aaaaaaaa4jgkrkwd5d6ktzu43mjhri4el2p3gc7hzkkt26uhawjf6xe2s5ra"
    oel6    = "ocid1.image.oc1.sa-saopaulo-1.aaaaaaaaw265lcnl4fottvdoid56arojwyxl57mihcl6g5p5dwwk457ufa6q"
    oel7    = "ocid1.image.oc1.sa-saopaulo-1.aaaaaaaalfracz4kuew4yxvgydpnbitip6qsreaz7kpxlkr4p67ravvi4jnq"
  }
  uk-gov-london-1 = {
    centos6 = "ocid1.image.oc4.uk-gov-london-1.aaaaaaaa3jm7g2knbd42qbmahxcitawva56svefikpjrlfqjdeiir4vhxdmq"
    centos7 = "ocid1.image.oc4.uk-gov-london-1.aaaaaaaavzplbvr4myylufwebu6556stwm44rhg5b7hzyljyghkzxkrpnntq"
    oel6    = "ocid1.image.oc4.uk-gov-london-1.aaaaaaaamcvr7kawh4i3sdrlok2kqkfetk573utdq5u4ighhe55r46ddmusq"
    oel7    = "ocid1.image.oc4.uk-gov-london-1.aaaaaaaaslh4pip7u6iopbpxujy2twi7diqrs6kfvqfhkl27esdadkqa76mq"
  }
  uk-london-1     = {
    centos6 = "ocid1.image.oc1.uk-london-1.aaaaaaaalaq6axfs4t4qibzlbo6mq2ejbij6rnhrdv43ic53yuu6nsziabdq"
    centos7 = "ocid1.image.oc1.uk-london-1.aaaaaaaalblgx62jnubrhfdt4kawbev4r3r2rord253r5h6b4vdsgvz7uhnq"
    oel6    = "ocid1.image.oc1.uk-london-1.aaaaaaaapir5bvtsdq6inbebytzb362kkd5tx2iz3qg7i2k4b2vbnejan6uq"
    oel7    = "ocid1.image.oc1.uk-london-1.aaaaaaaa2uwbd457cd2gtviihmxw7cqfmqcug4ahdg7ivgyzla25pgrn6soa"
  }
  us-ashburn-1    = {
    centos6 = "ocid1.image.oc1.iad.aaaaaaaa2czkuqalinjferx3iszp264xspwnd7xzlfhupxtzc4zdnuxi6bwa"
    centos7 = "ocid1.image.oc1.iad.aaaaaaaa3n6t4mwilogs7a7dvp64tptstjvivq52yasfjgw64lcbdqf4d3ca"
    oel6    = "ocid1.image.oc1.iad.aaaaaaaasxwd6pbz6py3shznyfxuxexiatoxse7zyd7tz4tmra27wle6ydwq"
    oel7    = "ocid1.image.oc1.iad.aaaaaaaavzjw65d6pngbghgrujb76r7zgh2s64bdl4afombrdocn4wdfrwdq"
  }
  us-langley-1    = {
    centos6 = "ocid1.image.oc2.us-langley-1.aaaaaaaa7bgboeixz75owe3fbdmg2pvmysk2rxob6bufkisyin3v27qsdz2q"
    centos7 = "ocid1.image.oc2.us-langley-1.aaaaaaaa3ryqvptloob45777kvfqsoymukhioddaj5yows526j4cn5enl6aa"
    oel6    = "ocid1.image.oc2.us-langley-1.aaaaaaaakzg6qr6hpm3jj7x3wyt2ya7bsh5xtvku3hmlysguuaasir6u673a"
    oel7    = "ocid1.image.oc2.us-langley-1.aaaaaaaauckkms7acrl6to3cuhmv6hfjqwlnoxzuzophaose7pi2sfk4dzna"
  }
  us-luke-1       = {
    centos6 = "ocid1.image.oc2.us-luke-1.aaaaaaaa6woblaikk4fmyciqfwmbvoeukgq2m3jt5rrqyclseehrsawwkpyq"
    centos7 = "ocid1.image.oc2.us-luke-1.aaaaaaaa4o74g2lmljky7fgx4o5zr3aw7rww7jjkliwbqoxq6yu5vjm23e3a"
    oel6    = "ocid1.image.oc2.us-luke-1.aaaaaaaajyelyu6k7kzyoxeneyye74ld3osxx53ufeh4a2thrnpub5zi47mq"
    oel7    = "ocid1.image.oc2.us-luke-1.aaaaaaaadxeycutztmvaeefvilc57lfqool2rlgl2r34juyu4jkbodx2xspq"
  }
  us-phoenix-1    = {
    centos6 = "ocid1.image.oc1.phx.aaaaaaaau6s3kqgtnuxtu2yc7czi2z4ylcn5mhx7igcmhb3ujjaiypcjhozq"
    centos7 = "ocid1.image.oc1.phx.aaaaaaaak3hatlw7tncpvvatc4t7ihocxfx243ii54m2kuxjlsln4vnspnea"
    oel6    = "ocid1.image.oc1.phx.aaaaaaaas3h3h5hr3uvfliydhvusoscpqzflewislg4m3ycj6y6y3exvbe3a"
    oel7    = "ocid1.image.oc1.phx.aaaaaaaacy7j7ce45uckgt7nbahtsatih4brlsa2epp5nzgheccamdsea2yq"
  }
}

instance_params = {
  customer1a = {
    ad                   = 1
    shape                = "VM.Standard2.1"
    hostname             = "customer1a"
    boot_volume_size     = 120
    preserve_boot_volume = false
    assign_public_ip     = true
    compartment_name     = "sandbox"
    subnet_name          = "subnet1A"
    ssh_public_key       = "/root/.ssh/id_rsa.pub"
    device_disk_mappings = ""
    freeform_tags = {
      "client" : "customer1",
      "department" : "customer1"
    }
    kms_key_name       = ""
    block_vol_att_type = "paravirtualized"
    encrypt_in_transit = false
    fd                 = 1
    image_version      = "oel7"
    nsgs               = []
  }
  customer1b = {
    ad                   = 1
    shape                = "VM.Standard2.1"
    hostname             = "customer1b"
    boot_volume_size     = 120
    preserve_boot_volume = false
    assign_public_ip     = false
    compartment_name     = "sandbox"
    subnet_name          = "subnet1B"
    ssh_public_key       = "/root/.ssh/id_rsa.pub"
    device_disk_mappings = ""
    freeform_tags = {
      "client" : "customer1",
      "department" : "customer1"
    }
    kms_key_name       = ""
    block_vol_att_type = "paravirtualized"
    encrypt_in_transit = false
    fd                 = 1
    image_version      = "oel7"
    nsgs               = []
  }
  customer2a = {
    ad                   = 1
    shape                = "VM.Standard2.1"
    hostname             = "customer2a"
    boot_volume_size     = 120
    preserve_boot_volume = false
    assign_public_ip     = true
    compartment_name     = "sandbox"
    subnet_name          = "subnet2A"
    ssh_public_key       = "/root/.ssh/id_rsa.pub"
    device_disk_mappings = ""
    freeform_tags = {
      "client" : "customer2",
      "department" : "customer2"
    }
    kms_key_name       = ""
    block_vol_att_type = "paravirtualized"
    encrypt_in_transit = false
    fd                 = 1
    image_version      = "oel7"
    nsgs               = []
  }
  customer2b = {
    ad                   = 1
    shape                = "VM.Standard2.1"
    hostname             = "customer2b"
    boot_volume_size     = 120
    preserve_boot_volume = false
    assign_public_ip     = false
    compartment_name     = "sandbox"
    subnet_name          = "subnet2B"
    ssh_public_key       = "/root/.ssh/id_rsa.pub"
    device_disk_mappings = ""
    freeform_tags = {
      "client" : "customer1",
      "department" : "customer1"
    }
    kms_key_name       = ""
    block_vol_att_type = "paravirtualized"
    encrypt_in_transit = false
    fd                 = 1
    image_version      = "oel7"
    nsgs               = []
  }
}

bv_params = {}

windows_images = {}

win_instance_params = {}

win_bv_params = {}
#-----------------------------------

#-------------- DBaaS --------------
database_params = {
  cust1db = {
    compartment_name        = "sandbox"
    ad                      = 1
    cpu_core_count          = 2
    db_edition              = "ENTERPRISE_EDITION"
    db_name                 = "cust1db"
    db_admin_password       = "BEstrO0ng_#11"
    db_workload             = "OLTP"
    pdb_name                = "cust1pdb"
    enable_auto_backup      = true
    db_version              = "12.1.0.2"
    display_name            = "customer1db"
    disk_redundancy         = "HIGH"
    shape                   = "VM.Standard2.8"
    subnet_name             = "subnet1B"
    ssh_public_key          = "/root/.ssh/id_rsa.pub"
    hostname                = "cust1db"
    data_storage_size_in_gb = 256
    license_model           = "BRING_YOUR_OWN_LICENSE"
    node_count              = 1
  }
  cust2db = {
    compartment_name        = "sandbox"
    ad                      = 1
    cpu_core_count          = 2
    db_edition              = "ENTERPRISE_EDITION"
    db_name                 = "cust2db"
    db_admin_password       = "BEstrO0ng_#11"
    db_workload             = "OLTP"
    pdb_name                = "cust2pdb"
    enable_auto_backup      = true
    db_version              = "12.1.0.2"
    display_name            = "customer2db"
    disk_redundancy         = "NORMAL"
    shape                   = "VM.Standard2.8"
    subnet_name             = "subnet2B"
    ssh_public_key          = "/root/.ssh/id_rsa.pub"
    hostname                = "cust2db"
    data_storage_size_in_gb = 256
    license_model           = "BRING_YOUR_OWN_LICENSE"
    node_count              = 1
  }
}



lb_params = {
  customer1lb = {
    shape            = "100Mbps"
    compartment_name = "sandbox"
    subnet_names     = ["subnet1A"]
    display_name     = "customer1lb"
    is_private       = false
  }
  customer2lb = {
    shape            = "100Mbps"
    compartment_name = "sandbox"
    subnet_names     = ["subnet2A"]
    display_name     = "customer2lb"
    is_private       = false
  }
}

backend_sets = {
  customer1bs = {
    name        = "customer1bs"
    lb_name     = "customer1lb"
    policy      = "ROUND_ROBIN"
    hc_port     = 80
    hc_protocol = "HTTP"
    hc_url      = "/"
  }
  customer2bs = {
    name        = "customer2bs"
    lb_name     = "customer2lb"
    policy      = "ROUND_ROBIN"
    hc_port     = 80
    hc_protocol = "HTTP"
    hc_url      = "/"
  }
}

listeners = {
  customer1list = {
    lb_name          = "customer1lb"
    name             = "customer1list"
    backend_set_name = "customer1bs"
    port             = 80
    protocol         = "HTTP"
    ssl              = []
  }
  customer2list = {
    lb_name          = "customer2lb"
    name             = "customer2list"
    backend_set_name = "customer2bs"
    port             = 80
    protocol         = "HTTP"
    ssl              = []
  }
}

backend_params = {
  cust1bsA = {
    backendset_name = "customer1bs"
    use_instance    = true
    instance_name   = "customer1a"
    lb_name         = "customer1lb"
    port            = 80
    lb_backend_name = ""
  }
  cust1bsB = {
    backendset_name = "customer1bs"
    use_instance    = true
    instance_name   = "customer1b"
    lb_name         = "customer1lb"
    port            = 80
    lb_backend_name = ""
  }
  cust2bsA = {
    backendset_name = "customer2bs"
    use_instance    = true
    instance_name   = "customer2a"
    lb_name         = "customer2lb"
    port            = 80
    lb_backend_name = ""
  }
  cust2bsB = {
    backendset_name = "customer2bs"
    use_instance    = true
    instance_name   = "customer2b"
    lb_name         = "customer2lb"
    port            = 80
    lb_backend_name = ""
  }
}

certificates = {}

ipsec_params = {
  ipsec_customer1 = {
    comp_name      = "sandbox"
    cpe_ip_address = "140.238.211.235"
    name           = "ipsec_customer1"
    drg_name       = "customer1_drg"
    static_routes  = ["10.0.0.0/24"]
  }
  ipsec_customer2 = {
    comp_name      = "sandbox"
    cpe_ip_address = "140.238.211.235"
    name           = "ipsec_customer2"
    drg_name       = "customer2_drg"
    static_routes  = ["11.0.0.0/24"]
  }
}


cc_group = {
  ccgrp1 = {
    comp_name = "sandbox"
    name      = "ccgrp1"
  }
}
cc = {
  cc1 = {
    comp_name             = "sandbox"
    name                  = "cc1"
    cc_group_name         = "ccgrp1"
    location_name         = "Chandler"
    port_speed_shape_name = "10Gbps"
  }
}

private_vc_no_provider = {
  priv_vc_no_provider = {
    comp_name             = "sandbox"
    name                  = "priv_vc_no_provider"
    type                  = "PRIVATE"
    bw_shape              = "10Gbps"
    cc_group_name         = "ccgrp1"
    cust_bgp_peering_ip   = "10.0.0.18/31"
    oracle_bgp_peering_ip = "10.0.0.18/31"
    vlan                  = "200"
    drg                   = "customerB_drg"
  }
}
private_vc_with_provider = {}
public_vc_no_provider    = {}
public_vc_with_provider  = {}

kms_key_ids = {}

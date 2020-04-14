// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.

compartment_ids = {
  sandbox = "ocid1.compartment.oc1..aaaaaaaaiu3vfcpbjwwgpil3xakqts4jhtjq42kktmisriiszdvvouwsirgq"
}
subnet_ids = {
  hur1pub  = "ocid1.subnet.oc1.eu-zurich-1.aaaaaaaaojjzmpe2g22irdq2himujwdecq4l2lzztb5mgk56wtmyhtnlq4qq"
  hur1priv = "ocid1.subnet.oc1.eu-zurich-1.aaaaaaaaxsoue377vg7c63lutmdin3z4b7tiucdjwk75pbsf6zme5jfstymq"
}

nsgs = {
  hurricane1 = "ocid1.networksecuritygroup.oc1.eu-zurich-1.aaaaaaaahoc3p6q6tcylo7ecaitlxkee2umdaeaotxcmuoffqmobjvbs5o4a"
  hurricane2 = "ocid1.networksecuritygroup.oc1.eu-zurich-1.aaaaaaaaj3zvqvlavrdr3a2kze2chyic6vp4j6jjqueqdz7y2kdvrulub25q"
}

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
  hur1 = {
    ad                   = 1
    shape                = "VM.Standard2.8"
    hostname             = "hur1"
    boot_volume_size     = 120
    preserve_boot_volume = true
    assign_public_ip     = true
    compartment_name     = "sandbox"
    subnet_name          = "hur1pub"
    ssh_public_key       = "/root/.ssh/id_rsa.pub"
    device_disk_mappings = "/u01:/dev/oracleoci/oraclevdb /u05:/dev/oracleoci/oraclevdc /u80:/dev/oracleoci/oraclevdd /u02:/dev/oracleoci/oraclevde /u03:/dev/oracleoci/oraclevdf /u04:/dev/oracleoci/oraclevdg"
    freeform_tags = {
      "client" : "hurricane",
      "department" : "hurricane"
    }
    kms_key_name       = ""
    block_vol_att_type = "iscsi"
    encrypt_in_transit = true
    fd                 = 1
    image_version      = "oel7"
    nsgs               = ["hurricane1"]
  }
  hur2 = {
    ad                   = 1
    shape                = "VM.Standard2.8"
    hostname             = "hur2"
    boot_volume_size     = 120
    use_custom_image     = "true"
    assign_public_ip     = false
    preserve_boot_volume = true
    compartment_name     = "sandbox"
    subnet_name          = "hur1pub"
    ssh_public_key       = "/root/.ssh/id_rsa.pub"
    device_disk_mappings = "/u01:/dev/oracleoci/oraclevdb"
    freeform_tags = {
      "client" : "hurricane",
      "department" : "hurricane"
    }
    kms_key_name       = ""
    block_vol_att_type = "paravirtualized"
    encrypt_in_transit = true
    fd                 = 1
    image_version      = "oel6"
    nsgs               = []
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
    kms_key_name       = ""
    performance        = "High"
    encrypt_in_transit = true 
  }
  bv11 = {
    ad            = 1
    display_name  = "bv11"
    bv_size       = 70
    instance_name = "hur1"
    device_name   = "/dev/oracleoci/oraclevdc"
    freeform_tags = {
      "client" : "hurricane",
      "department" : "hurricane"
    }
    kms_key_name       = ""
    performance        = "Balanced"
    encrypt_in_transit = false
  }
  bv12 = {
    ad            = 1
    display_name  = "bv12"
    bv_size       = 60
    instance_name = "hur1"
    device_name   = "/dev/oracleoci/oraclevdd"
    freeform_tags = {
      "client" : "hurricane",
      "department" : "hurricane"
    }
    kms_key_name       = ""
    performance        = "Balanced"
    encrypt_in_transit = false
  }
  bv13 = {
    ad            = 1
    display_name  = "bv13"
    bv_size       = 80
    instance_name = "hur1"
    device_name   = "/dev/oracleoci/oraclevde"
    freeform_tags = {
      "client" : "hurricane",
      "department" : "hurricane"
    }
    kms_key_name       = ""
    performance        = "Balanced"
    encrypt_in_transit = false
  }
  bv14 = {
    ad            = 1
    display_name  = "bv14"
    bv_size       = 90
    instance_name = "hur1"
    device_name   = "/dev/oracleoci/oraclevdf"
    freeform_tags = {
      "client" : "hurricane",
      "department" : "hurricane"
    }
    kms_key_name       = ""
    performance        = "Balanced"
    encrypt_in_transit = false
  }
  bv15 = {
    ad            = 1
    display_name  = "bv15"
    bv_size       = 100
    instance_name = "hur1"
    device_name   = "/dev/oracleoci/oraclevdg"
    freeform_tags = {
      "client" : "hurricane",
      "department" : "hurricane"
    }
    kms_key_name       = ""
    performance        = "Balanced"
    encrypt_in_transit = false
  }
  bv20 = {
    ad            = 1
    display_name  = "bv20"
    bv_size       = 50
    instance_name = "hur2"
    device_name   = "/dev/oracleoci/oraclevdb"
    freeform_tags = {
      "client" : "hurricane",
      "department" : "hurricane"
    }
    kms_key_name       = ""
    performance        = "Balanced"
    encrypt_in_transit = true
  }
}

windows_images = {
 ap-melbourne-1  = {
    win2012 = "ocid1.image.oc1.ap-melbourne-1.aaaaaaaa2jzeb4nsfl5uaalww47uwhtohp7kbtltftfkwel7ryoic47qnp2q"
    win2016 = "ocid1.image.oc1.ap-melbourne-1.aaaaaaaatdyrmhvyt4bl74oum5gpgevunwatgmpbuqn6jun4r7qbnczcn4dq"
  }
  ap-mumbai-1     = {
    win2012 = "ocid1.image.oc1.ap-mumbai-1.aaaaaaaapmwvb3ogybzyzpmc2az64tdxg5l4txty35fz3klf4g3rxowo53vq"
    win2016 = "ocid1.image.oc1.ap-mumbai-1.aaaaaaaasc2wsrcxrwdfn4zh6wmdnu4glsynelffdm6xgbjh3ipd5umpx2xa"
  }
  ap-osaka-1      = {
    win2012 = "ocid1.image.oc1.ap-osaka-1.aaaaaaaatbhfaworyijbvn5nownnlhvzhpkpuj57x7zdjdfc5jtyscgbrvrq"
    win2016 = "ocid1.image.oc1.ap-osaka-1.aaaaaaaaobpeuodhowu57rehuhyzxww552hwqseagitt2j4yjh6hbt6z4xbq"
  }
  ap-seoul-1     = {
    win2012 = "ocid1.image.oc1.ap-seoul-1.aaaaaaaavu4koamk7unf6pivse4ws3a4dy7k6xkauixvw767mk42lpzhbnmq"
    win2016 = "ocid1.image.oc1.ap-seoul-1.aaaaaaaak22mo5iuorfuutp65kkjh4qlhn5ixueuwijhshheapyxwbj5xomq"
  }
  ap-sydney-1    = {
    win2012 = "ocid1.image.oc1.ap-sydney-1.aaaaaaaaqocjcaniahdquelosicuowl2ilhsxsiesfejkyvmosu74tgsvaaq"
    win2016 = "ocid1.image.oc1.ap-sydney-1.aaaaaaaa3ir4nlvogcden7ncm6wgjisr7fyshmqxtavu5vo4rfrb742p3txa"
  }
  ap-tokyo-1     = {
    win2012 = "ocid1.image.oc1.ap-tokyo-1.aaaaaaaajlyfz6he53mjhk6qqihprclqvzrdao65qmhfhctqtmbv2d2httaa"
    win2016 = "ocid1.image.oc1.ap-tokyo-1.aaaaaaaaqqe3xlsipnanxvls7sydfchgp34uoh6gs2ymmt3wtvxbbavebwrq"
  }
  ca-montreal-1  = {
    win2012 = ""
    win2016 = ""
  }
  ca-toronto-1   = {
    win2012 = "ocid1.image.oc1.ca-toronto-1.aaaaaaaa752f3wc5u7v2juogn6dy3ye66b4far44qprw5zjjizfeeaf5izoa"
    win2016 = "ocid1.image.oc1.ca-toronto-1.aaaaaaaaq44jibkjmdspz3jn7hdc6uzvpgvtwr6ch4za3fq4mxioqfoxqxja"
  }
  eu-amsterdam-1 = {
    win2012 = "ocid1.image.oc1.eu-amsterdam-1.aaaaaaaajc2jl3uf66fbpokbq5ih6ftmw6kk35najdstl4qczffv3bbensfq"
    win2016 = "ocid1.image.oc1.eu-amsterdam-1.aaaaaaaa27dp74s7gs7f5u7h3jquusq2moq5owfmxarnjhxefodzqgsilqqa"
  }
  eu-frankfurt-1 = {
    win2012 = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaa7dkmlaxugz6dpfyypwhjixswe6wsbatg2h54zpdh627nn5zgzqta"
    win2016 = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaabgz6uyv4lsvn4n5biimheldf3oqlsv57sgyrqr23y4fga3u553ca"
  }
  eu-zurich-1    = {
    win2012 = "ocid1.image.oc1.eu-zurich-1.aaaaaaaa5ovebmqaegqq63juvljqjvehx7ucd7b2bfeiazfhugner45d64aa"
    win2016 = "ocid1.image.oc1.eu-zurich-1.aaaaaaaakkzh3flq3etztpviemeuvd3tao7frk6a6qsduazwbvpv7ou4t4ma"
  }
  me-jeddah-1    = {
    win2012 = "ocid1.image.oc1.me-jeddah-1.aaaaaaaagaezc2e5fxn5gs7e3hjusyizzj3rcsuw4kbimikwqff3et3jpkyq"
    win2016 = "ocid1.image.oc1.me-jeddah-1.aaaaaaaabibtjsm5j5xnuxxbtn6uash2iw6s637wwwcpcdddadlvoilksk6a"
  }
  sa-saopaulo-1   = {
    win2012 = "ocid1.image.oc1.sa-saopaulo-1.aaaaaaaal5kxtbhqsh64xkmegwa45cp5ot3xn4ofuscbcxus7m3flg7yfr7a"
    win2016 = "ocid1.image.oc1.sa-saopaulo-1.aaaaaaaahks2snkmp2hqhbudpwmtrkavzm6t5hidb5yznpvvd6xsa4oes6sa"
  }
  uk-gov-london-1 = {
    win2012 = "ocid1.image.oc4.uk-gov-london-1.aaaaaaaak6yftnsopebnhqu57wszmvb53sguijxgs525e43gmc2xukncuela"
    win2016 = "ocid1.image.oc4.uk-gov-london-1.aaaaaaaa2ibi32nxnlns7k5cxjt34qwgvbcy76to7ugukscuko72j64d4ftq"
  }
  uk-london-1     = {
    win2012 = "ocid1.image.oc1.uk-london-1.aaaaaaaad65mjvptyjfhpcgzznqsr6wxk5qcnlhxuxghwi7p7zo7a4f64zua"
    win2016 = "ocid1.image.oc1.uk-london-1.aaaaaaaaraiur2saeneruix7avikzgvobacex4a3lkexwurty7iinqgs5kkq"
  }
  us-ashburn-1    = {
    win2012 = "ocid1.image.oc1.iad.aaaaaaaa3dyr5vgojhud3awc5rqb47nnprhf3fwchpiy6rri6poss47pjqwq"
    win2016 = "ocid1.image.oc1.iad.aaaaaaaauwpipy7yex62fvqix7a7ipdzdhc6pdz57vkowvc4jhkfrazm6bwa"
  }
  us-langley-1    = {
    win2012 = "ocid1.image.oc2.us-langley-1.aaaaaaaaxsiaeacsw7cgfplf3aczsodwl4pjni6jwvkzfnp7kuibtqjio73q"
    win2016 = "ocid1.image.oc2.us-langley-1.aaaaaaaalyvr2r25i757olybmlgzm4723k6lfzkwdroognwr4u7xoko6v7sq"
  }
  us-luke-1       = {
    win2012 = "ocid1.image.oc2.us-luke-1.aaaaaaaaboxvaltt2q6qwpd2sjgt7nuwjorypzgrokvnjah3uogsot4jq3mq"
    win2016 = "ocid1.image.oc2.us-luke-1.aaaaaaaapppr45azjlizyjjytxtsues7io2tfaaeflgoyarbo3igp6ksfi4a"
  }
  us-phoenix-1    = {
    win2012 = "ocid1.image.oc1.phx.aaaaaaaax2mezrt7apbf3kzyh4mobfk2ontcryn43aoqndcpbwea2vsotpmq"
    win2016 = "ocid1.image.oc1.phx.aaaaaaaan57vn7nfbjtklcc2e46jzylum7d3jnb762erd26evl3xhnvoceya"
  }
}

win_instance_params = {
  win01 = {
    ad                   = 1
    shape                = "VM.Standard2.4"
    hostname             = "win01"
    boot_volume_size     = 400
    assign_public_ip     = true
    preserve_boot_volume = true
    compartment_name     = "sandbox"
    subnet_name          = "hur1pub"
    device_disk_mappings = "D:50GB E:60GB F:60GB"
    freeform_tags = {
      "client" : "hurricane",
      "department" : "hurricane"
    }
    kms_key_name       = ""
    block_vol_att_type = "paravirtualized"
    encrypt_in_transit = false
    enable_admin       = "yes"
    fd                 = 1
    image_version      = "win2016"
    nsgs               = ["hurricane1"]
  }
  win02 = {
    ad                   = 1
    shape                = "VM.Standard2.4"
    hostname             = "win02"
    boot_volume_size     = 400
    assign_public_ip     = true
    preserve_boot_volume = true
    compartment_name     = "sandbox"
    subnet_name          = "hur1pub"
    device_disk_mappings = "D:50GB E:90GB F:90GB"
    freeform_tags = {
      "client" : "hurricane",
      "department" : "hurricane"
    }
    kms_key_name       = ""
    block_vol_att_type = "iscsi"
    encrypt_in_transit = false
    enable_admin       = "no"
    fd                 = 1
    image_version      = "win2016"
    nsgs               = []
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
    kms_key_name       = ""
    performance        = "Balanced"
    encrypt_in_transit = false
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
    kms_key_name       = ""
    performance        = "Balanced"
    encrypt_in_transit = false
  }
  winbv12 = {
    ad            = 1
    display_name  = "winbv12"
    bv_size       = 60
    instance_name = "win01"
    freeform_tags = {
      "client" : "hurricane",
      "department" : "hurricane"
    }
    kms_key_name       = ""
    performance        = "Balanced"
    encrypt_in_transit = false
  }
  winbv20 = {
    ad            = 1
    display_name  = "winbv20"
    bv_size       = 90
    instance_name = "win02"
    freeform_tags = {
      "client" : "hurricane",
      "department" : "hurricane"
    }
    kms_key_name       = ""
    performance        = "Balanced"
    encrypt_in_transit = true
  }
  winbv21 = {
    ad            = 1
    display_name  = "winbv21"
    bv_size       = 50
    instance_name = "win02"
    freeform_tags = {
      "client" : "hurricane",
      "department" : "hurricane"
    }
    kms_key_name       = ""
    performance        = "High"
    encrypt_in_transit = false
  }
  winbv22 = {
    ad            = 1
    display_name  = "winbv22"
    bv_size       = 90
    instance_name = "win02"
    freeform_tags = {
      "client" : "hurricane",
      "department" : "hurricane"
    }
    kms_key_name       = ""
    performance        = "High"
    encrypt_in_transit = false
  }
}

kms_key_ids = {}

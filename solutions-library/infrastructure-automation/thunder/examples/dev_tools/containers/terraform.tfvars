compartment_ids = {
   db_rampup = "ocid1.compartment.oc1..aaaaaaaaaba37tpcye2nbepuyfzf35ain7urlhqtnccb6a4kdik2zmtdpera"
}

subnet_ids = {
  IPSEC2     = "ocid1.subnet.oc1.ap-mumbai-1.aaaaaaaaptovlwt5765nice3rlfq5t3jknyk5eoz2zcre4eiutkg4pmx42fq"
  okesubnet1 = "ocid1.subnet.oc1.ap-mumbai-1.aaaaaaaamomleuf57qcmjivl76wban2tf63k3a2yka5fwbthqpkvbrjquc5q"
  okesubnet2 = "ocid1.subnet.oc1.ap-mumbai-1.aaaaaaaaeupylpqs5pr2h77q55otkukciusmi5h3m2pfpbatqhzj4pb7dn5q"
  okesubnet3 = "ocid1.subnet.oc1.ap-mumbai-1.aaaaaaaawqsqizobit6to5uec5qkc744czujjrrniqhq2ajapdwvmeicaiyq"
}

vcn_ids = {
  IPSEC2 = "ocid1.vcn.oc1.ap-mumbai-1.amaaaaaauvrz6sqadyyrn6jjdvbtdip7qexg44m7dm6rhvv7drchbnxqo4aa"
}

cluster_params = {
  cluster1 = {
    compartment_name                = "db_rampup"
    cluster_name                    = "cluster1"
    kubernetes_version              = "v1.15.7"
    use_encryption                  = false
    kms_key_id                      = ""
    vcn_name                        = "IPSEC2"
    is_kubernetes_dashboard_enabled = true
    is_tiller_enabled               = true
    pods_cidr                       = "10.244.0.0/16"
    services_cidr                   = "10.96.0.0/16"
    service_lb_subnet_names         = ["IPSEC2"]
  }
}

nodepools_params = {
  pool1 = {
    compartment_name = "db_rampup"
    cluster_name     = "cluster1"
    pool_name        = "pool1"
    subnet_name      = "okesubnet1"
    size             = 3
    node_shape       = "VM.Standard2.1"
    ssh_public_key   = "/root/.ssh/id_rsa.pub"
    placement_configs = [
      {
        ad     = 1
        subnet = "IPSEC2"
      },
      {
        ad     = 1
        subnet = "IPSEC2"
      },
      {
        ad     = 1
        subnet = "IPSEC2"
      },
    ]
  }
  pool2 = {
    compartment_name = "db_rampup"
    cluster_name     = "cluster1"
    pool_name        = "pool2"
    subnet_name      = "okesubnet2"
    size             = 3
    node_shape       = "VM.Standard2.1"
    ssh_public_key   = "/root/.ssh/id_rsa.pub"
    placement_configs = [
      {
        ad     = 1
        subnet = "IPSEC2"
      },
    ]
  }
  pool3 = {
    compartment_name = "db_rampup"
    cluster_name     = "cluster1"
    pool_name        = "pool3"
    subnet_name      = "okesubnet3"
    size             = 3
    node_shape       = "VM.Standard2.1"
    ssh_public_key   = "/root/.ssh/id_rsa.pub"
    placement_configs = [
      {
        ad     = 1
        subnet = "IPSEC2"
      },
    ]
 }
}

linux_images = {
  # Oracle-Linux-7.7-2020.02.21-0
  # from https://docs.cloud.oracle.com/en-us/iaas/images/image/957e74db-0375-4918-b897-a8ce93753ad9/
  ap-melbourne-1  = "ocid1.image.oc1.ap-melbourne-1.aaaaaaaavpiybmiqoxcohpiih2gasjgqpsiyz4ggylyhhitmrmf3j2ycucrq"
  ap-mumbai-1     = "ocid1.image.oc1.ap-mumbai-1.aaaaaaaarrsp6bazleeeghz6jcifatswozlqkoffzwxzbt2ilj2f65ngqi6a"
  ap-osaka-1      = "ocid1.image.oc1.ap-osaka-1.aaaaaaaafa5rhs2n3dyuncddh5oynk6gisvotvcvch3e6xwplji7phwtbqqa"
  ap-seoul-1      = "ocid1.image.oc1.ap-seoul-1.aaaaaaaadrnhec6655uedkshgcklewzikoqcwr65sevbu27z7vzagniihfha"
  ap-sydney-1     = "ocid1.image.oc1.ap-sydney-1.aaaaaaaaplq4fjdnoooudaqwgzaidh6r3lp3xdhqulx454jivy33t53hokga"
  ap-tokyo-1      = "ocid1.image.oc1.ap-tokyo-1.aaaaaaaa5mpgmnwqwacey5gvczawugmo3ldgrjqnleckmnsokrqytcfkzspa"
  ca-montreal-1   = "ocid1.image.oc1.ca-montreal-1.aaaaaaaaevu23evecil3r23q5illjliinkpyvtkbdq5nsxmcfqypvlewytra"
  ca-toronto-1    = "ocid1.image.oc1.ca-toronto-1.aaaaaaaai25l5mqlzvhjzxvb5n4ullqu333bmalyyg3ki53vt24yn6ld7pra"
  eu-amsterdam-1  = "ocid1.image.oc1.eu-amsterdam-1.aaaaaaaayd4knq4bdh23zqgatgjhoajiz3mx4fy3oy62e5f45ll7trwak5ga"
  eu-frankfurt-1  = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaa4cmgko5la45jui5cuju7byv6dgnfnjbxhwqxaei3q4zjwlliptuq"
  eu-zurich-1     = "ocid1.image.oc1.eu-zurich-1.aaaaaaaa4nwf5h6nl3u5cdauemg352itja6izecs7ol73z6jftsg4agpdsma"
  me-jeddah-1     = "ocid1.image.oc1.me-jeddah-1.aaaaaaaazrvioeng7va7w4qsuqny4jtxbvnxlf5hu7g2twn6rcwdu35u4riq"
  sa-saopaulo-1   = "ocid1.image.oc1.sa-saopaulo-1.aaaaaaaalfracz4kuew4yxvgydpnbitip6qsreaz7kpxlkr4p67ravvi4jnq"
  uk-gov-london-1 = "ocid1.image.oc4.uk-gov-london-1.aaaaaaaaslh4pip7u6iopbpxujy2twi7diqrs6kfvqfhkl27esdadkqa76mq"
  uk-london-1     = "ocid1.image.oc1.uk-london-1.aaaaaaaa2uwbd457cd2gtviihmxw7cqfmqcug4ahdg7ivgyzla25pgrn6soa"
  us-ashburn-1    = "ocid1.image.oc1.iad.aaaaaaaavzjw65d6pngbghgrujb76r7zgh2s64bdl4afombrdocn4wdfrwdq"
  us-langley-1    = "ocid1.image.oc2.us-langley-1.aaaaaaaauckkms7acrl6to3cuhmv6hfjqwlnoxzuzophaose7pi2sfk4dzna"
  us-luke-1       = "ocid1.image.oc2.us-luke-1.aaaaaaaadxeycutztmvaeefvilc57lfqool2rlgl2r34juyu4jkbodx2xspq"
  us-phoenix-1    = "ocid1.image.oc1.phx.aaaaaaaacy7j7ce45uckgt7nbahtsatih4brlsa2epp5nzgheccamdsea2yq"
}
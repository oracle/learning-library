compartment_ids = {
  sandbox = "ocid1.compartment.oc1..aaaaaaaaiu3vfcpbjwwgpil3xakqts4jhtjq42kktmisriiszdvvouwsirgq"
}
subnet_ids      = {
  hur1pub  = "ocid1.subnet.oc1.iad.aaaaaaaa2c7arzk7ur3vaaom44erjti6bcot2ihd4ikokkoens7mxnwfzcba"
  hur1priv = "ocid1.subnet.oc1.eu-zurich-1.aaaaaaaaqmrzegawxhx3lem554otznorygybovk7a5ek5i75opbwv7kvo6yq"
}

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

backend_sets      = {}
load_balancer_ids = {}

asg_params = {
  asg1 = {
    compartment_name = "sandbox"
    name             = "asg1"
    freeform_tags    = {}
    shape            = "VM.Standard2.1"
    assign_public_ip = "true"
    ssh_public_key   = "/root/.ssh/id_rsa.pub"
    hostname         = "asg1"
    size             = 2
    state            = "RUNNING" # Can be RUNNING or STOPPED
    p_config         = [
      {
        ad     = 1
        subnet = "hur1pub"
      },
      {
        ad     = 2
        subnet = "hur1pub"
      },
      {
        ad     = 3
        subnet = "hur1pub"
      }
    ]
    lb_config        = []
    initial_capacity = 2
    max_capacity     = 6
    min_capacity     = 2
    policy_name      = "asg_policy"
    policy_type      = "threshold"
    rules            = [
      {
        rule_name    = "scaleUp"
        action_type  = "CHANGE_COUNT_BY"
        action_value = 2
        metrics      = [
          {
            metric_type     = "CPU_UTILIZATION"
            metric_operator = "GT"
            threshold_value = 70
          }
        ]
      },
      {
        rule_name    = "scaleDown"
        action_type  = "CHANGE_COUNT_BY"
        action_value = -1
        metrics      = [
          {
            metric_type     = "CPU_UTILIZATION"
            metric_operator = "LT"
            threshold_value = 30
          }
        ]
      }
    ]
    cool_down_in_seconds   = 300
    is_autoscaling_enabled = true
  }
}
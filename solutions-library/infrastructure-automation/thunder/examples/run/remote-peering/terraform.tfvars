// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.

provider_path = "peering.auto.tfvars"

compartment_ids = {
  sandbox = "ocid1.compartment.oc1..aaaaaaaaiu3vfcpbjwwgpil3xakqts4jhtjq42kktmisriiszdvvouwsirgq"
}

vcn_params = {
  hur1 = {
    compartment_name = "sandbox"
    display_name     = "hur1"
    vcn_cidr         = "10.0.0.0/16"
    dns_label        = "hur1"
  }
}

vcn_params_second = {
  hur2 = {
    compartment_name = "sandbox"
    display_name     = "hur2"
    vcn_cidr         = "11.0.0.0/16"
    dns_label        = "hur2"
  }
}

igw_params = {
  hurricane1 = {
    display_name = "hurricane1"
    vcn_name     = "hur1"
  }
}

igw_params_second = {
  hurricane2 = {
    display_name = "hurricane2"
    vcn_name     = "hur2"
  }
}

ngw_params = {
  hurricane1 = {
    display_name = "hurricane1"
    vcn_name     = "hur1"
  }
}

ngw_params_second = {
  hurricane2 = {
    display_name = "hurricane2"
    vcn_name     = "hur2"
  }
}

rt_params = {
  hurricane1pub = {
    display_name = "hurricane1pub"
    vcn_name     = "hur1"

    route_rules = [
      {
        destination = "0.0.0.0/0"
        use_igw     = true
        igw_name    = "hurricane1"
        ngw_name    = null
      },
    ]
  },
  hurricane1priv = {
    display_name = "hurricane1priv"
    vcn_name     = "hur1"

    route_rules = [
      {
        destination = "0.0.0.0/0"
        use_igw     = false
        igw_name    = null
        ngw_name    = "hurricane1"
      },
    ]
  }
}

rt_params_second = {
  hurricane2pub = {
    display_name = "hurricane2pub"
    vcn_name     = "hur2"

    route_rules = [
      {
        destination = "0.0.0.0/0"
        use_igw     = true
        ngw_name    = null
        igw_name    = "hurricane2"
      },
    ]
  },
  hurricane2priv = {
    display_name = "hurricane2priv"
    vcn_name     = "hur2"

    route_rules = [
      {
        destination = "0.0.0.0/0"
        use_igw     = false
        ngw_name    = "hurricane2"
        igw_name    = null
      },
    ]
  }
}

sl_params = {
  Hurricane1 = {
    vcn_name     = "hur1"
    display_name = "Hurricane1"

    egress_rules = [
      {
        stateless   = "false"
        protocol    = "all"
        destination = "0.0.0.0/0"
      },
    ]

    ingress_rules = [
      {
        stateless   = "false"
        protocol    = "6"
        source      = "0.0.0.0/0"
        source_type = "CIDR_BLOCK"
        tcp_options = []
        udp_options = []
      },
      {
        stateless   = "false"
        protocol    = "6"
        source      = "10.4.0.0/16"
        source_type = "CIDR_BLOCK"

        tcp_options = [
          {
            min = "80"
            max = "80"
          },
        ]

        udp_options = []
      },
      {
        stateless   = "false"
        protocol    = "17"
        source      = "10.4.0.0/16"
        source_type = "CIDR_BLOCK"

        tcp_options = []

        udp_options = [
          {
            min = "80"
            max = "80"
          },
        ]
      },
    ]
  }
}

sl_params_second = {
  Hurricane2 = {
    vcn_name     = "hur2"
    display_name = "Hurricane2"

    egress_rules = [
      {
        stateless   = "false"
        protocol    = "all"
        destination = "0.0.0.0/0"
      },
    ]

    ingress_rules = [
      {
        stateless   = "false"
        protocol    = "6"
        source      = "0.0.0.0/0"
        source_type = "CIDR_BLOCK"
        tcp_options = []
        udp_options = []
      },
      {
        stateless   = "false"
        protocol    = "6"
        source      = "10.4.0.0/16"
        source_type = "CIDR_BLOCK"

        tcp_options = [
          {
            min = "80"
            max = "80"
          },
        ]

        udp_options = []
      },
      {
        stateless   = "false"
        protocol    = "17"
        source      = "10.4.0.0/16"
        source_type = "CIDR_BLOCK"

        tcp_options = []

        udp_options = [
          {
            min = "80"
            max = "80"
          },
        ]
      },
    ]
  },
}

nsg_params = {
  hurricane1 = {
    display_name = "hurricane1"
    vcn_name     = "hur1"
  }
}

nsg_params_second = {
  hurricane2 = {
    display_name = "hurricane2"
    vcn_name     = "hur2"
  }
}

nsg_rules_params = {
  hurricane1 = {
    nsg_name         = "hurricane1"
    protocol         = "6"
    stateless        = "false"
    direction        = "INGRESS"
    source           = "11.0.0.0/16"
    source_type      = "CIDR_BLOCK"
    destination      = null
    destination_type = null
    tcp_options = [
      {
        destination_ports = [
          {
            min = 22
            max = 22
          }
        ],
        source_ports = []
      }
    ]
    udp_options = []
  }
}

nsg_rules_params_second = {
  hurricane2 = {
    nsg_name         = "hurricane2"
    protocol         = "17"
    stateless        = "false"
    direction        = "EGRESS"
    destination      = "10.0.0.0/16"
    destination_type = "CIDR_BLOCK"
    source           = null
    source_type      = null
    udp_options = [
      {
        source_ports = [
          {
            min = 22
            max = 22
          }
        ],
        destination_ports = []
      }
    ]
    tcp_options = []
  }
}

subnet_params = {
  hur1pub = {
    display_name      = "hur1pub"
    cidr_block        = "10.0.1.0/24"
    dns_label         = "hur1pub"
    is_subnet_private = false
    sl_name           = "Hurricane1"
    rt_name           = "hurricane1pub"
    vcn_name          = "hur1"
  }
  hur1priv = {
    display_name      = "hur1priv"
    cidr_block        = "10.0.2.0/24"
    dns_label         = "hur1priv"
    is_subnet_private = true
    sl_name           = "Hurricane1"
    rt_name           = "hurricane1priv"
    vcn_name          = "hur1"
  }
}

subnet_params_second = {
  hur2pub = {
    display_name      = "hur2pub"
    cidr_block        = "11.0.1.0/24"
    dns_label         = "hur2pub"
    is_subnet_private = false
    sl_name           = "Hurricane2"
    rt_name           = "hurricane2pub"
    vcn_name          = "hur2"
  }
  hur2priv = {
    display_name      = "hur2priv"
    cidr_block        = "11.0.2.0/24"
    dns_label         = "hur2priv"
    is_subnet_private = true
    sl_name           = "Hurricane2"
    rt_name           = "hurricane2priv"
    vcn_name          = "hur2"
  }
}

lpg_params = {
}

lpg_params_second = {
}

# VCN Remote Peering - between Region 1 and Region 2
rpg_params = [
  {
    compartment_name   = "sandbox"
    vcn_name_requestor = "hur1"
    vcn_name_acceptor  = "hur2"
  },
]

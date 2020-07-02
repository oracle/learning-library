## VARIABLES ########################################################################################################
variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "region" {}

variable "compartment_ocid" {}
variable "ssh_public_key" {}
variable "ssh_private_key" {}

# Defines the number of instances to deploy
variable "NumInstances" {
    default = "1"
}

# Defines the number of volumes to create and attach to each instance
# NOTE: Changing this value after applying it could result in re-attaching existing volumes to different instances.
# This is a result of using 'count' variables to specify the volume and instance IDs for the volume attachment resource.
variable "NumVolumesPerInstance" {
    default = "1"
}

# Choose an Availability Domain
variable "AD" {
    default = "1"
}

variable "InstanceShape" {
    default = "VM.Standard2.1"
}

variable "InstanceImageOCID" {
    type = "map"
    default = {
        // Oracle-provided image "Oracle-Linux-7.4-2017.12.18-0"
        // See https://docs.us-phoenix-1.oraclecloud.com/Content/Resources/Assets/OracleProvidedImageOCIDs.pdf
        us-phoenix-1 = "ocid1.image.oc1.phx.aaaaaaaasc56hnpnx7swoyd2fw5gyvbn3kcdmqc2guiiuvnztl2erth62xnq"
        us-ashburn-1 = "ocid1.image.oc1.iad.aaaaaaaaxrqeombwty6jyqgk3fraczdd63bv66xgfsqka4ktr7c57awr3p5a"
        eu-frankfurt-1 = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaayxmzu6n5hsntq4wlffpb4h6qh6z3uskpbm5v3v4egqlqvwicfbyq"
    }
}

variable "DBSize" {
    default = "50" // size in GBs
}

variable "BootStrapFile" {
    default = "./userdata/bootstrap"
}

#####################################################################################################################################
##User Data variable - instead of including an external file for the cloud init script, it can be defined here
variable "user-data" {
  default = <<EOF
#!/bin/bash -x
echo '################### userdata begins #####################'
touch ~opc/userdata.`date +%s`.start

# echo '########## yum update ###############'
# yum update -y
touch ~opc/userdata.`date +%s`.finish
echo '################### userdata ends #######################'
EOF
}


## PROVIDER ########################################################################################################

provider "oci" {
  tenancy_ocid = "${var.tenancy_ocid}"
  user_ocid = "${var.user_ocid}"
  fingerprint = "${var.fingerprint}"
  private_key_path = "${var.private_key_path}"
  region = "${var.region}"
  disable_auto_retries = "true"
}

## DATASOURCES #####################################################################################################

# Gets a list of Availability Domains
data "oci_identity_availability_domains" "ADs" {
    compartment_id = "${var.tenancy_ocid}"
}
data "oci_core_images" "OL76ImageOCID" {
        compartment_id = "${var.compartment_ocid}"
        operating_system = "Oracle Linux"
        operating_system_version = "7.7"
        #compatible shape
        shape = "VM.Standard.E2.1"
}
## NETWORKING RESOURCES ############################################################################################
resource "oci_core_virtual_network" "ExampleVCN" {
  cidr_block = "10.1.0.0/16"
  compartment_id = "${var.compartment_ocid}"
  display_name = "TFExampleVCN"
  dns_label = "tfexamplevcn"
}

resource "oci_core_subnet" "ExampleSubnet" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[var.AD - 1],"name")}"
  cidr_block = "10.1.20.0/24"
  display_name = "TFExampleSubnet"
  dns_label = "tfexamplesubnet"
  ## security_list_ids = ["${oci_core_virtual_network.ExampleVCN.default_security_list_id}"] ## Use Example SL instead of default.
  security_list_ids   = ["${oci_core_security_list.ExampleSL.id}"]

  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${oci_core_virtual_network.ExampleVCN.id}"
  route_table_id = "${oci_core_route_table.ExampleRT.id}"
  dhcp_options_id = "${oci_core_virtual_network.ExampleVCN.default_dhcp_options_id}"
}

resource "oci_core_internet_gateway" "ExampleIG" {
  compartment_id = "${var.compartment_ocid}"
  display_name = "TFExampleIG"
  vcn_id = "${oci_core_virtual_network.ExampleVCN.id}"
}

resource "oci_core_route_table" "ExampleRT" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${oci_core_virtual_network.ExampleVCN.id}"
  display_name = "TFExampleRouteTable"
  route_rules {
    cidr_block = "0.0.0.0/0"
    network_entity_id = "${oci_core_internet_gateway.ExampleIG.id}"
  }
}

resource "oci_core_security_list" "ExampleSL" {
  compartment_id = "${var.compartment_ocid}"
  display_name   = "ExampleSL"
  vcn_id         = "${oci_core_virtual_network.ExampleVCN.id}"

  egress_security_rules {
    protocol    = "all"
    destination = "0.0.0.0/0"
  }

  ingress_security_rules {
    tcp_options {
      max = 22
      min = 22
    }

    protocol = "6"
    source   = "0.0.0.0/0"
  }
  ingress_security_rules  {
      icmp_options {
        type = 0
      }

      protocol = 1
      source   = "0.0.0.0/0"
    }

  ingress_security_rules  {
      icmp_options {
        type = 8
      }

      protocol = 1
      source   = "0.0.0.0/0"
    }

}



## BLOCK RESOURCES ############################################################################################

resource "oci_core_volume" "TFBlock" {
  count = "${var.NumInstances * var.NumVolumesPerInstance}"
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[var.AD - 1],"name")}"
  compartment_id = "${var.compartment_ocid}"
  display_name = "TFBlock${count.index}"
  size_in_gbs = "${var.DBSize}"
}

resource "oci_core_volume_attachment" "TFBlockAttach" {
    count = "${var.NumInstances * var.NumVolumesPerInstance}"
    attachment_type = "iscsi"
    instance_id = "${oci_core_instance.TFInstance.*.id[count.index / var.NumVolumesPerInstance]}"
    volume_id = "${oci_core_volume.TFBlock.*.id[count.index]}"
}



## COMPUTE RESOURCES ############################################################################################

resource "oci_core_instance" "TFInstance" {
  count = "${var.NumInstances}"
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[var.AD - 1],"name")}"
  compartment_id = "${var.compartment_ocid}"
  display_name = "TFInstance${count.index}"
  source_details {
    source_type = "image"
    source_id   = "${lookup(data.oci_core_images.OL76ImageOCID.images[0], "id")}"
  }
shape = "${var.InstanceShape}"

  create_vnic_details {
    subnet_id = "${oci_core_subnet.ExampleSubnet.id}"
    display_name = "primaryvnic"
    assign_public_ip = true
    hostname_label = "tfexampleinstance${count.index}"
  }

  metadata = {
    ssh_authorized_keys = "${var.ssh_public_key}"
    user_data = "${base64encode(var.user-data)}"
  }

  timeouts {
    create = "60m"
  }
}


## REMOTE EXEC PROVISIONER ############################################################################################

resource "null_resource" "remote-exec" {
    depends_on = ["oci_core_instance.TFInstance","oci_core_volume_attachment.TFBlockAttach"]
    count = "${var.NumInstances * var.NumVolumesPerInstance}"
    provisioner "remote-exec" {
      connection {
        agent = false
        timeout = "30m"
        host = "${oci_core_instance.TFInstance.*.public_ip[count.index % var.NumInstances]}"
        user = "opc"
        private_key = "${var.ssh_private_key}"
    }
      inline = [
        "touch ~/IMadeAFile.Right.Here",
        "sudo iscsiadm -m node -o new -T ${oci_core_volume_attachment.TFBlockAttach.*.iqn[count.index]} -p ${oci_core_volume_attachment.TFBlockAttach.*.ipv4[count.index]}:${oci_core_volume_attachment.TFBlockAttach.*.port[count.index]}",
        "sudo iscsiadm -m node -o update -T ${oci_core_volume_attachment.TFBlockAttach.*.iqn[count.index]} -n node.startup -v automatic",
        "echo sudo iscsiadm -m node -T ${oci_core_volume_attachment.TFBlockAttach.*.iqn[count.index]} -p ${oci_core_volume_attachment.TFBlockAttach.*.ipv4[count.index]}:${oci_core_volume_attachment.TFBlockAttach.*.port[count.index]} -l >> ~/.bashrc"
      ]
    }
}

## OUTPUTS ############################################################################################
# Output the private and public IPs of the instance
output "InstancePrivateIPs" {
value = ["${oci_core_instance.TFInstance.*.private_ip}"]
}

output "InstancePublicIPs" {
value = ["${oci_core_instance.TFInstance.*.public_ip}"]
}

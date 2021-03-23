# Compute Examples

## Introduction

Oracle Cloud Infrastructure Compute offers significant price-performance and control improvements compared to on-premise data centers, while providing the elasticity and cost savings of the public cloud. Oracle has a longstanding reputation for providing technologies that empower enterprises to solve demanding business problems—and Oracle Cloud Infrastructure is the first cloud that's purpose-built to enable enterprises to run business-critical production workloads.


## Description

The Compute module is able to create linux and windows instances with block volumes attached

- Linux instances parameters
    - ad - ad of the instance
    - shape - The shape of the instance
    - hostname - The instance hostname
    - boot\_volume\_size - The size of the boot volume in GBs
    - preserve\_boot\_volume - Whether to preserve or not the boot volume
    - assign\_public\_ip - Whether or not to assign a public ip to the instance (to assing a public ip, the instance should be in a public subnet)
    - compartment_name - The compartment name in which the instance will be created
    - subnet_name - The subnet name in which the instance will be created
    - ssh\_public\_key - The path to ssh public key
    - device\_disk\_mappings - Key value pair between the mount point and block storage device
    - freeform_tags - The freeform tags for the instances
    - kms\_key\_name - The name of the KMS master key that will be used for encrypting the boot volume. Empty string "" means that the KMS will not be used and the boot volume will be encrypted using Oracle-managed keys
    - block\_vol\_att\_type - The type of block volume attachments. Can be iscsi or paravirtualized.
    - encrypt\_in\_transit - Whether or not the encryption in transit should be enabled for the boot volume
    - fd - The fault domain in which the instance will be created. Can be 1, 2 or 3.
    - image_version - The name of the image version (can be centos6, centos7, oel6, oel7)
    - nsgs - A list of the nsg names to attach to the instance

- Linux instances block volume parameters
    - ad - The ad of the block volume
    - display_name - The display name of the block volume
    - bv_size - The block volume size
    - instance_name - The name of the instance used for the block volume association
    - device_name - The device name (Examples: /dev/oracleoci/oraclevdb, /dev/oracleoci/oraclevdc)
    - freeform_tags - The freeform tags for the block volumes
    - kms\_key\_name - The name of the KMS master key that will be used for encrypting the block volume. Empty string "" means that the KMS will not be used and the block volume will be encrypted using Oracle-managed keys
    - performance - The performance for the block volumes. Can be Low, Balanced, High.
    - encrypt\_in\_transit - Whether or not the encryption in transit should be enable for the block volumes.

- Windows instances parameters
    - ad - ad of the instance
    - shape - The shape of the instance
    - hostname - The instance hostname
    - boot\_volume\_size - The size of the boot volume in GBs
    - preserve\_boot\_volume - Whether to preserve or not the boot volume
    - assign\_public\_ip - Whether or not to assign a public ip to the instance (to assing a public ip, the instance should be in a public subnet)
    - compartment_name - The compartment name in which the instance will be created
    - subnet_name - The subnet name in which the instance will be created
    - device\_disk\_mappings - Key value pair between the mount point and block storage device
    - freeform_tags - The freeform tags for the windows instances
    - kms\_key\_name - The name of the KMS master key that will be used for encrypting the boot volume. Empty string "" means that the KMS will not be used and the boot volume will be encrypted using Oracle-managed keys
    - block\_vol\_att\_type - The type of block volume attachments. Can be iscsi or paravirtualized.
    - encrypt\_in\_transit - Whether or not the encryption in transit should be enabled for the boot volume
    - enable_admin - Whether or not to enable the administrator for the windows instance. Set this to yes in order to have the administrator user enabled.
    - fd - The fault domain in which the instance will be created. Can be 1, 2 or 3.
    - image_version - The name of the image version (can be centos6, centos7, oel6, oel7)
    - nsgs - A list of the nsg names to attach to the instance

- Windows instances block volume parameters
    - ad - The ad of the block volume
    - display_name - The display name of the block volume
    - bv_size - The block volume size
    - instance_name - The name of the instance used for the block volume association
    - freeform_tags - The freeform tags for the windows block volumes
    - kms\_key\_name - The name of the KMS master key that will be used for encrypting the block volume. Empty string "" means that the KMS will not be used and the block volume will be encrypted using Oracle-managed keys
    - performance - The performance for the block volumes. Can be Low, Balanced, High.
    - encrypt\_in\_transit - Whether or not the encryption in transit should be enable for the block volumes.

## Dependencies
Apart from the **provider.auto.tfvars**, there may be some other dependencies in the **terraform.tfvars** file that you will have to address.
All the dependencies from this section should have resources that already exist in OCI.

### Compartment Dependency
In order to be able to run the sample code, you will have to prepare a map variable (like in the **terraform.tfvars** file) called **compartment\_ids**, which will hold key/value pairs with the names and ids of the compartments that you want to use.
This variable will be external in order to offer multiple ways of linking them from a terraform perspective.

```
compartment_ids = {
  sandbox = "ocid1.compartment.oc1..aaaaaaaaiu3vfcpbjwwgpil3xakqts4jhtjq42kktmisriiszdvvouwsirgq"
}
```

### Subnet Dependency
In order to be able to run the sample code, you will have to prepare a map variable (like in the **terraform.tfvars** file) called **subnet\_ids**, which will hold key/value pairs with the names and ids of the subnets that you want to use.
This variable will be external in order to offer multiple ways of linking them from a terraform perspective.

```
subnet_ids = {
  hur1pub  = "ocid1.subnet.oc1.eu-zurich-1.aaaaaaaapejshjhsljycynokehdhw47oh4vhp2rlakzudnlp5by6gsg6jzfa"
  hur1priv = "ocid1.subnet.oc1.eu-zurich-1.aaaaaaaamcf3qooqlrsoycjkegvqlet2gt3hbrsnurxjj2wezmjs3jhzke6q"
}
```

### NSG Dependency
In order to be able to run the sample code, you will have to prepare a map variable (like in the **terraform.tfvars** file) called **nsgs**, which will hold key/value pairs with the names and ids of the nsgs that you want to use.
This variable will be external in order to offer multiple ways of linking them from a terraform perspective.

```
nsgs = {
  "hurricane1" = "ocid1.networksecuritygroup.oc1.eu-zurich-1.aaaaaaaa7el3mcar2cyw27saug57twlgnf4yxkrfpr55mtz2giufe64cmv2a"
  "hurricane2" = "ocid1.networksecuritygroup.oc1.eu-zurich-1.aaaaaaaallx6bipfe53xr5si5ytdcd6lmgkvlzpytltznosyc2bfbgbegwwq"
}
```

## Example

In the provided example, the following resources are created:

- 2 Linux Instances
    - One has 6 block volumes attached
    - The other one has 1 block volume attached

- 2 Windows Instances
    - One with 3 block volumes attached
    - The other one with 2 block volumes attached

In the example from below, there is a list of compartments containing 1 elements and a list of subnets containing 2 elements. By setting in compute\_params `compartment_name` to sandbox, the instances will be created in the sandbox compartmanet `ocid1.compartment.oc1..aaaaaaaaiu3vfcpbjwwgpil3xakqts4jhtjq42kktmisriiszdvvouwsirgq`. The same thing is happening to the subnet_ids and nsgs. All lists can be extended in order to satisfy your needs.

Below there is a snippet based on terraform.tfvars values:

```
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
    device_disk_mappings = "D:50GB E:60GB F:70GB"
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
    device_disk_mappings = "D:50GB E:90GB"
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
    bv_size       = 70
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
}

kms_key_ids = {}

```

This is just an example, but the number of the resources can be increased/decreased to suit any needs by adding another map in the specific resource type.

Don't forget to populate the provider with the details of your tenancy as specified in the main README.md file.

## Running the code

Go to **thunder/examples/crawl/compute**
```
# Run init to get terraform modules
$ terraform init

# Create the infrastructure
$ terraform apply --var-file=path_to_provider.auto.tfvars

# If you are done with this infrastructure, take it down
$ terraform destroy --var-file=path_to_provider.auto.tfvars
```

## Useful Links

[Compute Overview](https://docs.cloud.oracle.com/iaas/Content/Compute/Concepts/computeoverview.htm)

[Terraform Compute Resource](https://www.terraform.io/docs/providers/oci/r/core_instance.html)

[Block Storage Overview](https://docs.cloud.oracle.com/iaas/Content/Block/Concepts/overview.htm)

[Terraform Block Storage Resource](https://www.terraform.io/docs/providers/oci/r/core_volume.html)

[Terraform Block Volume Attachment Resource](https://www.terraform.io/docs/providers/oci/r/core_volume_attachment.html)

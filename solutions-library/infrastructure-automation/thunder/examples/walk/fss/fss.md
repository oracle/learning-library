# File System Storage Examples

## Introduction
Oracle Cloud Infrastructure File Storage service provides a durable, scalable, secure, enterprise-grade network file system. You can connect to a File Storage service file system from any bare metal, virtual machine, or container instance in your Virtual Cloud Network (VCN). You can also access a file system from outside the VCN using Oracle Cloud Infrastructure FastConnect and Internet Protocol security (IPSec) virtual private network (VPN).

## Description

The terraform module uses the following variables:

* File System Storage parameters
    * ad - ad of the fss
    * name - The fss name
    * compartment_name - The compartment name in which the fss will be created
    * kms\_key\_name - The name of the KMS master key that will be used for encrypting the FSS. Empty string "" means that the KMS will not be used and the FSS will be encrypted using Oracle-managed keys
  
* Mount Target parameters
    * ad - ad of the mount target
    * name - The name of the mount target
    * compartment_name - The compartment name in which the mount target will be created
    * subnet_name - The subnet name in which the mount target will be created

* Export parameters
    * export\_set\_name - The mount target name which needs to be exported
    * filesystem_name - The filesystem name for the export options
    * path - The path used for the export (e.g /abcd)
    * export options
      * source - Clients these options should apply to. Must be a either single IPv4 address or single IPv4 CIDR block.
      * access - Type of access to grant clients using the file system through this export (e.g READ_ONLY)
      * identity -Used when clients accessing the file system through this export have their UID and GID remapped to 'anonymousUid' and 'anonymousGid'. If ALL, all users and groups are remapped; if ROOT, only the root user and group (UID/GID 0) are remapped; if NONE, no remapping is done. 
      * use_port - Whether or not to use a port for the export options


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

## Example
In the provided example, the following resources are created: 
* One File System Storage
* One Mount Target with one Export Set 
* One Export options for the Export Set


In the example from below, there is a list of compartments containing 1 element. By setting in fss\_params `compartment_name` to sandbox, The fss will be created in the first element of the list: `ocid1.compartment.oc1..aaaaaaaaiu3vfcpbjwwgpil3xakqts4jhtjq42kktmisriiszdvvouwsirgq`. The same thing happens for the subnet\_ids. All lists can be extended in order to satisfy your needs.


```
compartment_ids = {
  sandbox = "ocid1.compartment.oc1..aaaaaaaaiu3vfcpbjwwgpil3xakqts4jhtjq42kktmisriiszdvvouwsirgq"
}

subnet_ids = {
  hur1pub  = "ocid1.subnet.oc1.eu-zurich-1.aaaaaaaapejshjhsljycynokehdhw47oh4vhp2rlakzudnlp5by6gsg6jzfa"
  hur1priv = "ocid1.subnet.oc1.eu-zurich-1.aaaaaaaamcf3qooqlrsoycjkegvqlet2gt3hbrsnurxjj2wezmjs3jhzke6q"
}

fss_params = {
  thunder1 = {
    ad               = 1
    compartment_name = "sandbox"
    name             = "thunder1"
    kms_key_name = ""
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
        source   = "10.0.1.0/24"
        access   = "READ_WRITE"
        identity = "ROOT"
        use_port = true
      },
    ]
  }
}

```

By modifying terraform.tfvars, you can increase or decrease any number of the specified resources.
After the filesystem is created, it can be mounted as specified in [click_here](https://docs.cloud.oracle.com/iaas/Content/File/Tasks/mountingfilesystems.htm) on an existing instance.

Simple example of a mount target having `10.0.1.10` private ip and `/media` as path

```
sudo yum install nfs-utils
sudo mkdir -p /mnt/media
sudo mount 10.0.1.10:/media /mnt/media
```

## Running the code

Go to **thunder/examples/walk/fss**
```
# Run init to get terraform modules
$ terraform init

# Create the infrastructure
$ terraform apply --var-file=path_to_provider.auto.tfvars

# If you are done with this infrastructure, take it down
$ terraform destroy --var-file=path_to_provider.auto.tfvars
```


## Useful links
[FSS Overview](https://docs.cloud.oracle.com/iaas/Content/File/Concepts/filestorageoverview.htm)

[Terraform FSS](https://www.terraform.io/docs/providers/oci/r/file_storage_file_system.html)
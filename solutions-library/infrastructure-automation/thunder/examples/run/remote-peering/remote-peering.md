# Remote peering

## Introduction
This project will build a VCN peering relation between 2 VCNs in different regions. This is useful when the 2 VCNs need to communicate with each other.

An important thing to remember is that VCNs with overlapping CIDR addresses cannot be paired.

Also, routing rules are added in all of the routing tables from the 2 VCNs. The rules will ensure that the traffic for the other VCN will be sent to the proper DRG (Dynamic Routing Gateway). This happens for both directions of communication.

## Prerequisites
  * Terraform v0.12.9 or greater - <https://www.terraform.io/downloads.html/>
  * OCI Provider for Terraform v3.61 or greater - <https://github.com/oracle/terraform-provider-oci/releases>
  * Python v3.x - https://www.python.org/
  * Pip (for Python3) v9.x - https://pypi.python.org/pypi/pip
  * Pyhcl - https://pypi.org/project/pyhcl/
  * Backoff - https://pypi.org/project/backoff/
 
## Deployment
Install all the software components from the Prerequisites section. Use the links from each description.

You will have to generate an API signing key (public/private keys) and the public key should be uploaded in the OCI
console, for the iam user that will be used to create the resources. Also, you should make sure that this user has
enough permissions to create resources in OCI. In order to generate the API Signing key, follow the steps
from: <https://docs.us-phoenix-1.oraclecloud.com/Content/API/Concepts/apisigningkey.htm#How>
The API signing key will generate a fingerprint in the OCI console, and that fingerprint will be used in a terraform
file described below.

In addition to this, you are required to generate a ssh key for the user that will run the scripts.

You will need an oci provider which can be defined in an *.auto.tfvars file in your example folder and the values must reflect your OCI tenancy:
```
provider_oci = {
  tenancy              = ""
  user_id              = ""
  fingerprint          = ""
  key_file_path        = ""
  private_key_password = ""
  region               = ""
  region2              = ""
}
```

The name of the oci provider file must be entered in the terraform.tfvars file, in the provider_path variable:
```
provider_path = "peering.auto.tfvars"
```

## Description
The remote-peering module is able to create a peering relationship between VCNs in different regions

* provider_path parameter - the path of the file with the oci provider details

* VCN parameters
    * compartment_name - The name of the compartment in which the VCN will be created
    * display_name - The name of the vcn
    * vcn_cidr - The cidr block of the vcn
    * dns_label - The dns label of the vcn

* Remote peering parameters
    * compartment_name - The compartment name in which the VCNs were created
    * vcn\_name\_requestor - The name of the VCN from the first region
    * vcn\_name\_acceptor - The name of the VCN from the second region
 
## Example
In the provided example, the following resources are created:
* 2 VCNS
  * hur1 - VCN in the first region
  * hur2 - VCN in the second region
* Remote peering relationship between the 2 VCNs

Each of the 2 VCNs also have additional resources like: Internet Gateway, NAT Gateway, Route tables, etc.

The example is based on terraform.tfvars values:

```
provider_path = "peering.auto.tfvars"

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

# VCN Remote Peering - between Region 1 and Region 2
rpg_params = [
  {
    compartment_name   = "sandbox"
    vcn_name_requestor = "hur1"
    vcn_name_acceptor  = "hur2"
  },
]
```

## Running the code

Go to thunder->examples->run->remote-peering
```
# Run init to get terraform modules
$ terraform init

# Create the infrastructure
$ terraform apply

# If you are done with this infrastructure, take it down
$ terraform destroy
```

## Useful Links
[VCN Peering Overview](https://docs.cloud.oracle.com/en-us/iaas/Content/Network/Tasks/VCNpeering.htm)

[Remote VCN Peering](https://docs.cloud.oracle.com/en-us/iaas/Content/Network/Tasks/remoteVCNpeering.htm)

## Known issues
**At the moment, there are no known issues**

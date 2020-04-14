# Network Examples

## Introduction
Apart from IAM, one thing you will need in order to create your resources is a network.
This example aims to help with creating an independent network with the majority of the components available in OCI.

## Description

The Network module is able to create vcns, subnets, internet gateways, nat gateways, security lists and network security groups, local peering gateways, dynamic routing gateways.

* VCN parameters
    * compartment_name - The name of the compartment in which the VCN will be created
    * display_name - The name of the vcn
    * vcn_cidr - The cidr block of the vcn
    * dns_label - The dns label of the vcn

* Internet Gateway parameters
    * display_name - The display name of the Intenet gateway
    * vcn_name - The name of the vcn used for the internet gateway association

* Nat Gateway parameters
    * display_name - The display name of the NAT gateway
    * vcn_name - The name of the vcn used for the NAT gateway association

* Route Table parameters
    * display_name - The display name of the Route Table
    * vcn_name - The name of the vcn used for the Route Table association
    * route_rules parameters
        * destination - Cidr block destination
        * use_igw - Whether you want to use an Internet Gateway in the route rule
        * igw_name - The name of the internet gateway used for the Route Table association
        * ngw_name - The name of the nat gateway used for the Route Table assocation

* Security Lists parameters
    * display_name - The display name of the Security Lists
    * vcn_name - The name of the vcn used for the Security Lists association
    * egress_rules parameters
      * stateless - Whether the rule is staless or not
      * protocol - Can be set to 1 (ICMP), 6 (TCP), 17 (UDP) or ALL
      * destination - cidr block destination
    * ingress_rules parameters
      * stateless - Whether the rule is staless or not
      * protocol - Can be set to 1 (ICMP), 6 (TCP), 17 (UDP) or ALL
      * source\_type - Can be CIDR\_BLOCK or SERVICE\_CIDR_BLOCK
      * source - cidr block source
      * tcp_options parameters (can be an empty list and no tcp rules will be created)
        * min - port value
        * max - port value
      * udp_options parameters (can be an empty list and no udp rules will be created)
        * min - port value
        * max - port value

* Network Security Group parameters
    * display_name - The display name of the NSG
    * vcn_name - The name of the vcn used for the NSG association

* Network Security Groups Rules parameters
    * nsg_name - The name of the NSG used for the NSG rule association
    * protocol - Can be set to 1 (ICMP), 6 (TCP), 17 (UDP) or ALL
    * stateless - Whether the rule is staless or not
    * direction - Can be INGRESS (will force source and source type rules) or EGRESS (will force destination and destination type rules)
    * destination - cidr block destination (null if the direction is set to INGRESS)
    * destination\_type - Can be CIDR\_BLOCK (null if the direction is set to INGRESS)
    * source - cidr block source (null if the direction is set to EGRESS)
    * source\_type - Can be CIDR\_BLOCK (null if the direction is set to EGRESS)
    * tcp_options parameters (can be an empty list and no tcp rules will be created)
      * destination\_ports parameters (can be an empty list if you want to use source\_ports)
        * min - port value
        * max - port value
      * source\_ports parameters (can be an empty list if you want to use destination\_ports)
        * min - port value
        * max - port value
    * udp_options parameters (can be an empty list and no udp rules will be created)
      * destination\_ports parameters (can be an empty list if you want to use source\_ports)
        * min - port value
        * max - port value
      * source\_ports parameters (can be an empty list if you want to use destination\_ports)
        * min - port value
        * max - port value

* Subnet parameters
    * display_name - The name of the subnet
    * vcn_cidr - The cidr block of the subnet
    * dns_label - The dns label of the subnet
    * is\_subnet\_private - Whether the subnet is private or not
    * sl_name - The name of the security list used for the Subnet association
    * rt_name - The name of the route table used for the Subnet association
    * vcn_name - The name of the vcn used for the Subnet association

* Local peering gateway (LPG) parameters
    * requestor - The name of the requestor VCN
    * acceptor - The name of the acceptor VCN
    * display_name - The name of the LPG connection

* Dynamic Routing Gateway (DRG) parameters
    * name - The name of the DRG
    * vcn_name - The name of the vcn used for the DRG association
    * cidr_rt - The route rule cidr for the RTs that route the traffic through that DRG
    * rt_names - The names of the Route tables used for the DRG association

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

## Example
In the provided example, the following resources are created: 
* 2 VCNS
  * hurricane 1
    * One Internet Gateway
    * One Nat Gateway
    * 2 Route tables (one with igw rule, the other with ngw rule)
    * One Security List
    * One NSG with INGRESS rules
    * 2 Subnets (one public, one private)

  * hurricane 2
    * One Internet Gateway
    * One Nat Gateway
    * 2 Route tables (one with igw rule, the other with ngw rule)
    * One Security List
    * One NSG with EGRESS rules
    * 2 Subnets (one public, one private)


In the example from below, there is a list of compartments containing 1 element. By setting in vcn_params `compartment_name` to sandbox, the network will be created in the first element of the list: `ocid1.compartment.oc1..aaaaaaaaiu3vfcpbjwwgpil3xakqts4jhtjq42kktmisriiszdvvouwsirgq`.
All variables can be extended in order to satisfy your needs.


The example is based on **terraform.tfvars** values.
Below there is a small part of the **terraform.tfvars** file, in order to be able to understand the linking between the resources.

```
compartment_ids = {
  sandbox = "ocid1.compartment.oc1..aaaaaaaaiu3vfcpbjwwgpil3xakqts4jhtjq42kktmisriiszdvvouwsirgq"
}

vcn_params = {
  hur1 = {
    compartment_name  = "sandbox"
    display_name      = "hur1"
    vcn_cidr          = "10.0.0.0/16"
    dns_label         = "hur1"
  }
  hur2 = {
    compartment_name  = "sandbox"
    display_name      = "hur2"
    vcn_cidr          = "11.0.0.0/16"
    dns_label         = "hur2"
  }
}
```

This is just an example, but the number of the resources can be increased/decreased to suit any needs.
For example if you want to increase the number of subnets instances to 3 in the first VCN, you will have to modify the **subnet_params** variable in the terraform.tfvars file.

Don't forget to populate the provider with the details of your tenancy as specified in the main README.md file.

## Running the code

Go to **thunder/examples/crawl/network**
```
# Run init to get terraform modules
$ terraform init

# Create the infrastructure
$ terraform apply --var-file=path_to_provider.auto.tfvars

# If you are done with this infrastructure, take it down
$ terraform destroy --var-file=path_to_provider.auto.tfvars
```

## Useful Links
[Network Overview](https://docs.cloud.oracle.com/iaas/Content/Network/Concepts/overview.htm)
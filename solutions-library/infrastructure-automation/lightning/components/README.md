# Lightning CAF Topology and Component Descriptions

This is a Terraform configuration that deploys the Lightning CAF on [Oracle Cloud Infrastructure (OCI)][oci].

Lightning is built to showcase the features of [Oracle Cloud Infrastructure (OCI)][oci].
This **Always Free** example is designed to run using only the Always Free tier resources. 
The repository contains the [Resource Manager][orm] stack, 
that creates all the required resources and configures the application on the created resources.

## Topology

![Lightning Free Topology](../images/lightning-free-topology.png)


### Components

| Component             | What                                                                                                           | Why                                                                                                                                                                                                                                    | Learn                 |
| --------------------- | -------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------- |
| Compute Instances     | 1 Always Free tier eligible compute instance                                                              | These VMs host the application                                                                                                                                                                                                         | [Learn More][inst]    |
| Autonomous Database   | 1 Always Free tier eligible Autonomous Database instance                                                       | The database used by the application                                                                                                                                                                                                   | [Learn More][adb]     |
| Load Balancer         | 1 Always Free tier eligible load balancer                                                                      | Routes traffic between the nodes hosting the application                                                                                                                                                                               | [Learn More][lb]      |
| Virtual Cloud Network | This resource provides a virtual network in the cloud                                                          | The virtual network used by the application to host all its networking components                                                                                                                                                      | [Learn More][vcn]     |
| Private Subnet        | A subnet within the network that does not allow the network components to have publicly reachable IP addresses | The private subnet is used to house the compute instances. Being private, they ensure that the application nodes are not exposed to the internet                                                                                       | [Learn More][vcn]     |
| Public Subnet         | A subnet that allows public IPs.                                                                               | The subnet that houses the public load balancer. Components in this subnet can be allocated public IP addresses and be exposed to the internet through the InternetGateway.                                                            | [Learn More][vcn]     |
| Internet Gateway      | A virtual router that allows direct internet access.                                                           | This enables the load balancer to be reachable from the internet.                                                                                                                                                                      | [Learn More][igw]     |
| NAT Gateway           | A virtual router that allows internet access without exposing the source directly to the internet              | It gives the compute instances (with no public IP addresses) access to the internet without exposing them to incoming internet connections.                                                                                            | [Learn More][natgw]   |
| Service Gateway       | A virtual router that enables private traffic to OCI services from a VCN                                       | Provides a path for private network traffic between your VCN and services like Object Storage or ATP.                                                                                                                                  | [Learn More][svcgw]   |
| Route Tables          | Route tables route traffic that leaves the VCN.                                                                | The public subnet route rules direct traffic to use the Internet Gateway, while the private subnet route rules enable the compute instances to reach the internet through the NAT gateway and OCI services through the service gateway | [Learn More][rt]      |
| Security Lists        | Security Lists act like a firewall with the rules determining what type of traffic is allowed in or out.       | Security rules enable HTTP traffic to the LoadBalancer from anywhere. Also enables are HTTP and SSH traffic to the compute instances, but only from the subnet where the load balancer is.                                             | [Learn More][seclist] |


[oci]: https://cloud.oracle.com/en_US/cloud-infrastructure
[orm]: https://docs.cloud.oracle.com/iaas/Content/ResourceManager/Concepts/resourcemanager.htm
[tf]: https://www.terraform.io
[net]: https://docs.cloud.oracle.com/iaas/Content/Network/Concepts/overview.htm
[vcn]: https://docs.cloud.oracle.com/iaas/Content/Network/Tasks/managingVCNs.htm
[lb]: https://docs.cloud.oracle.com/iaas/Content/Balance/Concepts/balanceoverview.htm
[igw]: https://docs.cloud.oracle.com/iaas/Content/Network/Tasks/managingIGs.htm
[natgw]: https://docs.cloud.oracle.com/iaas/Content/Network/Tasks/NATgateway.htm
[svcgw]: https://docs.cloud.oracle.com/iaas/Content/Network/Tasks/servicegateway.htm
[rt]: https://docs.cloud.oracle.com/iaas/Content/Network/Tasks/managingroutetables.htm
[seclist]: https://docs.cloud.oracle.com/iaas/Content/Network/Concepts/securitylists.htm
[adb]: https://docs.cloud.oracle.com/iaas/Content/Database/Concepts/adboverview.htm
[inst]: https://docs.cloud.oracle.com/iaas/Content/Compute/Concepts/computeoverview.htm

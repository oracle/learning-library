# Introduction

Get hands-on learning with training labs about Oracle cloud solutions. The workshops featured cover various solutions, skill levels, and categories based on Oracle Cloud Infrastructure (OCI).

Estimated time: 60 minutes

## Oracle NAT Gateway

Many Oracle Cloud Infrastructure customers have compute instances in virtual cloud networks (VCNs) that, for privacy, security, or operational concerns, are connected to private subnets. To grant these resources access to the public internet for software updates, CRL checks, and so on, a customer’s only option has been to create a NAT instance in a public subnet and route traffic through that instance by using its private IP address as a route target from within the private subnet. Although many have successfully used this approach, it does not scale easily and provides a myriad of administrative and operational challenges.

NAT gateway, addresses these challenges and provides Oracle Cloud Infrastructure customers with a simple and intuitive tool to address their networking security needs. NAT gateways provide the following features:

* Highly Scalable and Fully Managed: Instances on private subnets can initiate large numbers of connections to the public internet. Connections initiated from the internet are blocked.

* Secure: Traffic through NAT gateways can be disabled with the Click of a button. Dedicated IP Addresses: Each NAT gateway is assigned a dedicated IP address that can be reliably added to security whitelists.


## Additional Recommended Resources

1. [OCI Training](https://cloud.oracle.com/en_US/iaas/training)
2. [Familiarity with OCI console](https://docs.us-phoenix-1.oraclecloud.com/Content/GSG/Concepts/console.htm)
3. [Overview of Networking](https://docs.us-phoenix-1.oraclecloud.com/Content/Network/Concepts/overview.htm)
4. [Familiarity with Compartments](https://docs.us-phoenix-1.oraclecloud.com/Content/GSG/Concepts/concepts.htm)

*Please proceed to the next lab*

## Acknowledgements

- **Author** - Kay Malcolm, Director, Product Management
- **Adapted by** -  Yaisah Granillo, Cloud Solution Engineer, NA Cloud
- **Contributors** - LiveLabs QA Team (Arabella Yao, Product Manager Intern | Isa Kessinger, QA Intern)
- **Last Updated By/Date** - Tom McGinn, August 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like us to follow up with you, enter your email in the *Feedback Comments* section.

# Introduction

Get hands-on learning with training labs about Oracle cloud solutions. The workshops featured cover various solutions, skill levels, and categories based on Oracle Cloud Infrastructure (OCI).

Estimated time: 60 minutes

## Private DNS

Many Oracle Cloud Infrastructure customers want to control how the internal DNS is configured without the need to install or configure a dedicated server for that. OCI Private DNS is a plataform service that offers Private DNS Zones, Views, and Resolvers.

Private DNS zones contain domain names that resolve DNS queries for private IP addresses within a VCN. A private DNS zone has similar capabilities to an internet DNS zone, but provides responses only for clients that can reach it through a VCN. You can create private zones to define your own domain name for private address resolution. You can also create multiple subdomains including a subdomain per region. For example, a subdomain can be created for US West (Phoenix), US East (Ashburn), UK South (London), and so on. Private DNS provides the ability to duplicate zones across multiple VCNs. A full or partial domain tree can be created. It provides support for Split Horizon (for example, private and public endpoints on the same zone).

A private DNS view is a collection of private zones. You can add private views to a resolver to manage how DNS queries are answered. A zone can only belong to a single view. The same zone name can be used in multiple views, but the zones will have unique OCIDs to differentiate. You can use those views to create DNS resolvers configured to handle DNS queries from your VCNs. Any given view may be used by an arbitrary number of resolvers, allowing you to share private DNS data across (presumably peered) VCNs.

A private resolver provides responses by checking zones in your custom private views, then in its default view, then by checking rules, and finally by using internet DNS. Rules allow you to define the logic for how queries should be answered. The resolver listens on the VCN Link Local address and the Subnet's virtual router address by default, but also allows you to define Listening and Forwarding VNICs. Multiple views can be resolved within a VCN. You can specify an ordered list of views within a resolver.


## Additional Recommended Resources

1. [OCI Training](https://cloud.oracle.com/en_US/iaas/training)
2. [Familiarity with OCI console](https://docs.cloud.oracle.com/iaas/Content/GSG/Concepts/console.htm)
3. [Overview of Networking](https://docs.cloud.oracle.com/iaas/Content/Network/Concepts/overview.htm)
4. [Familiarity with Compartments](https://docs.cloud.oracle.com/iaas/Content/GSG/Concepts/concepts.htm)
5. [DNS in Your Virtual Cloud Network](https://docs.cloud.oracle.com/iaas/Content/Network/Concepts/dns.htm)

*Please proceed to the next lab*

## Acknowledgements

- **Author** - Orlando Gentil
- **Contributors** - 
- **Last Updated By/Date** - 


## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/oci-networking). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
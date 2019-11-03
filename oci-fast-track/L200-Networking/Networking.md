
## Lab 2. Networking
Virtual Cloud Network and It’s Resources
** Objectives **
- Create Oracle Cloud Network (VCN)
- Configure 3 subnets on 3 Ads
- Provision an Internet Gateway, which will allow your VCN access to public internet
- Cofigure Route Table

## Create Oracle Cloud Network (VCN)
To create a network, remember to choose your compartment, then hit:  Networking>>Virtual Cloud Networks, on main menu.

**Don't forget to choose your compartment**

![](images/choose_compart.png)

**Create your VCN**
![](images/create_vcn.png)

**Create in Compartment**: Compartimento-Trial
**Name**: VCN-Trial
- CREATE VIRTUAL CLOUD NETWORK PLUS RELATED REOURCES

![](images/create_vcn_02.png)

OCI Console provides the option optimize the networking infrastructure creation process. By choosing the option “Create Virtual Cloud Network Plus Related Resources”, OCI will create the entire stack of network layer for you. OCI will create a  10.0.0/16 CIDR Block, the necessary Subnets (AD Local), along with Route Tables, the Internet Gateway, and some Firewall rules.

![](images/vcn_option.png)

**Important:** Remember to choose the option "CREATE VIRTUAL CLOUD NETWORK PLUS RELATED REOURCES"

Right below, you will have a resume of the options that will be used on the VCN creation process:

![](images/vcn_Resume.png)
![](images/vcn_Resume_02.png)

The networking creation process is very quick, when finished, will be shown as below:

![](images/vcn_creation.png)

##Subnets inside a VCN
A VCN is a software-defined network that you set up in the Oracle Cloud Infrastructure data centers in a particular . A subnet is a subdivision of a VCN. For an overview of VCNs, allowed size, default VCN components, and scenarios for using a VCN, see Overview of Networking.

Each subnet in a VCN consists of a contiguous range of IP addresses that do not overlap with other subnets in the VCN. Example: 172.16.1.0/24. The first two IP addresses and the last in the subnet's CIDR are reserved by the Networking service. You can't change the size of the subnet after creation, so it's important to think about the size of subnets you need before creating them. 

VCN is a cross-AD object. Inside it, we can create objects that will be positioned in any AD, inside the same region.

##Internet Gateway 
You can think of an internet gateway as a router connecting the edge of the cloud network with the internet. Traffic that originates in your VCN and is destined for a public IP address outside the VCN goes through the internet gateway. 

Route Configuration for the Internet Gateway
Every VCN need it’s route table, that will direct Public IP’s traffic. 

After all the resources are created, your OCI tenant will have a structure that will look like this:

![](images/tenant.png)
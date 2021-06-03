# Create your Virtual Cloud Network

Create the Virtual Cloud Network on the primary region and the secondary region.  Although they are in different regions, the VCNs must both be in the same compartment. And they must not have overlapping VCN IP address blocks.

Estimated lab time:  5 minutes

### Objective
- Create the VCN using the wizard

### Prerequisite
- Oracle Cloud Account
- User policy to create the VCN

## STEPS
1. Sign in to Oracle Cloud

2. Create a Virtual Cloud Network.  You will provision the Oracle Database Cloud Service on this network.

3. Go to the Networking menu and select Virtual Cloud Network

4. Select your region and compartment

![select-compartment](./images/select-compartment.png)

5. Click Start VCN Wizard

![image-20210121173942686](./images/image-20210121173942686.png)


6. Select VCN with Internet Connectivity to create your cloud network.

7. Click Start VCN Wizard.  

![image-20210121180617626](./images/image-20210121180617626.png)



8. Give your VCN a name of your choice.

9. Enter a CIDR block.  The CIDR block must not be the same as your cross region CIDR block because we will need to peer them together later so they must be different.  

ie: 10.0.0.0/16 for one region and 11.0.0.0/16 for the peer region.

10. Update your subnet CIDR block accordingly.

![image-20210121181204561](./images/image-20210121181204561.png)

11. Click Next and then Click Create.  Your cloud network will be created quickly.

12. Now do the same steps and create another VCN on your peer region.  Switch to your peer region and create your VCN with the wizard.  Remember it must be in the same compartment but with a different CIDR block.

You may now proceed to the next lab.

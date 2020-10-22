# Virtual Cloud Network

## Table of Contents

[Overview](#overview)

[Prerequisites](#Prerequisites)

[Create Your VCN](#create-your-vcn)

[Summary](#summary)

**Note:** *Some of the UIs might look a little different than the screen shots included in the instructions, but you can still use the instructions to complete the hands-on labs.*

## Overview

Oracle Cloud Infrastructure Compute lets you create multiple Virtual Cloud Networks (VCNs). These VCNs will contain the security lists, compute instances, load balancers and many other types of network assets.

Be sure to review [Overview of Networking](https://docs.cloud.oracle.com/iaas/Content/Network/Concepts/overview.htm) to gain a full understanding of the network components and their relationships.

## Prerequisites

To sign in to the Console, you need the following:

- Tenant, User name and Password
- URL for the Console: [https://console.us-ashburn-1.oraclecloud.com/](https://console.us-ashburn-1.oraclecloud.com/)
- Oracle Cloud Infrastructure supports the latest versions of Google Chrome, Firefox and Internet Explorer 11. ***It does not support the Edge browser***.

## Create Your VCN

To create a VCN on Oracle Cloud Infrastructure:

1. On the Oracle Cloud Infrastructure Console Home page, under the Quick Actions header, click on Set up a network with a wizard.

    ![Setup a Network with a Wizard](images/setupVCN1.png)

2. Select **VCN with Internet Connectivity**, and then click **Start Workflow**.

    ![Start Workflow](images/setupVCN2.png)

3. Complete the following fields:

    |                  **Field**              |    **Vaue**  |
    |----------------------------------------|:------------:|
    |VCN NAME |OCI_HOL_VCN|
    |COMPARTMENT |  Choose the ***Demo*** compartment you created in the [Identity Lab](../Identity_Access_Management/IAM_HOL.md)
    |VCN CIDR BLOCK|10.0.0.0/16|
    |PUBLIC SUNBET CIDR BLOCK|10.0.2.0/24|
    |PRIVATE SUBNET CIDR BLOCK|10.0.1.0/24
    |USE DNS HOSTNAMES IN THIS VCN| Checked|

    Your screen should look similar to the following:

    ![Create a VCN Configuration|Foobar](images/setupVCN3.png)

4. Press the **Next** button at the bottom of the screen.

5. Review your settings to be sure they are correct.
    ![Review CV Configuration](images/setupVCN4.png)

6. Press the **Create** button to create the VCN. I will take a moment to create the VCN and a progress screen will keep you apprised of the workflow.

    ![Workflow](images/workflow.png)

7. Once you see that the creation is complete (see previous screenshot), click on the **View Virtual Cloud Network** button.

## Summary

This VCN will contain all of the other assets that you will create during this set of labs. In real-world situations, you would crete multiple VCNs based on their need for access (which ports to open) and who can access them. Both of these concepts are covered in the next lab [Compute](../Compute_Services/Compute_HOL.md)

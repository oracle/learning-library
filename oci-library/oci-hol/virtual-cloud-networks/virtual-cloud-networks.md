# Virtual Cloud Networks

## Introduction

Oracle Cloud Infrastructure Compute lets you create multiple Virtual Cloud Networks (VCNs). These VCNs will contain the security lists, compute instances, load balancers and many other types of network assets.

Be sure to review [Overview of Networking](https://docs.cloud.oracle.com/iaas/Content/Network/Concepts/overview.htm) to gain a full understanding of the network components and their relationships, or take a look at this video:

[](youtube:mIYSgeX5FkM)

### Prerequisites

To sign in to the Console, you need the following:

- Tenant, User name and Password
- URL for the Console: [https://console.us-ashburn-1.oraclecloud.com/](https://console.us-ashburn-1.oraclecloud.com/)
- Oracle Cloud Infrastructure supports the latest versions of Google Chrome, Firefox and Internet Explorer 11. ***It does not support the Edge browser***.

## **STEP 1**: Create Your VCN

To create a VCN on Oracle Cloud Infrastructure:

1. On the Oracle Cloud Infrastructure Console Home page, under the Quick Actions header, click on Set up a network with a wizard.

    ![Setup a Network with a Wizard](images/setupVCN1.png " ")

2. Select **VCN with Internet Connectivity**, and then click **Start VCN Wizard**.

    ![Start Workflow](images/setupVCN2.png " ")

3. Complete the following fields:

    |                  **Field**              |    **Vaue**  |
    |----------------------------------------|:------------:|
    |VCN NAME |OCI\_HOL\_VCN|
    |COMPARTMENT |  Choose the ***Demo*** compartment you created in the ***Identity and Access Management Lab***
    |VCN CIDR BLOCK|10.0.0.0/16|
    |PUBLIC SUNBET CIDR BLOCK|10.0.2.0/24|
    |PRIVATE SUBNET CIDR BLOCK|10.0.1.0/24
    |USE DNS HOSTNAMES IN THIS VCN| Checked|

    Your screen should look similar to the following:

    ![Create a VCN Configuration|Foobar](images/setupVCN3.png " ")

4. Press the **Next** button at the bottom of the screen.

5. Review your settings to be sure they are correct.
    ![Review CV Configuration](images/setupVCN4.png " ")

6. Press the **Create** button to create the VCN. It will take a moment to create the VCN and a progress screen will keep you apprised of the workflow.

    ![Workflow](images/workflow.png " ")

7. Once you see that the creation is complete (see previous screenshot), click on the **View Virtual Cloud Network** button.

### Summary

This VCN will contain all of the other assets that you will create during this set of labs. In real-world situations, you would create multiple VCNs based on their need for access (which ports to open) and who can access them. Both of these concepts are covered in the next lab ***Create a Compute Service***.

## Acknowledgements

- **Author** - Flavio Pereira, Larry Beausoleil
- **Adapted by** -  Tom McGinn, Database Product Management
- **Contributors** - Oracle LiveLabs QA Team (Kamryn Vinson, QA Intern, Arabella Yao, Product Manager Intern, DB Product Management)
- **Last Updated By/Date** - Tom McGinn, July 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.

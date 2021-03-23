# Create an Oracle Cloud Virtual Cloud Network
## Introduction

This lab walks you through the steps to create an instance of an Oracle Virtual Cloud Network (VCN). A virtual cloud network (VCN) provides the necessary network Infrastructure required to support resources, including Oracle Database instances. This includes a gateway, route tables, security lists, DNS and so on. Fortunately, Oracle Cloud Infrastructure provides a wizard that simplifies the creation of a basic, public internet accessible VCN.

### Prerequisites

* An Oracle Cloud paid account or free trial. To sign up for a trial account with $300 in credits for 30 days, click [here](http://oracle.com/cloud/free).

## **STEP**: Create a Virtual Cloud Network Instance

1. From the Console menu, select **Networking > Virtual Cloud Networks**.

  ![](images/virtual-cloud-networks.png " ")

2. Select your compartment and click on **Start VCN Wizard**. If you haven't created any compartments yet, just leave it as the default (root) compartment.

  ![](images/start-vcn-wiz.png " ")

3. Be sure the default "VCN with Internet Connectivity" is selected and click **Start VCN Wizard**.

  ![](images/start-wizard.png " ")

4. Enter a name for your VCN, and enter the default values for the VCN CIDR block(10.0.0.0/16), Public Subnet CIDR block (10.0.0.0/24) and Private CIDR block (10.0.1.0/24), and click **Next**.

  ![](images/vcn-config.png " ")

5. Review your selections on the next screen and click **Create**.

  ![](images/created-vcn.png " ")

6. On the summary screen, click **View Virtual Cloud Network**.
  ![](images/view-vcn.png " ")

  You can proceed to the next lab.

## Learn More

* [Oracle Cloud Infrastructure: Network Setup for DB Systems](https://docs.cloud.oracle.com/en-us/iaas/Content/Database/Tasks/network.htm)

## Acknowledgements
* **Author** -Tom McGinn, Learning Architect, Database User Assistance
* **Contributors** - Kamryn Vinson, Database Product Management
* **Last Updated By/Date** - Kamryn Vinson, November 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one. 

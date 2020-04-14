# Add an Ingress Rule to Open a Port
## Before You Begin
This lab walks you through the steps to open an port to your Oracle Cloud network to allow access to on Oracle Database instance running on an Oracle Cloud Compute, Bare Metal or Virtual Machine instance. For example, by opening port 1521, you will allow Oracle Database clients and external applications to access your Oracle Database.

### Background
Oracle Cloud Infrastructure provides a quick and easy to create an Oracle Database 19c instance running in a Virtual Machine.

### What Do You Need?

* An Oracle Cloud paid account or free trial. To sign up for a trial account with $300 in credits for 30 days, click [here](http://oracle.com/cloud/free).
* An Oracle Virtual Cloud Network (VCN) instance

## **STEP 1**: Add an Ingress Rule to your Virtual Cloud Network instance

1. After logging into your Oracle Cloud account, click on **Networking -> Virtual Cloud Networks** from the menu.

  ![](images/open-vcn-instances.png " ")

2. Click on your VCN from the list of instances. If your instance is not shown, be sure you have the correct compartment selected.

  ![](images/select-vcn.png " ")

3. On the left menu, click **Security Lists**.

  ![](images/security-lists.png " ")

4. Click the link for the **Default Security List**.

  ![](images/default-security-list.png " ")

5. Click **Add Ingress Rule**.

  ![](images/add-ingress-rule-1.png " ")

6. In the Add Ingress Rules dialog, enter `0.0.0.0/0`. Enter `1521` as the port number (of the database), and click **Add Ingress Rules**.

  ![](images/add-ingress-rule-2.png " ")

  Note that 0.0.0.0/0 allows access to all IP traffic to your database. Alternatively, you can open access to a single IP address by entering the IP address followed by `/32`.

7. You can remove or edit the Ingress rule by clicking the checkbox for the rule and the clicking the **Edit** or **Remove** buttons.

  ![](images/remove-ingress-rule.png " ")

  You can proceed to the next lab.

## Want to Learn More?

* [Oracle Cloud Infrastructure: Connecting to an DB System](https://docs.cloud.oracle.com/en-us/iaas/Content/Database/Tasks/connectingDB.htm)

## Acknowledgements
* **Author** -Tom McGinn, Learning Architect, Database User Assistance
* **Last Updated By/Date** - Tom McGinn, March 2020

See an issue?  Please open up a request [here](https://github.com/oracle/learning-library/issues).

# Send the Trail File from Oracle GoldenGate to OCI GoldenGate

## Introduction

This lab walks you through the steps to create and run a Distribution Path on Oracle GoldenGate.

Estimated Lab Time: 10 minutes

### About Distribution Paths
A Receiver Path is a source-to-destination configuration that uses the Receiver Server.

### Objectives

In this lab, you will create and run a path on the Oracle GoldenGate Receiver Server to pull a Trail file from OCI GoldenGate.

## **STEP 1**: Create and Run a Receiver Path

1. Open the Oracle GoldenGate Receiver Server in your web browser.

2. Click **Add Path**.

3. On the Add Path page, for **Path Name**, enter a name for this Path. For example, **GGStoOGG**.

4. For **Description**, describe the purpose of this Path.

5. Enable **Reverse Proxy enabled?**.

6. Enable **Use Basic Authentication**.

7. For **Source Host**, enter the OCI GoldenGate hostname in the following format: **\<domain\>.deployment.goldengate.us-\<region\>-1.oci.oraclecloud.com:443**. You can copy the host from the browser address bar of your OCI GoldenGate Deployment Console window.

8. For **Source Trail Name**, enter the name of the OCI GoldenGate Trail file you're sending to Oracle GoldenGate.

9. For **Source Deployment Name**, enter the your OCI GoldenGate Deployment name.

10. For **Source Domain**, enter the domain name you created on Oracle GoldenGate. For example, **GGSNetwork**.

11. For **Source Alias**, enter the alias name you created on Oracle GoldenGate.

12. For **Target**, enter a two character name for the Trail file when it is received by Oracle GoldenGate.

13. Click **Create Path**.

14. Return to the Receiver Server Overview page, and then select **Start** from the Path's **Action** menu.

In this lab, you created and ran a Path on your on premise Oracle GoldenGate Receiver Server and pulled a Trail file from OCI GoldenGate to Oracle GoldenGate.

## Learn More

* [Create a Receiver Path](https://docs.oracle.com/en/cloud/paas/goldengate-service/using/goldengate-deployment-console.html#GUID-F2366D03-55DE-4C90-91FA-7D66491BE1AE)


## Acknowledgements
* **Author** - Jenny Chan, Consulting User Assistance Developer, Database User Assistance
* **Contributors** -  Werner He, Database Product Management
* **Last Updated By/Date** - March 2021

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.

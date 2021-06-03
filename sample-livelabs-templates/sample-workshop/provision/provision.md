# Provision an Instance

## Introduction

*Describe the lab in one or two sentences, for example:* This lab walks you through the steps to ...

Estimated Lab Time: n minutes

### About Product/Technology
Enter background information here..

### Objectives

*List objectives for the lab - if this is the intro lab, list objectives for the workshop*

In this lab, you will:
* Objective 1
* Objective 2
* Objective 3

To link to other areas in document use this [syntax](#STEP1:title)

### Prerequisites

* An Oracle Cloud Account - Please view this workshop's LiveLabs landing page to see which environments are supported
* Item no 2 with url - [URL Text](https://www.oracle.com).

*Note: If you have a **Free Trial** account, when your Free Trial expires your account will be converted to an **Always Free** account. You will not be able to conduct Free Tier workshops unless the Always Free environment is available. **[Click here for the Free Tier FAQ page.](https://www.oracle.com/cloud/free/faq.html)***

*This is the "fold" - below items are collapsed by default*

## **STEP 0**: Use these Standardized Pictures for Oracle Cloud Navigation (Commonly for Provisioning)

***Please use the absolute path pictures in this section when describing Oracle Cloud navigation in your workshops. This will enable us to quickly update all workshops in the future if there happens to be an Oracle Cloud user interface change.  It also increases consistency across LiveLabs workshops and contributes to a more professional feel.  Browse below and view the markdown in an editor to find the related images. We highly recommend you copy this whole section in the markdown file and paste it to a text document for easy copy and pasting of links.***

Cloud Navigation Picture Paths:

Administration - Tenancy Details

1. Click the **Navigation Menu** in the upper left, navigate to **Governance & Administration**, and select **Tenancy Details**.

	![](https://raw.githubusercontent.com/oracle/learning-library/master/common/images/console/admin-details.png " ")

Analytics - Cloud - OAC
1. Click the **Navigation Menu** in the upper left, navigate to **Analytics & AI**, and select **Analytics Cloud**.

	![](https://raw.githubusercontent.com/oracle/learning-library/master/common/images/console/analytics-oac.png " ")

Analytics - Big Data
1. Click the **Navigation Menu** in the upper left, navigate to **Analytics & AI**, and select **Big Data**.

	![](https://raw.githubusercontent.com/oracle/learning-library/master/common/images/console/bigdata.png " ")

Analytics - Digital Assistant
1. Click the **Navigation Menu** in the upper left, navigate to **Analytics & AI**, and select **Digital Assistant**.

	![](https://raw.githubusercontent.com/oracle/learning-library/master/common/images/console/analytics-assist.png " ")

Analytics - Machine Learning - Data Science
1. Click the **Navigation Menu** in the upper left, navigate to **Analytics & AI**, and select **Data Science**.

	![](https://raw.githubusercontent.com/oracle/learning-library/master/common/images/console/analytics-ml-datascience.png " ")

Compute - Instances
1. Click the **Navigation Menu** in the upper left, navigate to **Compute**, and select **Instances**.

	![](https://raw.githubusercontent.com/oracle/learning-library/master/common/images/console/compute-instances.png " ")

Database - Autonomous Data Warehouse - ADW
1. Click the **Navigation Menu** in the upper left, navigate to **Oracle Database**, and select **Autonomous Data Warehouse**.

	![](https://raw.githubusercontent.com/oracle/learning-library/master/common/images/console/database-adw.png " ")

Database - Autonomous JSON Database - AJD
1. Click the **Navigation Menu** in the upper left, navigate to **Oracle Database**, and select **Autonomous JSON Database**.

	![](https://raw.githubusercontent.com/oracle/learning-library/master/common/images/console/database-ajd.png " ")

Database - Autonomous Transaction Processing - ATP
1. Click the **Navigation Menu** in the upper left, navigate to **Oracle Database**, and select **Autonomous Transaction Processing**.

	![](https://raw.githubusercontent.com/oracle/learning-library/master/common/images/console/database-atp.png " ")

Oracle Database - Data Safe
1. Click the **Navigation Menu** in the upper left, navigate to **Oracle Database**, and select **Data Safe**.

	![](https://raw.githubusercontent.com/oracle/learning-library/master/common/images/console/database-datasafe.png " ")

Oracle Database - Cloud Shell - Bare Metal, VM, Exadata - DBCS
1. Click the **Navigation Menu** in the upper left, navigate to **Oracle Database**, and select **Bare Metal, VM, and Exadata**.

	![](https://raw.githubusercontent.com/oracle/learning-library/master/common/images/console/database-dbcs.png " ")

Oracle Database - GoldenGate - Golden Gate - GG
1. Click the **Navigation Menu** in the upper left, navigate to **Oracle Database**, and select **GoldenGate**.

	![](https://raw.githubusercontent.com/oracle/learning-library/master/common/images/console/database-goldengate.png " ")

DB Systems - DB sys
1. Click the **Navigation Menu** in the upper left, navigate to **Databases**, and select **DB Systems**.

	![](https://raw.githubusercontent.com/oracle/learning-library/master/common/images/console/database-dbsys.png " ")

Developer Services - Resource Manager Stacks - ResMgr Stacks
1. Click the **Navigation Menu** in the upper left, navigate to **Developer Services**, and select **Stacks**.

	![](https://raw.githubusercontent.com/oracle/learning-library/master/common/images/console/developer-resmgr-stacks.png " ")

Developer Services - APEX
1. Click the **Navigation Menu** in the upper left, navigate to **Developer Services**, and select **APEX**.

	![](https://raw.githubusercontent.com/oracle/learning-library/master/common/images/console/developer-apex.png " ")

Developer Services - Containers - Kubernetes Clusters (OKE)
1. Click the **Navigation Menu** in the upper left, navigate to **Developer Services**, and select **Kubernetes Clusters (OKE)**.

	![](https://raw.githubusercontent.com/oracle/learning-library/master/common/images/console/developer-OKE.png " ")

Developer Services - Containers - Container Registry
1. Click the **Navigation Menu** in the upper left, navigate to **Developer Services**, and select **Container Registry**.

	![](https://raw.githubusercontent.com/oracle/learning-library/master/common/images/console/developer-container-registry.png " ")

Developer Services - APEX
1. Click the **Navigation Menu** in the upper left, navigate to **Developer Services**, and select **APEX**.

	![](https://raw.githubusercontent.com/oracle/learning-library/master/common/images/console/developer-apex.png " ")

Developer Services - Functions - Applications
1. Click the **Navigation Menu** in the upper left, navigate to **Developer Services**, and select **Applications**.

	![](https://raw.githubusercontent.com/oracle/learning-library/master/common/images/console/developer-functions-applications.png " ")

Developer Services - Application Integration - Integration
1. Click the **Navigation Menu** in the upper left, navigate to **Developer Services**, and select **Notifications**.

	![](https://raw.githubusercontent.com/oracle/learning-library/master/common/images/console/developer-application-integration.png " ")

Developer Services - Application Integration - Notifications
1. Click the **Navigation Menu** in the upper left, navigate to **Developer Services**, and select **Notifications**.

	![](https://raw.githubusercontent.com/oracle/learning-library/master/common/images/console/developer-application-notification.png " ")

Developer Services - Application Integration - Email Delivery
1. Click the **Navigation Menu** in the upper left, navigate to **Developer Services**, and select **Email Delivery**.

	![](https://raw.githubusercontent.com/oracle/learning-library/master/common/images/console/developer-application-emaildelivery.png " ")

Networking - Virtual Cloud Networks - VCN
1. Click the **Navigation Menu** in the upper left, navigate to **Networking**, and select **Virtual Cloud Networks**.

	![](https://raw.githubusercontent.com/oracle/learning-library/master/common/images/console/networking-vcn.png " ")

Networking - Load Balancer
1. Click the **Navigation Menu** in the upper left, navigate to **Networking**, and select **Load Balancer**.

	![](https://raw.githubusercontent.com/oracle/learning-library/master/common/images/console/networking-loadbalance.png " ")

Storage - Buckets
1. Click the **Navigation Menu** in the upper left, navigate to **Storage**, and select **Buckets**.

	![](https://raw.githubusercontent.com/oracle/learning-library/master/common/images/console/storage-buckets.png " ")

ExadataC@C
1. Click the **Navigation Menu** in the upper left, navigate to **Hybrid**, and select **Exadata Cloud@Customer**.

	![](https://raw.githubusercontent.com/oracle/learning-library/master/common/images/console/hybrid-exadata.png " ")

Marketplace
1. Click the **Navigation Menu** in the upper left and select **Marketplace**.

	![](https://raw.githubusercontent.com/oracle/learning-library/master/common/images/console/marketplace.png " ")

Compartment
1. Click the **Navigation Menu** in the upper left, navigate to **Identity & Security** and select **Compartments**.

	![](https://raw.githubusercontent.com/oracle/learning-library/master/common/images/console/id-compartment.png " ")

Federation
1. Click the **Navigation Menu** in the upper left, navigate to **Identity & Security** and select **Federation**.

	![](https://raw.githubusercontent.com/oracle/learning-library/master/common/images/console/id-federation.png " ")

Policies
1. Click the **Navigation Menu** in the upper left, navigate to **Identity & Security** and select **Policies**.

	![](https://raw.githubusercontent.com/oracle/learning-library/master/common/images/console/id-policies.png " ")

Identity & Security - Audit
1. Click the **Navigation Menu** in the upper left, navigate to **Identity & Security** and select **Policies**.

	![](https://raw.githubusercontent.com/oracle/learning-library/master/common/images/console/id-audit.png " ")


## **STEP 1**: title

Step 1 opening paragraph.

1. Sub step 1

  To create a link to local file you want the reader to download, use this format:

  Download the [starter file](files/starter-file.sql) SQL code.

  *Note: do not include zip files, CSV, PDF, PSD, JAR, WAR, EAR, bin or exe files - you must have those objects stored somewhere else. We highly recommend using Oracle Cloud Object Store and creating a PAR URL instead. See [Using Pre-Authenticated Requests](https://docs.cloud.oracle.com/en-us/iaas/Content/Object/Tasks/usingpreauthenticatedrequests.htm)*

2. Sub step 2 with image and link to the text description below. The `sample1.txt` file must be added to the `files` folder.

    ![Image alt text](images/sample1.png "Image title")

3. Ordered list item 3 with the same image but no link to the text description below.

    ![Image alt text](images/sample1.png)

4. Example with inline navigation icon ![Image alt text](images/sample2.png) click **Navigation**.

5. One example with bold **text**.

   If you add another paragraph, add 3 spaces before the line.

6. This is an example of manual control over image sizes:

  No image sizing applied: `![](images/pic2.png)`

  ![](images/pic2.png)

  50% of the width and use auto height: `![](images/pic2.png =50%x*)`

  ![](images/pic2.png =50%x*)

  absolute width and height (500 pixel by 200 pixels): `![](./images/pic2.png =500x200)`

  ![](./images/pic2.png =500x200)

  50% for both width and height:  `![](./images/pic2.png =50%x50%)`

  ![](./images/pic2.png =50%x50%)

## **STEP 2:** title

1. Sub step 1

  Use tables sparingly:

  | Column 1 | Column 2 | Column 3 |
  | --- | --- | --- |
  | 1 | Some text or a link | More text  |
  | 2 |Some text or a link | More text |
  | 3 | Some text or a link | More text |

2. You can also include bulleted lists - make sure to indent 4 spaces:

    - List item 1
    - List item 2

3. Code examples

    ```
    Adding code examples
  	Indentation is important for the code example to appear inside the step
    Multiple lines of code
  	<copy>Enclose the text you want to copy in <copy></copy>.</copy>
    ```

4. Code examples that include variables

	```
  <copy>ssh -i <ssh-key-file></copy>
  ```

*At the conclusion of the lab add this statement:*
You may now [proceed to the next lab](#next).

## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [URL text 1](http://docs.oracle.com)
* [URL text 2](http://docs.oracle.com)

## Acknowledgements
* **Author** - <Name, Title, Group>
* **Contributors** -  <Name, Group> -- optional
* **Last Updated By/Date** - <Name, Group, Month Year>
* **Workshop (or Lab) Expiry Date** - <Month Year> -- optional, use this when you are using a Pre-Authorized Request (PAR) URL to an object in Oracle Object Store.

# Deploy MuShop Application

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

### Prerequisites

*Use this section to describe any prerequisites, including Oracle Cloud accounts, set up requirements, etc.*

* An Oracle Free Tier, Always Free, Paid or LiveLabs Cloud Account
* Item no 2 with url - [URL Text](https://www.oracle.com).

*This is the "fold" - below items are collapsed by default*

## **STEP 1**: title

Step 1 opening paragraph.
 This is a Terraform configuration that deploys the MuShop basic sample application on Oracle Cloud Infrastructure and is designed to run using only the Always Free tier resources.

The repository contains the application code as well as the Terraform code to create a Resource Manager stack, that creates all the required resources and configures the application on the created resources. To simplify getting started, the Resource Manager Stack is created as part of each release

The steps below guide you through deploying the application on your tenancy using the OCI Resource Manager.

    Download the latest mushop-basic-stack-latest.zip file.
    Login to Oracle Cloud Infrastructure to import the stack

        Home > Solutions & Platform > Resource Manager > Stacks > Create Stack

    Upload the mushop-basic-stack-latest.zip file that was downloaded earlier, and provide a name and description for the stack
    Configure the stack
        Database Name - You can choose to provide a database name (optional)
        Node Count - Select if you want to deploy one or two application instances.
        SSH Public Key - (Optional) Provide a public SSH key if you wish to establish SSH access to the compute node(s).
    Review the information and click Create button.

        The upload can take a few seconds, after which you will be taken to the newly created stack

    On Stack details page, click on Terraform Actions > Apply

All the resources will be created, and the URL to the load balancer will be displayed as lb_public_url as in the example below.

    The same information is displayed on the Application Information tab

Outputs:
        
        autonomous_database_password = <generated>
        
        comments = The application URL will be unavailable for a few minutes after provisioning, while the application is configured
        
        dev = Made with ❤ by Oracle A-Team
        
        lb_public_url = http://xxx.xxx.xxx.xxx
        

    The application is being deployed to the compute instances asynchronously, and it may take a couple of minutes for the URL to serve the application.

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

## **STEP 2:** title

1. Sub step 1

  Use tables sparingly:

  | Column 1 | Column 2 | Column 3 |
  | --- | --- | --- |
  | 1 | Some text or a link | More text  |
  | 2 |Some text or a link | More text |
  | 3 | Some text or a link | More text |

2. You can also include bulleted lists - make sure to indent by at three spaces:

      - List item 1
      - List item 2

3. Code examples

    ```
    Adding code examples
	Indentation is important for the code example to appear inside the step
    Multiple lines of code
	<copy>Enclose the text you want to copy in <copy&gt;</copy&gt;.</copy>
    ```

4. Code examples that include variables

	```
  <copy>ssh -i <ssh-key-file&gt;</copy>
  ```

*At the conclusion of the lab add this statement:*
You may now *proceed to the next lab*.

## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [URL text 1](http://docs.oracle.com)
* [URL text 2](http://docs.oracle.com)

## Acknowledgements
* **Author** - <Name, Title, Group>
* **Contributors** -  <Name, Group> -- optional
* **Last Updated By/Date** - <Name, Group, Month Year>
* **Workshop (or Lab) Expiry Date** - <Month Year> -- optional, use this when you are using a Pre-Authorized Request (PAR) URL to an object in Oracle Object Store.

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.

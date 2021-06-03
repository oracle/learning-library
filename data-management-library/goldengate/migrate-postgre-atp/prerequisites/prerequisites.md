# Prerequisites 

## Introduction

In this step, we will show you how to prepare your work environment in Oracle Cloud Infrastructure. We will use cloud-shell which is a web-based terminal built into OCI console. To use the Cloud Shell machine, your tenancy administrator must grant your the required IAM (Identity and Access Management) policy.

*Estimated lab time*: 10 minutes

### Objectives

-   Create SSH keys in a cloud-shell environment
-   Configure API keys for your cloud user
-	Modify bash profile to interact with terraform 

For a technical overview of this lab step, please watch the following video:

[](youtube:g7FFyY9Kf2g)


### Prerequisites

* The following workshop requires an Oracle Public Cloud Account that will either be supplied by your instructor or can be obtained through **Getting Started** steps.
* A Cloud tenancy where you have the resources available to provision what is listed in the Architecture Overview.
* Oracle Cloud Infrastructure supports the following browsers and versions: Google Chrome 69 or later, Safari 12.1 or later, Firefox 62 or later.
* Your cloud account user must have the required IAM (Identity and Access Management) policy or admin user.
* Successfully logged in to your cloud tenancy, if not please [login](https://www.oracle.com/cloud/sign-in.html) to your cloud account.

## **Step 1**: Open Cloud-Shell

1. Let's prepare our work directory. We will use Cloud Shell, it is located at the top right corner of the OCI web console

	![](/images/0.Prep_0.PNG)

## **Step 2**: Generate SSH keys 

1. Once the cloud shell environment is ready, issue the below 4 lines of commands. This will create the ssh key files and the api signing keys:

	```
	<copy>
	ssh-keygen -t rsa -N "" -b 2048 -f ~/.ssh/oci
	openssl genrsa -out ~/.ssh/oci_api_key.pem 2048
	openssl rsa -pubout -in ~/.ssh/oci_api_key.pem -out ~/.ssh/oci_api_key_public.pem
	openssl rsa -pubout -outform DER -in ~/.ssh/oci_api_key.pem | openssl md5 -c | awk '{print $2}' > ~/.ssh/oci_api_key.fingerprint
	</copy>
	```

2. Copy your public _**pem**_ file content:

	```
	<copy>
	cat ~/.ssh/oci_api_key_public.pem
	</copy>
	```

	![](/images/0.Prep_1.PNG)

## **Step 3**: Add Public API keys

1. Click on the top right corner of your OCI web console and click on your **profile**. Then navigate to the **API Keys** from the left pane and click on the **Add API Key** button. A small pop-up will appear and you need to choose the "Paste Public Key" radio button. Paste your **copied public pem key** there and click on the **Add** button.

	![](/images/0.Prep_2.PNG)

2. A small confirmation will show after you added an API key. **Copy** these values and open a notepad to keep these for a later use.

	![](/images/0.Prep_3.PNG)

## **Step 4**: Modify Bash Profile (Optional)

1. This step is **not needed** if you are running this lab from OCI **cloud-shell**. But will require this when you run from your local machine. In your notepad, copy the below lines and add related values from previous step. For example: `export TF_VAR_user_ocid="ocid1.user.oc1..."`

	```
	<copy>
	export TF_VAR_compartment_ocid="your-tenancy-value-goes-here"
	export TF_VAR_fingerprint="your-fingerprint-value-goes-here"
	export TF_VAR_private_key_path="~/.ssh/oci_api_key.pem"
	export TF_VAR_region="your-region-value-goes-here"
	export TF_VAR_tenancy_ocid="your-tenancy-value-goes-here"
	export TF_VAR_user_ocid="your-user-value-goes-here"
	</copy>
	```
	_**NOTE:** if you are an experienced OCI user, I'd highly suggest you use your own compartment to isolate all resources. To do so, provide your compartment OCID in `TF_VAR_compartment_ocid`. If you are new to OCI cloud, just enter your Tenancy value as compartment OCID._

2. After you modified the above using your values, we now need to add these lines to your ".bash_profile". In the cloud-shell terminal issue below:

	```
	<copy>
	vi ~/.bash_profile
	</copy>
	```

	_**NOTE:** Editing a file uses **vi** editor, if you never used it before here is a tip. When you issue **`vi .bash_profile`** it will open a file. You have to press **i** key to enable editing, then "shift+insert" to paste from clipboard. When you are done editing press **esc** button and press **:wq** keys then hit enter for save & quit._

	![](/images/0.Prep_4.PNG)

3. Once you've set these values, **exit** from the cloud-shell terminal by clicking on exit "X" button on top right corner, then re-open the cloud-shell terminal to continue.

	![](/images/0.Prep_0.PNG)

Now your terminal knows your parameters and you'll not get any error in the next lab. **REMEMBER**, you must close the cloud-shell and re-open it!
You've now completed the prerequisites.

**This concludes this lab. You may now [proceed to the next lab](#next).**

## Acknowledgements

* **Author** - Bilegt Bat-Ochir - Senior Solution Engineer
* **Contributors** - John Craig - Technology Strategy Program Manager, Patrick Agreiter - Senior Cloud Engineer
* **Last Updated By/Date** - Bilegt Bat-Ochir 4/15/2021
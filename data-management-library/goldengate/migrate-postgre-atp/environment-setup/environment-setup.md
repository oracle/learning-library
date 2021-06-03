# Environment Setup

## Introduction

This first lab is very important and where we will create all of our resources:

- Virtual Cloud Network
- Source Postgreqsql database
- Target Autonomous database
- Goldengate for non-Oracle deployment
- Goldengate Microservices deployment

*Estimated lab time*: 10 minutes

### Objectives

In this first lab, we will prepare our work environment and create our lab resources using a Terraform script.
If you are running this lab in your existing tenancy, **make sure** you have the following compute quotas and resources available to use:

1. ATP for Target database - 1 OCPU, 1 TB storage
2. Virtual Machine for Source Database - VM.StandardE2.1
3. Virtual Machine for Goldengate Postgresql - VM.Standard2.1  
4. Virtual Machine for Goldengate Microservices - VM.Standard2.1

	![](/images/architecture.png)

For a technical overview of this lab step, please watch the following video:

[](youtube:LWcwzXPw9ZU)

### Prerequisites

* Successfully completed **Lab 0: Prerequisites** and ready to continue

## **Step 1**: Clone Lab Repository

1. Let's begin our lab. First, we'll make a copy of the lab repository and go to the cloned directory. In your cloud-shell web terminal, issue the below commands.

	```
	<copy>
	git clone https://github.com/hol-workshop/migrate_to_atp.git

	cd migrate_to_atp
	</copy>
	```

	![](/images/1.Git.PNG)

## **Step 2**: Create Terraform Variables

1. Now we need to create a file to help terraform understand your environment. Let's modify the following parameters in your notepad and copy them.

	```
	<copy>
	tenancy_ocid  = "your_tenancy_value_here"
	region = "your-region-value here"
	compartment_ocid = "your-tenancy-value_here"
	</copy>
	```

2. Enter the below command in your current working `migrate_to_atp` directory:

	```
	<copy>
	vi terraform.tfvars
	</copy>
	```

	_**NOTE:** This will create a new file, you have to press **i** key to enable editing, then "shift+insert" to paste copied parameter. When you are done editing press **esc** button and press **:wq** keys, then hit enter for save & quit.*_

3. Good practice is, always keep it in your side notepad.

## **Step 3**: Terraform 

1. It is time to initialize terraform. Run the below command to download necessary terraform files from the OCI provider.

	```
	<copy>
	chmod +x update.sh
	
	terraform init
	</copy>
	```

2. Plan and apply steps should not ask for any input from you. If it asks you to provide, for example; _**`compartment_ocid`**_ , then check previous steps.

	```
	<copy>
	terraform plan

	terraform apply --auto-approve
	</copy>
	```
	After you ran the apply command, terraform will start installation of several virtual machines and an autonomous database. Be patient, it will take some time. But, if you see an error **Service limits exceeded** in output, please visit the Appendix section for instructions to correct the issue.
	
3. Make a copy of your output results in your notepad for later use.

	![](/images/1.git_1.PNG)

**This concludes this lab. You may now [proceed to the next lab](#next).**

## **Appendix**: Troubleshooting

###	Issue #1 Service Limits Exceeded
	
If you see **Service Limits Exceeded** issues when running _**terraform apply**_ command, follow the steps below to resolve them.
When creating a stack, you must have the available quotas for your tenancy and your compartment. 

Depending on the quota limit you have in your tenancy you can choose from any VM Standard Compute shapes, AMD shapes or Flex Shapes. 

This lab uses the following compute types but not limited to:

- Virtual Machine for Source Database - **VM.StandardE2.1**
- Virtual Machine for Goldengate Postgresql - **VM.Standard2.1**
- Virtual Machine for Goldengate Microservices - **VM.Standard2.1**

#### Fix for Issue #1

1. Click on the Hamburger menu, go to **Governance** -> **Limits, Quotas and Usage**
2. Select Compute
3. Click Scope to change Availability Domain
4. Look for "Standard2 based VM" and "Standard.E2 based VM", then check **Available** column numbers and sum  them up. All you need to have is at least **3** or more. If you have found correct available capacity, please continue to the next step.
5. Go to `migrate_to_atp` folder in your cloud-shell and modify variables file with: **`vi vars.tf`**

	![](/images/fix_1.png)

6. Fix above accordingly to your **Available** resources.
7. Go to **Step 3: Terraform**, and continue from substep **2**.
	
However, if you are unable to resolve it using above fix, please skip to the **Need Help** section to submit your issue via our support forum.

## Acknowledgements

* **Author** - Bilegt Bat-Ochir - Senior Solution Engineer
* **Contributors** - John Craig - Technology Strategy Program Manager, Patrick Agreiter - Senior Cloud Engineer
* **Last Updated By/Date** - Bilegt Bat-Ochir 4/15/2021
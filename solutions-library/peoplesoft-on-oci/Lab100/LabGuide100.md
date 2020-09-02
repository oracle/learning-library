# Lab 100 : Preparing OCI tenancy 

## Introduction
This lab will guide you to create your own OCI environment and look for the resources required

## Part 1. Sign Up for a Trial Account

1. From your laptop, go to (oracle.com/cloud/free)[oracle.com/cloud/free] and click “Start for free”.

![](./images/4.png "")

2. On the Oracle Cloud Sign Up page, enter the requested information including your desired tenancy name and tenancy password.

3. The OCI Console URL will be as shown in the screenshot below.  
The standard format is – https://myservices-<account_name>.console.oraclecloud.com. In this example, the account name provided during account creation is ‘nkpsftcloud’.  The URL will be: https://myservices-nkpsftcloud.console.oraclecloud.com. 

![](./images/2.png "")

3. Review your details and click **Submit**.

```
Note: Ensure that you use the same email address used when you registered.
```

You will be directed to the Oracle Cloud Infrastructure console where you will execute the remainder of the lab.

![](./images/1.png "")

Review the resources available in your tenancy. Navigate to Menu -> Administration -> Tenancy Details and review the service limits for Compute.  Determine the number of VM shapes available in your tenancy. 

![](./images/3.png "")

Your tenancy should have the following shapes. 


Shape | AD-1 | AD-2 | AD-3
----- | ---- | ---- | ----
VM.Standard2.1 | 1 | 1 | 1
VM.Standard2.2 | 1 | 1 | 1
VM.Standard.E2.1 | 1 | 1 | 1
VM.Standard.E2.2 | 1 | 1 | 1








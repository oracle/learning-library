# Self-Registration

![](images/4/header.png)

## Introduction

This is the third of several labs that are part of the **Oracle Public Cloud Identity Cloud Service workshop.** This workshop will walk you through the self-registration feature for external B2C users in Identity Cloud Service (IDCS).

In this lab, you will configure self-registration profile in IDCS for a specific group and have an end-user go through the self-registration process.

_Note: use Active Directory, if you have admin access to an active Directory environment. Otherwise use File Upload_

**_To log issues_**, click here to go to the [GitHub oracle](https://github.com/oracle/learning-library/issues/new) repository issue submission form.

## Persona

Administrators, External user

## Objectives

- Configure and verify self-registration
	- Create external group
	- Create registration profile 
	- Verify self-registration


## Configure and verify self-registration

### **STEP 1**: Create external group

`(Persona: Administrators)`

- Go to IDCS Admin Console -> Groups tab 

- Add group `OurPartner`

	![](images/4/SelfRegister-1.png)

- Click on `Finish`

	![](images/4/SelfRegister-2.png) 


### **STEP 2**: Create registration profile  

`(Persona: Administrators)`

- Login to IDCS Admin Console as an Administrator. Go to the **Settings** tab and click on the **Self Registration** menu from the sidebar.

	![](images/4/SelfRegister-3.png)

- Click on **Add Profile**

- On the Profile creation page, enter `Profile Name -` **`OurPartner`**. 

	![](images/4/SelfRegister-4.png)

- Click on **Add** under `Assign to Group` section. Select the external group **`OurPartner`** and click on **OK**

	![](images/4/100/SelfRegister-5.png)

- Under `Self-Registration Content` section, enter `Registration Page Name -` **`OurPartner`**.

	![](images/4/SelfRegister-6.png)

- Review the remaining sections. Keep the default values.

	![](images/4/SelfRegister-7.png)

- Click on **Save** and then click **Yes** on the **Confirmation**.

	![](images/4/SelfRegister-8.png)
	
	![](images/4/SelfRegister-9.png)

- Click on **Activate** and then **Activate Profile**

	![](images/4/SelfRegister-10.png)
	
	![](images/4/SelfRegister-11.png)

- Note the **`Profile ID`** and create the self-registration link in the following format :

	```js
	https://<tenant>.identity.oraclecloud.com/ui/v1/signup?profileid=<Noted Profile ID>
	```
	<blockquote>
	This link can be forwarded in the registration invitation email or other channel to the external users.
	</blockquote>
	
	![](images/4/SelfRegister-12.png)

### **STEP 3**: Verify self-registration

`(Persona: External user)`

- Click on the Registration link supplied.

	![](images/4/SelfRegister-13.png)

- Enter required profile information and **submit**

	![](images/4/SelfRegister-14.png)

- On the Success message page, click on **continue**. **Skip** the 2-step verification.

	![](images/4/SelfRegister-15.png)
	
	![](images/4/SelfRegister-16.png)

- From the `My Apps` page access the `My Profile` menu. 

	![](images/4/SelfRegister-17.png)
	
	![](images/4/SelfRegister-18.png)

- Go to the `My Access` tab. Ensure that user is part of the group configured in the registration profile. 

	<blockquote>
	If the group is assigned to one or more apps in IDCS, the new user will automatically gain access to those apps, and the apps will be visible on the My Apps page.
	</blockquote>
	
	![](images/4/SelfRegister-19.png)
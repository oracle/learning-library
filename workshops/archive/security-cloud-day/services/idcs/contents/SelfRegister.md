# B2C: Self-Registration


## Create External Group

- Go to IDCS Admin Console -> Groups tab 

- Add group `OurPartner`

	![](images/SelfRegister-1.png)

- Click on `Finish`

	![](images/SelfRegister-2.png) 


## Create Registration profile  - (Persona: Administrator)

- Login to IDCS Admin Console as an Administrator. Go to the **Settings** tab and click on the **Self Registration** menu from the sidebar.

	![](images/SelfRegister-3.png)

- Click on **Add Profile**

- On the Profile creation page, enter `Profile Name -` **`OurPartner`**. 

	![](images/SelfRegister-4.png)

- Click on **Add** under `Assign to Group` section. Select the external group **`OurPartner`** and click on **OK**

	![](images/100/SelfRegister-5.png)

- Under `Self-Registration Content` section, enter `Registration Page Name -` **`OurPartner`**.

	![](images/SelfRegister-6.png)

- Review the remaining sections. Keep the default values.

	![](images/SelfRegister-7.png)

- Click on **Save** and then click **Yes** on the **Confirmation**.

	![](images/SelfRegister-8.png)
	
	![](images/SelfRegister-9.png)

- Click on **Activate** and then **Activate Profile**

	![](images/SelfRegister-10.png)
	
	![](images/SelfRegister-11.png)

- Note the **`Profile ID`** and create the self-registration link in the following format :

	```js
	https://<tenant>.identity.oraclecloud.com/ui/v1/signup?profileid=<Noted Profile ID>
	```
	<blockquote>
	This link can be forwarded in the registration invitation email or other channel to the external users.
	</blockquote>
	
	![](images/SelfRegister-12.png)

## Self Registration - (Persona: End-User)

- Click on the Registration link supplied.

	![](images/SelfRegister-13.png)

- Enter required profile information and **submit**

	![](images/SelfRegister-14.png)

- On the Success message page, click on **continue**. **Skip** the 2-step verification.

	![](images/SelfRegister-15.png)
	
	![](images/SelfRegister-16.png)

- From the `My Apps` page access the `My Profile` menu. 

	![](images/SelfRegister-17.png)
	
	![](images/SelfRegister-18.png)

- Go to the `My Access` tab. Ensure that user is part of the group configured in the registration profile. 

	<blockquote>
	If the group is assigned to one or more apps in IDCS, the new user will automatically gain access to those apps, and the apps will be visible on the My Apps page.
	</blockquote>
	
	![](images/SelfRegister-19.png)
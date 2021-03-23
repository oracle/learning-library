# LiveLabs FAQ

## Introduction

For questions related to LiveLabs please review this FAQ. If you don't see an answer listed here, please visit the LiveLabs slack channel, #livelabs-help or email the admins [livelabs-admin_us@oracle.com](livelabs-admin_us@oracle.com).

## **General FAQ**

1.	Is this cloud only?
    -	No, we have workshops On-Premises too.
2.	Is LiveLabs available to customers? Can I share it with them?
    -	Yes, it is accessible globally. LiveLabs passed CSSAP review and is available outside the firewall. Search for Oracle LiveLabs on the search engine of their choice, click on the apex link, go to LiveLabs homepage.
3.	Is this just for certain regions? Certain groups?
    -	No, It is available globally. Search for Oracle LiveLabs on the search engine of their choice, click on the apex link, go to LiveLabs homepage.
4.	What to do if I am looking for a Certification/Training?
    -	We have content that supports certification. You can shortlist the workshops based on Focus Area, Product, and other filters on the right side of the LiveLabs workshops catalog. Please check with Oracle University for certification assistance.
5.	How to view/Do we get the report of who is running the workshops?
    -	Brown buttons
        - We track only the view count of the workshop, i.e., The number of hits for the apex link of a workshop. We do not track usage, it violates privacy rules set up by security and legal. 
        - The views report is only available to Oracle employees, you must login with your SSO to view it. 
        - To get the view count, go to [LiveLabs](https://apexapps.oracle.com/pls/apex/f?p=133:1) homepage, click the Question mark icon on the top right corner of the page, then select Dashboard.
        - Scroll down the Dashboard to the Workshop Views, select your workshop from the drop-down list. 
    -	Green button
        - We track who took a workshop on the LiveLabs tenancy. We are allowed via CSSAP to track the workshop id and email for those who click the green button.
6.	Which link should I share?
    -	Share only the Apex URLs for the workshops in production. This helps in tracking the views for the workshop by counting the number of hits on the Apex URL of the workshop.
    -	Don’t share the github.io links, we do not track this URL and that may change.
7.	How to look for a specific workshop to run?
    -	Search in [LiveLabs](https://apexapps.oracle.com/pls/apex/f?p=133:1). It is self-service.
    -	Or click [here](https://apex.oraclecorp.com/pls/apex/f?p=24885:51) to navigate to LWMS.
    -	Look through the catalog or search the workshop using the Search bar on the top.
    -	If the status of the workshop is in production on the tile, click on the tile.
    -	Look for the production link field to navigate to the workshop and run.
8.	Do you support SAAS/PAAS for SAAS workshops?
    -	We do not support Saas/Paas for Saas workshops.
9.	Do you create a green button for the workshops that require a Federated user?
    -  We do not configure the workshops that need federated users on livelabs tenancy as of now.
10.	Is there a way to view the workshop instructions without reserving a workshop and securing an environment?
    -	Workshops and environments do not have to be reserved. All workshops can be executed on-demand on any kind of environment, freetier, or paid.  Only certain workshops run and are pre-provisioned on an oracle tenancy.  A customer would not reserve an environment to execute a workshop on the freetier, it’s on-demand. Click on any of the brown buttons to view the workshop instructions.
11.	What to do if I am unable to launch green button?
    -	If you are already logged into your own tenancy when clicking on a Livelabs link, the livelabs reservation login link will skip the login (because according to the system you have already authenticated to your own tenancy) and tries to navigate to the assigned Livelabs tenancy. Please make sure you are logged off completely from your own tenancy or use another (private) browser window to connect.
12.	What is the difference is between LiveLabs vs Luna?
    -	The main difference between LiveLabs and Luna is use case. LiveLabs is a deal and consumption focused while Luna is learn focused. The goal of LiveLabs is not to learn but to drive customer consumption and support events. The combination of the two give a full solution for Oracle.

## **Development FAQ**

1.	What should I do if I am making major updates to the workshop in production?
    -	If the workshop is in production, and the updates are major (i.e. not fixes, spelling updates, revised screenshots, etc) place the workshop back In Development. 
    -	Create a new version of the workshop folder with the updated version
    -	Create new manifest copies of the changed files (i.e. setup.md is copied and called setup-v2.md)
    -	Proceed through the status’ like normal, submit Self QA
    -	Once QA Verification is complete, we will point to the new workshop (this allows us to roll back to the earlier version if there is an issue)
2.	What binary files are not allowed in Github?
    -	The OGHO wants to avoid executable files that can contain malicious code (PDFs, PSDs, ZIPs, JARs, WARs, EARs, BINs, EXEs).
3.	Where do I put my workshop files/objects?
    -	Zip your files and mail to [livelabs-admin_us@oracle.com](livelabs-admin_us@oracle.com).
    -	LiveLabs team will upload the file in LiveLabs owned tenancy object storage and share the pre-authenticated link with an expiry date to you in 1-2 days.
    -	Once you receive the link update the workshop with the expiry date in the Acknowledgments section of the workshop.
4.	How to submit videos for the workshops to one of the Oracle’s official Youtube channels?
    -	Workshop videos can only be sourced from one of the official Oracle Youtube channels.  We have a LiveLabs YouTube channel.  Submit the video to [livelabs-admin_us@oracle.com](livelabs-admin_us@oracle.com) and we will review and upload it.
5.	How to create a custom image from the Marketplace?
    -	Refer to [this](https://rpastijn.github.io/stuff/?lab=custom-image-mp-image) documentation on Github.
6. What to do if my github local and staging environment are corrupted and need to delete it and then rebuilt it?
    - Instructions to delete a forked repo on Github:
        - Go to Settings of Repo you want to unfork
        - Scroll down till danger zone section and click Delete this Repository
        - Enter your name / Repo name
        - Click “I understand the consequences, delete this repository” button.
    - Delete the same repo you just deleted on Github on your local machine as well.
    - After the successful deletion of repo on Github and local machine, follow the instructions from step 7 in lab 1 - Get Started with Git and Set up the GitHub Environment to rebuilt the repo.
7.	Any questions related to Github?
    -	Join the Slack channel: #livelabs-help and ask the question in the channel.

## **Workshops FAQ**

1.	Do I need to be on a VPN to access LiveLabs Workshop Management System (LWMS)?
    - Yes, you need to be on VPN to access LWMS.
2.	Who can submit a workshop?
    -	Anyone within Oracle can submit a workshop.
    -	If a partner is interested in submitting a workshop, an employee within Oracle needs to submit the workshop on their behalf.
3.	How to submit a workshop?
    -	Click [here](https://apex.oraclecorp.com/pls/apex/f?p=24885:51) to navigate to LWMS.
    -	First, search if there is already existing content in the catalog using the Search Bar on the top. If yes, contact the authors of that workshop - Click on the workshop tile and then click on Ask Workshop Contacts a Question. Write a message in the description box, click Send Mail.
    -	If no, proceed to submit a workshop.
    -	On the left menu, click on Submit a New Workshop.
    -	Fill in the required fields on the Workshop Details Page.
    -	Navigate to the Tag Management page and select the required tags. ( If we missed a tag please write the name of the Tag in Have a Question description box and click Send, we will add it.)
    -	If you want to run your workshop on LiveLabs tenancy, fill in the necessary details in the Green Button Requirements and Paid Policies page.
    -	Click the Create button on the right corner of the page.
4.	How to edit my workshop?
    -	Click [here](https://apex.oraclecorp.com/pls/apex/f?p=24885:51) to navigate to LWMS.
    -	On the left menu, click on Edit My Workshop.
    -	Click on the Id of the workshop you want to edit.
    -	Make the necessary changes to the workshop and ensure to fill in the required fields.
    -	Click the Apply Changes button on the right corner of the page.
5.	How to update the status of my workshop?
    -	Click [here](https://apex.oraclecorp.com/pls/apex/f?p=24885:51) to navigate to LWMS.
    -	On the left menu, click on Edit My Workshop.
    -	Double click on the Workshop Status column of the workshop to see the drop-down list.
    -	Select the status you want to update and click on Save.
6.	How to contact the author of a workshop?
    -	Click [here](https://apex.oraclecorp.com/pls/apex/f?p=24885:51) to navigate to LWMS.
    -	Look through the catalog or search the workshop using the Search bar on the top.
    -	Click on the workshop tile of the workshop author you want to contact.
    -	Then click on Ask Workshop Contacts a Question.
    -	Write a message in the description box, click Send Mail.
7.	How to request for a green button?
    -	Click [here](https://apex.oraclecorp.com/pls/apex/f?p=24885:51) to navigate to LWMS.
    -	If your workshop is already in the system - On the left menu, click on Edit My Workshop.
    -	Click on the Id of the workshop you want to edit.
    -	Fill in the necessary details on the Green Button Requirements and Paid Policies page.
    -	Update us by writing a comment in the description box and click Send.
    -	Then click the Apply Changes button on the right corner of the page.
8.	Which environments the workshops run?
    -	Freetier - Usually offers approx.$300 worth of cloud credits for 30 days.
    -	Always Free - Once the freetier account ran out of credits, it becomes always free.
    -	Paid - already configured tenancy.
    -	LiveLabs - We have a tenancy dedicated to run the workshops. An environment is preconfigured for the workshops to run. You just supply the public key.
    -	Freetier, Always Free, and Paid are called Brown button whereas LiveLabs tenancy is called green button.
9.	How to know/update the support forum of a workshop?
    -	Click [here](https://apex.oraclecorp.com/pls/apex/f?p=24885:51) to navigate to LWMS.
    -	On the left menu, click on Edit My Workshop.
    -	Double click on the Support column of the workshop to see the drop-down list.
    -	Select the status you want to update and click on Save.
    -	Click on the Id of that workshop and scroll down to the Support Link field to see the support forum link of the workshop.
10.	How do I see the status of other workshops?
    -	Click [here](https://apex.oraclecorp.com/pls/apex/f?p=24885:51) to navigate to LWMS.
    -	Look through the catalog or search the workshop using the Search bar on the top.
    -	You can see the status of the workshop on the tile.
11.	What is the process and ETA to hear from LiveLabs team about the status change from submitted to approved?
    -	Once the workshop is submitted, we update the workshop status to More Info Needed if there is more information required from the workshop else move it to Under Council Review status.
    -	Council reviewer is a person chosen from an Org to represent review and approve workshops. Upon reviewing the workshop info, the council reviewer will approve the workshop by writing us an update or approved in the Submit comments/questions/discuss with the LiveLabs Team below description box and click Send.
    -	LiveLabs team will then update the status of the workshop to approved.
    -	ETA to approve the workshop is 2-3 days.
12.	Can we restrict the pool of regions where our lab runs to a subset of the supported regions – Green Button workshop?
    -	Yes, we can limit a workshop to specific regions for the workshops that run on LiveLabs tenancy.
13.	How to download the list of all the workshops in production?
    -	Click [here](https://apex.oraclecorp.com/pls/apex/f?p=24885:51) to navigate to LWMS.
    -	Click on Report: View All Workshops on the left menu Report.  
    -	Click on Production flg column and select 1 from the dropdown list to filter the workshops in production.
    -	Click Actions -> Download -> Excel Download.

## **Event Codes FAQ**

1.	What is an event code?
    -	An Event code is a fully customizable way to run a customized set of focused labs for your target audience. We now fully support hidden workshops for Oracle sales/PM and marketing purposes. They won’t be accessible to the general audience, cannot be indexed by search engines, the user must login with Oracle SSO and have the code to proceed.
2.	Can anyone create an event code?
    -	Only those with an oracle.com account
3.	How to request an event code in LWMS?
    -	Click [here](https://apex.oraclecorp.com/pls/apex/f?p=24885:51) to navigate to LWMS.
    -	Click on Request an Event Code and fill the required fields then click Save Event, then click OK and then click Next.
    -	Fill in the description boxes that you want to customize and click Request Event.
4.	Can I edit my event code once requested in LWMS?
    -	No, write a message in the description box and click submit. We make the changes.
5.	Who is an event code ambassador?
    -	Event code ambassador represent an Org within Oracle to create event codes.
6.	For Event Code Ambassador - How to create/update an event code in production? Extend time period for running the event?
    -	Create or update an event by watching [this](https://otube.oracle.com/media/Creating+Event+Codes+in+LiveLabs/1_gbrukexm) video.
7.	When will the event code be active?
    -	The event code will be active on the day of the event or the specific time period you requested the event code.
8.	Can anyone access the event code or event code link?
    -	Only those with an oracle.com account
9.	How many event codes can I request?
    -	You can create as many event codes you want based on your requirement/
10.	Can I create a custom workshop and select just the labs I want to do for my event?
    -	Yes, build a separate manifest.json (with your event name), push that to GitHub and give us the new link.
11.	How long can a custom page be available?
    -	For the time period you requested it for, up to a maximum of 365 days.
12.	Once I submit my request, what’s next?
    -	We take a look and if everything looks good, we approve it, create your event and send you your request code within 1-2 days.
13.	Can I link the event to sales cloud or similar systems?
    -	Yes
14.	Once the event code is ready, What and when should I share details with the customer?
    -	You can share your event code link, event code, and QR image to your customers at any time.
    -	The event code will be active on the day of the event or the specific time period you requested the event code.
15.	What are customer actions?
    -	Only those with an oracle.com account can access the event code page using the event code or event code link.
    -	To navigate to the event page, the customer will use the event code link or search for Oracle LiveLabs on the search engine of their choice, click on the apex link, go to LiveLabs homepage, click on Have an Event Code?, provide the event code and click Submit Event Code, provide the account details and view the event page.
    -	To run the workshop Freetier or Always Free or Paid tenancy, hit the brown button:
        -  Launch workshop.
        -  Then click on Open these workshop instructions in a new tab to run through the instructions.
    -	To run the workshop using the livelabs tenancy, hit the Green button:
        - On the Reserve page, Choose the Start Timezone, turn on the Start Workshop Now button, provide your public SSH keys if requested, check the I consent to receive the reservation emails checkbox, and click Submit reservation.
        - On My Reservations Page, once the provisioning is done, click on Launch Console to view the Workshop details and Instructions to run the workshop.
        - Provisioning would depend on the workshop, 5-10 minutes for traditional cloud, and 15-25 or so for those with images (on-premises).
        - Then click on Open these workshop instructions in a new tab available at the bottom of the page to run through the instructions.
16.	How many users can at the same time?
    -	Freetier or Always Free or Paid tenancy – A customer would not reserve an environment to execute a workshop on the freetier, it’s on-demand.
    -	To run in LiveLabs tenancy through a green button - There is a quota on how many can be run.  It’s limited by our collection of tenancies and what else is running on the system. We allow 30 concurrent users as the customer would reserve an environment to run the workshop at the same time. If you provide your Own tenancy it is just limited by the resources available.
17.	Do we get the report of who is running the workshops?
    -	Yes, the voucher owner gets access to view the report of the email Id and date registered.
18.	Are the event codes internal only? Or if an external prospect wants to use these will they need to request one?
    -	The vouchers are so that internal people (sales, marketing, consulting, etc) can create their own customizable workshop page for their participants.
19.	If I request the code for a workshop, does it mean that the workshop will be able to run on oracle's tenancy?
    -	Not all of the workshops have the "green button" to reserve a workshop enabled.
    -	It goes by what that particular workshop is configured to run on. e.g. If the workshop is configured to run on both freetier & paid, the event code will have both of the options
20.	Do you track the resource details of what the customers used while running the event?
    -	No, we do not track the resource details of what the customers used while running the event.
21.	When I create an event code, the link requires an oracle login to access the event. Is there a way to create an event code without authentication?
    -	No, all the users need to pass the authentication to login to the event.

## **LiveLabs Production FAQ**

1.	Do I need to be on VPN to access LiveLabs URL?
    -	No, LiveLabs passed CSSAP review and is available outside the firewall. It is accessible globally. Search for Oracle LiveLabs on the search engine of their choice, click on the apex link to go to LiveLabs homepage.
2.	Who can run the workshop? 
    -	LiveLabs passed CSSAP review and is available outside the firewall. Anyone can run the workshops.
3.	What do you need to run the workshop?
    -	Brown Button (Freetier, Always Free, Paid tenancy) – You do need anything to run the workshop. 
    -	Green Button (LiveLabs tenancy) - An account of any type registered with Oracle (Eg: Gmail)
4.	How to register for a workshop?
    -	Navigate to [LiveLabs](https://apexapps.oracle.com/pls/apex/f?p=133:1).
    -	Click on View All Workshops to search for the workshop you want to run or type the keyword in Search Bar on top of the LiveLabs homepage.
    -	Filter the workshops based on the Role, Focus Area and Product, etc filter option on the right side of the page.
    -	Once you finalize the workshop you want to run, Click on Launch Workshop.
    -	Brown button:
        - If you want to run the work on a Freetier or Always Free or Paid tenancy, click on the respective brown button - Launch workshop.
        - Then click on Open these workshop instructions in a new tab to run through the instructions.. in a new tab
    -	Green button:
        - If you want to run the workshop on LiveLabs tenancy, click on the Green button – Reserve workshop on LiveLabs.
        - Provide credentials of the account registered with Oracle (SSO) and sign in.
        - On the Reserve page, Choose the Start Timezone, turn on the Start Workshop Now button, provide your public SSH keys if requested, check the I consent to receive the reservation emails checkbox, and click Submit reservation.
        - On My Reservations Page, once the provisioning is done, click on Launch Console to view the Workshop details and Instructions to run the workshop.
        - Then click on Open these workshop instructions in a new tab available at the bottom of the page to run through the instructions.
5.	How do I extend the LiveLabs tenancy workshop execution time?
    -	If you have an active reservation, you can extend the reservation of a workshop:
        - Navigate to My reservations on [LiveLabs](https://apexapps.oracle.com/pls/apex/f?p=133:1) homepage.
        - Click on Launch Workshop of the active reservation workshop that you want to extend.
        - Click on Extend Workshop Reservation button available on the last row of the Workshop Details section.
6.	What do I do if I have a feedback for a workshop? Whom to reach if I face errors running through the workshop? What to do if I have similar content in LWMS and want to add more content to the existing workshop?
    -	Click on the Support forum Link in the Need Help section of the lab. You will be navigated to the community forum of the workshop and post your question there.
    -	Or, contact the author of the workshop listed in the acknowledgments section of the workshop through slack or write an email.
    -	Or, click [here](https://apex.oraclecorp.com/pls/apex/f?p=24885:51) to navigate to LWMS.
    -	Look through the catalog or search the workshop using the Search bar at the top.
    -	Click on the workshop tile of the workshop author you want to contact.
    -	Then click on Ask Workshop Contacts a Question.
    -	Write a message in the description box, click Send Mail.

## Acknowledgements

* **Author:** Anoosha Pilli, Product Manager, Database Product Management
* **Reviewed by:** Tom McGinn, Database and Database Cloud Service Senior Principal Product Manager, DB Development - Documentation
* **Last Updated By/Date:** Kay Malcolm, February 2021


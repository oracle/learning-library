# Agile Project Management

![](images/100/Picture100-lab.png)

Updated: November 15, 2017

## Introduction

This is the first of several labs that are part of the **Oracle Public Cloud DevOps and Cloud Native Microservices MySQL workshop.** This workshop will walk you through the Software Development Lifecycle (SDLC) for a Cloud Native project that will create and use several Microservices.

Although you will login as a single user, you will take on 4 Personae during the workshop. The **Project Manager** Persona will create the projects, add tasks and features to be worked on, and assign tasks to developers.  The Project Manager will then start the initial sprint. The **Java Developer** persona will develop a new twitter feed service that will allow for retrieval and filtering of twitter data. The **Full Stack Developer** persona will develop a new database microservice that allows access to the product catalog data. The **JavaScript Developer** persona will make enhancements to the Product Catalog UI that will display the twitter data related to a select catalog item.  During this workshop, you will get exposure to Oracle Developer Cloud Service and Oracle Application Container Cloud Service.

***To log issues***, click here to go to the [github oracle](https://github.com/oracle/learning-library/issues/new) repository issue submission form.

## Objectives
- Create Initial Project
- Create Product Issues
    - Create Issues for Twitter Feed Microservice
    - Create Issues for Database Microservice
    - Create Issues for Product Catalog UI enhancements
- Create Agile Board and initial Sprint
- Add Issues to Sprint
- Start Sprint

## Required Artifacts

- The following lab requires an Oracle Public Cloud account that will be supplied by your instructor.

# Create Alpha Office Product Catalog Project

## Create Developer Cloud Service Project

### **STEP 1**: Login to your **Traditional** Oracle Cloud Account

- From any browser, go to the URL below, or if using a trial account, use the URL emailed to you in your confirmation email:

    `https://cloud.oracle.com`

- click **Sign In** in the upper right hand corner of the browser

    ![](images/100/Picture100-1.png)

- **IMPORTANT** - Under my services, select from the drop down list the correct data center and click on **My Services**. If you are unsure of the data center you should select, and this is an in-person training event, ***ask your instructor*** which **Region** to select from the drop down list. If you received your account through an ***Oracle Trial***, you should have recorded the needed information while following the instruction in the [Trial Account Student Guide](StudentGuide.md).

    ![](images/100/Picture100-2.png)

- Enter your identity domain and click **Go**.

    ![](images/100/Picture100-3.png)

- Once your Identity Domain is set, enter your User Name and Password and click **Sign In** 

  **NOTE:** For this lab you will assume the role of Project Manager ***Lisa Jones***. Although you are assuming the identity of Lisa Jones, you will log into the account using the **username** provided to you by your instructor, given to you by your corporation, or supplied to you as part of an Oracle Trial. As you progress through the workshop, you will remain logged in as a single user, but you will make “logical User" changes from Lisa Jones the Project Manager to other personas.

    ![](images/lisa.png)

    ![](images/100/Picture100-3.5.png)

- You will be presented with a Dashboard displaying the various cloud services available to this account.

    ![](images/100/Picture100-4.png)

- **Click** on the **Customize Dashboard** to add services to the dashboard. Services are added by selecting **Show.** For this workshop, you will want to ensure that you are showing **Developer cloud** service. 

    ![](images/100/Picture100-5.png)

### **STEP 2**: Login to Developer Cloud Service

Oracle Developer Cloud Service provides a complete development platform that streamlines team development processes and automates software delivery. The integrated platform includes an issue tracking system, agile development dashboards, code versioning and review platform, continuous integration and delivery automation, as well as team collaboration features such as wikis and live activity stream. With a rich web based dashboard and integration with popular development tools, Oracle Developer Cloud Service helps deliver better applications faster.

- From the Cloud UI dashboard click on the **Developer** service Hamburger menu, and then **Right Click** on **Open Service Console**, and open the console in a new tab. This will keep the Dashboard loaded on another tab.

    ![](images/100/Picture100-6.png)

- If you receive an error while loading the Console, return to the dashboard and ensure you follow the previous tasks instructions to "Open Service Console." 

### **STEP 3**: Create Developer Cloud Service Project

- Click **New Project** to start the project create wizard. **Note**: Depending on the status of your developer cloud serivce, it is possible that the button may be labled **Create Project** 

    ![](images/100/Picture100-8.png)

- On Details screen enter the following data and click on **Next**.

    **Name:** `Alpha Office Product Catalog Project`

    **Description:** `Alpha Office Product Catalog Project`

    **Note:** A Private project will only be seen by you. A Shared project will be seen by all Developer Cloud users. In either case, users need to be added to a project in order to interact with the project.

    ![](images/100/Picture100-9.png)

- Leave default template set to **Empty Project** and click **Next**

    ![](images/100/Picture100-10.png)

- Select your **Wiki Markup** preference to **MARKDOWN** and click **Finish**.

    ![](images/100/Picture100-11.png)

- The Project Creation will take about 1 minute.

    ![](images/100/Picture100-12.png)

- You now have a new project, in which you can manage your software development.

    ![](images/100/Picture100-13.png)



# Create Product Issues

## Create Issues for Twitter Feed Microservice

### **STEP 4**: Create Issue for the initial GIT Repository Creation

In this step you are still assuming the identity of the Project Manager, ***Lisa Jones***.

![](images/lisa.png)

- Click **Issues** on left hand navigation panel to display the Track Issues page.

    ![](images/100/Picture100-16.png)

- Click **New Issue**. Enter the following data in the New Issue page and click **Create Issue**.

    **Note:** Throughout the lab you will assign your own account as the “physical” owner of the issue, but for the sake of this workshop, **Bala Gupta** will be the “logical” owner of the following issues.

    ![](images/bala.png)

    **Summary:**
    `Create Initial GIT Repository for Twitter Feed Service`

    **Description:**
    `Create Initial GIT Repository for Twitter Feed Service`

    **Type:** `Task`

    **Owner:** `Select your account provided in the dropdown [Logical Owner = Bala Gupta]`

    **Story Points:** `1`

    Note: Story point is an arbitrary measure used by Scrum teams. They are used to measure the effort required to implement a story. This [Site](https://agilefaq.wordpress.com/2007/11/13/what-is-a-story-point/) will provide more information. 

    ![](images/100/Picture100-17.png)

### **STEP 5**: Create Issue for Update Twitter Service

- Click **New Issue**. Enter the following data in the New Issue page and click **Create Issue**.

    ![](images/bala.png)

    **Summary:** `Create Filter on Twitter Feed`

    **Description:** `Create Filter to allow user to supply text to reduce the amount of data returned by the Twitter feed`

    **Type:** `Feature`

    **Owner:** `Select your account provided in the dropdown [Logical Owner: Bala Gupta]`

    **Story Points:** `2`

    ![](images/100/Picture100-18.png)

### **STEP 6**: Create Issue for development of Database Microservice

- Click **New Issue**. Enter the following data in the New Issue page and click **Create Issue**. Issue will logically be owned by **Roland Dubois**.

    ![](images/Roland.png)

    **Summary:** `Create Microservice to allow access to Product Catalog data`

    **Description:** `Create Microservice to allow access to Product Catalog data`

    **Type:** `Feature`

    **Owner:** `Select your account provided in the dropdown [Logical Owner: Roland Dubois]`

    **Story Points:** `2`

    ![](images/100/Picture100-18.5.png)

### **STEP 7**: Create Issue for Development of Product Catalog UI

- Click **New Issue**. Enter the following data in the New Issue page and click **Create Issue**. Issue will logically be owned by **John Dunbar**.

    ![](images/john.png)

    **Summary:** `Create Alpha Office Product Catalog UI`

    **Description:** `Create Alpha Office Product Catalog UI making use of the new Microservices`

    **Type:** `Feature`

    **Owner:** `Select account provided in the dropdown [Logical Owner: John Dunbar]`

    **Story Points:** `2`

    ![](images/100/Picture100-20.png)

- Click the back arrow ![](images/100/Picture100-21.png) on the **left side** of the window, or click on the **Issues** menu option to view all newly created issues.

    ![](images/100/Picture100-22.png)

# Create Agile Board

## Create Agile Board and Initial Sprint

### Developer Cloud Service Agile Page Overview

Before you start using the Agile methodology in Oracle Developer Cloud Service, it is important that you know the following key components of the Agile page.

- **Board** – A Board is used to display and update issues of the project. When you create a Board, you associate it with an Issue Query. The Board shows Issues returned by the Query.
You can either use a Board created by a team member, or create your own Board. You can create as many Boards as you like.
- **Sprint** – A Sprint is a short duration (usually, a week or two) during which your team members try to implement a product component.
You add the product component related issues to a Sprint. When you start working on a product component, you start (or activate) the related Sprints. To update issues using a Sprint, you must first activate the Sprint and add the Sprint to the Active Sprints view.
- **Backlog view** – Lists all Issues returned by the Board’s Query. The view also displays all active and inactive Sprints of the Board, and the sprints from other Boards that contain Issues matching the Board’s Query.
Each Sprint lists issues that are added to it. The Backlog section (the last section of the Backlog page) lists all open issues that are not part of any Sprint yet. The Backlog view does not show the resolved and closed Issues.
- **Active Sprints view** – Lists all active Sprints of the Board and enables you to update an Issue status simply by dragging and dropping it to the respective status columns.
- **Reports view** – select the Burndown Chart tab to display the amount of work left to do in a Sprint or use the Sprint Report tab to list open and completed Issues of a Sprint.

### **STEP 8**: Create Agile Board

- Click **Agile** on the Left Side Menu to display a page listing all existing Boards

    ![](images/100/Picture100-23.png)

- Click **New Board** and enter the following data. When done click **Create**.

  **Name:** `Microservices`

  **Estimation:** `Story Points`

    ![](images/100/Picture100-24.png)

### **STEP 9**: Create Sprint
- We will now create our first Sprint. Click **New Sprint**. Enter the following data and click **OK.**

    **Name:** `Sprint 1 - Initial Development`

    **Story Points:** `7`

    ![](images/100/Picture100-25.png)

### **STEP 10**:	Add Backlog Issues to Sprint

- Next, we want to add the backlog issues to the newly created sprint. **Drag and drop** the **4 issues** one at a time upward onto the **Sprint 1** section. This will add the issues to the sprint.

    ![](images/100/Picture100-26.png)

    ![](images/100/Picture100-27.png)

### **STEP 11**: Start Sprint

- Click the **Start Sprint** button.

- Leave the defaults and click **Start**

    ![](images/100/Picture100-34.png)

- Now click on **Active Sprints** to view the Sprint Dashboard

    ![](images/100/Picture100-35.png)

- Click on the **Reports** button to view the Burndown and Sprint reports.

    ![](images/100/Picture100-36.png)

- **You are now ready to move to the next lab.**

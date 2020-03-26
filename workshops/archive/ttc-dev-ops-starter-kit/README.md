# Tips for Workshop Developers
<center>
<img src="https://oracle.github.io/learning-library/workshops/common-content/images/touch-the-cloud/ttc-logo.png" />
</center> 
    
## IMPORTANT: How to prepare for this workshop

**First**, ***Get an Oracle Cloud Account*** 
- Oracle provides several methods for gaining access to Oracle Cloud Accounts used to complete the Labs in this Hands-on-Workshop. 
    - For some workshop events, cloud environments will be provided. 
    - For others events (e.g. **Oracle Code**), or when completing this workshop in a self-service model, you must gain access to your own Trial account. Trial accounts can be obtained at [Try It](http://cloud.oracle.com/tryit) 
    - If you are attending an Oracle sponsored event, please **review your Event invitation** for more instruction on how to gain access to your Workshop Account.
        
**Second**, ***Configure your Client Environment***
- Please follow the [Prerequisite Guide](PreReqGuide.md) prior to attempting the Labs. 
      
## How to View the Lab Guides

- The Lab Guides are best viewed using the Workshop's [GitHub IO Pages Website URL](https://rebrand.ly/ttcdevopslab) 

- Once you are viewing the Workshop's GitHub Pages website, you can see a list of Lab Guides at any time by clicking on the **Menu Icon**

    ![](images/WorkshopMenu.png)  

- To log issues and view the Lab Guide source, go to the [github oracle](https://github.com/oracle/learning-library/tree/master/workshops) repository. 

## DevOps Starter Kit

This Oracle Public Cloud workshop will walk you through using some of the AppDev services found in your trial account while applying DevOps principles. It will also give you a hands on example of leveraging many of these servcies to build out a microservices architecture. You will be following DevOps principles of automation and consistancy throughout the workshop. No coding or detailed background of Oracle Cloud Services is required.

## Workshop Details

**Reference the following Lab Guides by opening their Documentation Files:**

## Lab 100: Build and Deploy your UI

**Documentation**: [LabGuide100.md](LabGuide100.md)

### Objectives

- Access [Developer Cloud Service](https://cloud.oracle.com/en_US/developer-service)
- Create Initial Project
- Import the UI application built on [NodeJS](https://nodejs.org/en/) and leveraging Oracle open source [JET framework](http://www.oracle.com/webfolder/technetwork/jet/index.html)
- Build and Deploy project using Developer Cloud Service and [Oracle Application Container Cloud Service](https://cloud.oracle.com/en_US/application-container-cloud)

## Lab 200: Your First Microservice

**Documentation**: [LabGuide200.md](LabGuide200.md)

### Objectives

- Access [Developer Cloud Service](https://cloud.oracle.com/en_US/developer-service)
- Import the microservice written in [Java](https://www.java.com/en/) into your project
- Build and Deploy project using Developer Cloud Service and [Oracle Application Container Cloud Service](https://cloud.oracle.com/en_US/application-container-cloud)
- Bind the microservice to your UI

## Lab 300: Create the Backend

**Documentation**: [LabGuide300.md](LabGuide300.md)

### Objectives

- Provision your [MySQL Cloud Service](https://cloud.oracle.com/en_US/mysql) backend
- Access [Developer Cloud Service](https://cloud.oracle.com/en_US/developer-service)
- Deploy your setup script automatically to your MySQL instance
- Bind the database to your microservice

## Lab 400:  Your Second Microservice

**Documentation**: [LabGuide400.md](LabGuide400.md)

### Objectives

- Provision your [Container Cloud service](https://cloud.oracle.com/en_US/container) instance
- Deploy a docker image from Docker Hub to your container cloud service
- Bind the microservice to your UI

## Deploy complex cloud environment using Oracle Cloud Stack Manager ##

### About this tutorial ###
Oracle Cloud Stack Manager is a feature of Oracle Cloud that allows for the provisioning of multiple services within the Oracle Cloud. In order to build and deploy their applications, businesses often require sophisticated environments that consist of multiple, integrated cloud services. Consider a development environment whose needs include a Java application server along with a relational database. Provisioning each of these services for every member of your development team is time consuming and error prone, regardless of whether you’re using service consoles or REST APIs to provision the services. Oracle Cloud Stack Manager uses templates to provision a group of services (called a stack) and in the correct order.

In the following tutorials you will learn how to quickly provision a group of related Oracle Cloud resources with Oracle Cloud Stack Manager.
You will use Cloud Stack Manager and a custom Oracle stack template to provision Oracle MySQL Cloud Service instance and multiple Oracle Application Container Cloud Services.

These tutorial demonstrates how to:

- create Oracle Developer Cloud Service project using existing external Git repository
- configure build job to build multiple services required by Cloud Native Application
- create and import custom Stack Template
- create Stack instance using Stack Template

### Prerequisites ###

- A valid identity domain, username and password for Oracle Cloud
- A subscription for Oracle MySQL Cloud Service and Application Container Cloud Service

----

Two version of Stack tutorials available.

1. [FixItFast Cloud Native Application which includes Oracle MySQL Cloud Service instance and multiple Oracle Application Container Cloud Services (Java, NodeJS). Requires more time (>30 min.) to deploy the complete stack due to MySQL Cloud Service provisioning.](stack.mysql.md)
![](images/stack.environment.png)

2. [FixItFast Cloud Native Application which includes multiple Oracle Application Container Cloud Services (Cache, Java, NodeJS). Requires less time (>10 min.) to deploy the complete stack.](stack.cache.md)

![](images/stack.environment.cache.png)

Choose one of the tutorial or both to learn Oracle Cloud Stack manager. 

# Lab 600 : Reviewing and updating a Topology

## Introduction

Cloud Manager provisions PeopleSoft environments on-demand with just a few clicks. The entire provisioning process is automated. At the end of provisioning, a ready-to-use environment is available within a short time. The environments can be created by a three step process:
1. Create Topology
2. Create Template
3. Create Environment

Topology defines the infrastructure layout that will be created on Oracle Cloud by Cloud Manager. An administrator defines a template for creating an environment. The topology is encapsulated inside the template. 

Users can select a template, override topologies, change any attributes, if needed, and provision PeopleSoft environments on demand. Users are allowed to perform actions on a running environment, such as stop, view details, create new template from it, and so on.

## Part 1

1.	Navigate to Dashboard | Topology | PUM Fulltier topology. This topology will be used to create a new environment. 

![](./images/1.png "")

2.	Review the nodes and update the Shapes.  Click Full Tier node and select a shape that is available in your AD 2. 
In this case, select VM.Standard2.1 or VM.Standard2.2. 
Review the available shapes in your AD, as explained in Lab 100.

![](./images/2.png "")

3.	Delete the Windows node from the topology. Click ‘Delete’ on the page shown below and save the topology. 

![](./images/3.png "")

4.	When you are ready, click **Save**. The topology should now look as shown below.

![](./images/4.png "")


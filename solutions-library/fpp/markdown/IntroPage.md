# Oracle Fleet Patching and Provisioning 

[//]: # (Author: David LaPoint david.lapoint@oracle.com)

## Quick Start Guide and Online Tutorial

Welcome to the online tutorials for Oracle's Fleet Patching Provisioning, aka FPP.  Here we hope to introduce you to some of FPP's basic concepts as we walk through some of the basic operations.

This tutorial is divided up into an introduction and the following HowTo Sections:


### Introduction - Concept Overview 


##### Fleet Patching and Provisioning is a software lifecycle management method for provisioning and maintaining Oracle homes.

Fleet Patching and Provisioning enables mass deployment and maintenance of standard operating environments for databases, clusters, and user-defined software types. With Fleet Patching and Provisioning, you can also install clusters and provision, patch, scale, and upgrade Oracle Grid Infrastructure and Oracle Database 11g release 2 (11.2), and later. Additionally, you can provision applications and middleware.
 
Fleet Patching and Provisioning is a service in Oracle Grid Infrastructure that you can use in either of the following modes:

 * 	As a central server (Fleet Patching and Provisioning Server), that stores and manages standardized images, called gold images. You can deploy gold images to any number of nodes across a data center. You can use the deployed homes to create new clusters and databases, and patch, upgrade, and scale existing installations.

 
<ul> <li style="list-style-type: none;"> The server manages software homes on the cluster hosting the Fleet Patching and Provisioning Server, itself, Fleet Patching and Provisioning Clients, and can also manage installations running Oracle Grid Infrastructure 11g release 2 (11.2.0.3 and 11.2.0.4) and 12c release 1 (12.1.0.2). The server can also manage installations running no grid infrastructure. </li> </ul>

<ul> <li style="list-style-type: none;"> A Fleet Patching and Provisioning Server can provision new installations and can manage existing installations without any changes to the existing installations (such as no agent, daemon, or configuration prerequisites). Fleet Patching and Provisioning Servers also include capabilities for automatically sharing gold images among peer Fleet Patching and Provisioning Servers to support enterprises with geographically distributed data centers.</li> </ul>

* As a client (Fleet Patching and Provisioning Client), that can be managed from the central Fleet Patching and Provisioning Server or directly by running commands on the Fleet Patching and Provisioning Client, itself. As with the Fleet Patching and Provisioning Server, the Fleet Patching and Provisioning Client is a service built in to Oracle Grid Infrastructure and is available with Oracle Grid Infrastructure 12c release 2 (12.2.0.1), and later. The Fleet Patching and Provisioning Client service can retrieve gold images from the Fleet Patching and Provisioning Server, upload new images based on policy, and apply maintenance operations to itself.

In this series of examples, we will focus on the basic operations needed to get started with a common and basic configuration that includes a central FPP server which manages GI and RDBMS provisioning of homes (workingcopies) on target (FPP clients) servers using 'gold' images stored on the FPP server. 

####To summarize:

An **image** is a copy of an Oracle home, for example GI or RDBMS, which is used as the standard configuration for home deployments of its type and purpose.

A **workingcopy**, is the deployed version of an FPP **image**.  It can be used for patching and upgrades also.  It is created *'out of place'* with any existing homes and when the time comes to patch or upgrade, FPP will *move* from the current active home to the new home.

For many more details and an extensive review of FPP, please see the '*Oracle Fleet Patching and Provisioning*' white paper at [https://www.oracle.com/goto/fpp](https://www.oracle.com/goto/fpp) and also the FPP documentation guides in the Clusterware Admin and Deployment Guide at [https://docs.oracle.com/en/database/oracle/oracle-database/index.html](https://docs.oracle.com/en/database/oracle/oracle-database/index.html). 




### Section 1 - Installation

1. [How to install your FPP server](01-createrhps.md)
2. [How to create your first FPP client](02-addrhpc.md)
  
### Section 2 - Creating Gold Images and Workingcopies. 
  
3. [How to create your first FPP gold 'Image' (GI Home)](03-importgiimage.md)
4. [How to deploy your first GI home from your new gold Image](04-addgiwc.md)
8. [How to create (import) a DB image](08-importdbimage.md)
9. [How to deploy (add) a new DB workingcopy](09-adddbwc.md)
  
### Section 3 - Patching - GI and DB. 
  
5. [How to patch your GI using your new GI home](05-movegihome.md)
7. [How to patch your DB ](07-patchdb.md)
  
### Section 4 - Upgrades - GI and DB.  
  
10. [How to upgrade your GI (18.6 to 19.5)](10-upgradegi.md)
11. [How to upgrade your DB (12.1 to 19.4)](11-upgradedb.md)
  
### Section 5 - Misc Topics  
  
99. [How to use Vagrant to create a test/demo FPP lab](OracleFPP_Vagrant/99-FPPonVagrant.md)
6. [Quick example of using FPP's Command-line Help](06-onlinehelp.md)
  

We hope you find these guides helpful and a productive start for your new FPP framework.
  
Simply click on the links above for the details of the HowTo of your interest.
  



###### Author: David LaPoint (<david.lapoint@oracle.com>) - Oracle RAC Pack, Cloud Innovation and Solution Engineering Team



[//]: # (Link List)
[//]: # (IntroPage.md)
[//]: # (01-createrhps.md)
[//]: # (02-addrhpc.md)
[//]: # (03-importgiimage.md)
[//]: # (04-addgiwc.md)
[//]: # (05-movegihome.md)
[//]: # (06-onlinehelp.md	)
[//]: # (07-patchdb.md	)
[//]: # (08-importdbimage.md)
[//]: # (09-adddbwc.md	)
[//]: # (10-upgradegi.md)
[//]: # (11-upgradedb.md)
[//]: # (99-OracleFPP_Vagrant/FPPonVagrant.md)
[//]: # ( )
[//]: # ( )
[//]: # ( )


[//]: # (Author:David LaPoint david.lapoint@oracle.com)


		
	

	
	
	
		








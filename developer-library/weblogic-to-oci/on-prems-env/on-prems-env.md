# Setup the Demo 'On-Premises' Environment

## Introduction

For this migration workshop, we need an environment to migrate *from*.

We're offering 2 ways to provision this environment:

- Using a demo Marketplace image for this workshop
- Using Docker, locally on your development machine

Both paths provide a pre-packaged 'on-premises' simulated environment which includes an Application Database and a WebLogic domain including 2 web applications and a datasource to connect to the database.

The Marketplace image deployment is simpler and faster, while the Docker environment provides a way to more realistically simulate an 'on-premises' environment as it runs on your local machine.

Estimated Lab Time: 15 to 30 minutes depending on path chosen.

### Objectives

In this workshop, you will:

- Choose a path to create a demo environment to use as the 'on-premises' environment.

### Prerequisites

*Depending on the path you choose, there a different requirements:*

For the Marketplace environment, you will need:
- One compute instance with 4 OCPU available

For the Docker environment, you will need:
- A machine with at least 3 CPUs and 6GB of memory to allocate to the Docker engine

## **STEP 1:** Choose a path

Choose the option that best suits your needs:

A. [Setup the on-premises environment using Marketplace image (15min)](?lab=lab-1-option-setup-on-premises-environment)

B. [Setup the on-premises environment using Docker (30min)](?lab=lab-1-option-b-setup-local-(on-premises))

*When you are done with the workshop, you should tear down the 'on-premises' environment.*

You may proceed to the next lab.

### Disclaimer

Note that this is a demo environment pre-packaged with a WebLogic Domain, demo applications and a Database inside a single VM. This is for demo/training purpose only and is not production-ready.

## Acknowledgements

 - **Author** - Emmanuel Leroy, May 2020
 - **Last Updated By/Date** - Emmanuel Leroy, August 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.

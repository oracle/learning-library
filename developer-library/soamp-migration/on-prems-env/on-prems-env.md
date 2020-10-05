# Setup the demo SOA 'on-premises' environment

## Introduction: 

For this migration workshop, we need an environment to migrate *from*.

We're offering 2 ways to provision this environment:

- Using a demo Marketplace image for this workshop
- Installing required Apps locally on your development machine

first path provide a pre-packaged 'on-premises' simulated environment which includes an VM of SOA Suite 12.2.1.3 and quick start SOA Suite 12.2.1.4 (Jdeveloper 12.2.1.4)

The Marketplace image deployment is simpler and faster, while the provisioning local environment provides a way to more realistically simulate an 'on-premises' environment as it runs on your local machine. 

### Objectives

In this workshop, you will:

- Choose a path to create a demo environment to use as the 'on-premises' environment.

### Prerequisites

*Depending on the path you choose, there a different requirements:*

For the Marketplace environment, you will need:
- One compute instance with 4 OCPU available

For the local machine environment, you will need:
- A machine with at least 12GB of memory to allocate to the `VM SOA Suite 12.2.1.3` and `quick start SOA 12.2.1.4 (Jdeveloper)`

## **STEP 1:** Choose a path

Choose the option that best suits your needs:

A. [Setup the on-premises environment using Marketplace image (15min)](?lab=lab-1-option-a-setup-on-premises-environment)

B. [Setup the on-premises environment using Docker (45min)](?lab=lab-1-option-b-setup-local-(on-premises))

*When you are done with the workshop, you should tear down the 'on-premises' environment.*

### Disclaimer

Note that this is a demo environment pre-packaged with a SOA WebLogic Domain, demo applications and a Database inside a single VM. This is for demo/training purpose only and is not production-ready.

## Acknowledgements

 - **Author** - Akshay Saxena, September 2020
 - **Last Updated By/Date** - Akshay Saxena, September 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.

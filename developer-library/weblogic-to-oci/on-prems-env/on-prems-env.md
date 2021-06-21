# Set up the demo on-premises environment

## Introduction

For this migration workshop, we need an environment to migrate *from*.

We're offering 2 ways to provision this environment:

- Using a demo marketplace image for this workshop.
- Using Docker locally on your development machine.

Both paths provide a pre-packaged on-premises simulated environment, which includes an application database and a WebLogic domain with two web applications and a datasource to connect to the database.

The marketplace image deployment is simpler and faster, while the Docker environment provides a way to more realistically simulate an on-premises environment as it runs on your local machine.

Estimated Completion Time: 15 to 30 minutes depending on path chosen.

### Objectives

In this workshop, choose a path to create a demo environment to use as the on-premises environment.

### Prerequisites

Depending on the path you choose, there are different requirements:

- For the marketplace environment, you will need one compute instance with 4 OCPU available.

- For the Docker environment, you will need a machine with at least 3 CPUs and 6 GB of memory to allocate to the Docker engine.

## **STEP 1:** Choose a Path

Choose the option that best suits your needs:

A. [Set up the on-premises environment using marketplace image (15min)](?lab=lab-1-option-set-up-on-premises-environment)

B. [Set up the on-premises environment using Docker (30min)](?lab=lab-1-option-b-set-up-local-(on-premises))

*When you are done with the workshop, you should tear down the on-premises environment.*

### Disclaimer

Note that this is a demo environment pre-packaged with a WebLogic Domain, demo applications and a database inside a single VM. This is for demo or training purpose only and is not production-ready.

## Acknowledgements

 - **Author** - Emmanuel Leroy, May 2020
 - **Last Updated By/Date** - Emmanuel Leroy, August 2020

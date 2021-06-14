# Scaling the Apache Tomcat Cluster

## Introduction

In this lab, we will explain how to scale the number of Tomcat nodes on Oracle Cloud Infrastructure (OCI).

Estimated Lab Time: 5 minutes.

### Objectives

In this lab, you will scale the number of nodes.

### Prerequisites

For this lab, you need to have provisioned the Tomcat cluster on OCI.

## **STEP 1:** Scale the Number of Nodes

On your local machine where you ran the Terraform:

1. Edit the `terraform.tfvars` file to have:

    ```yaml
    numberOfNodes=2
    ```

2. Run terraform plan:

    ```bash
    <copy>
    terraform plan
    </copy>
    ```

    Check the output to make sure this is what you expected. It should add a compute instance and re-register a backend to the load balancer.


3. Run terraform apply:

    ```bash
    <copy>
    terraform apply
    </copy>
    ```

    Once this is complete, you'll get the public IPs of the two Tomcat servers, as well as the load balancer IP.


## **STEP 2:** Deploy the Application on the New Server

1. Follow the previous *Migrate Tomcat Application* lab to re-deploy the application.

    Since you may not have the source Tomcat server to scp the war file from, you may first download it from the current deployment.

    To migrate the `SimpleDB.war` file from one server to the other, you can use:

    ```
    export TOMCAT_IP_1=<ip of source tomcat server>
    export TOMCAT_IP_2=<ip of destination tomcat server>
    scp opc@${TOMCAT_IP_1}:~/SimpleDB.war opc@${TOMCAT_IP_2}:~/
    ```

2. Follow the steps to deploy the application and configure the datasource from the *Migrate Tomcat Application* lab.

You're done!


## Acknowledgements
 - **Author** - Subash Singh, Emmanuel Leroy, October 2020
 - **Last Updated By/Date** - Emmanuel Leroy, October 2020

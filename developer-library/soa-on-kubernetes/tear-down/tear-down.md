# Tear Down the Environment

## Introduction

In this lab, we will undeploy the Oracle SOA deployment and destroy the infrastructure provisioned.

Estimated Lab Time: 15 minutes.

### Objectives

In this lab, you clean up the environment.

## **STEP 1:** Clean Up the SOA Domain Only With Terraform

1. If you deployed everything with Terraform, and you want to clean up the SOA domain only but keep the cluster up you can use:

    ```bash
    <copy>
    terraform destroy --target=null_resource.deploy_soa
    </copy>
    ```

2. Type `yes` at the prompt and wait for the process to finish.

3. You can check the pods are gone (or Terminating) by using:

    ```bash
    <copy>
    kubectl get pods -n soans
    </copy>
    ```

## **STEP 2:** Clean Up the SOA Domain Only Using Helm

If you wanted to remove the SOA domain using Helm, you need to use a 2-steps process (which is performed by the Terraform)

The steps are shown here for reference, as you already undeployed the domain on STEP 1.

1. Remove the domain manifest using:

    ```bash
    helm upgrade mysoa oracle/soa-suite -n soans \
        --reuse-values \
        --set domain.enabled=false \
        --wait
    ```

    This removes the domain, and terminates the SOA servers. This is necessary as the chart deletion runs a process to delete the installation files on the file storage, as well as the database schemas. With the pods still running, the file deletion process would fails as the files are still being accessed by the pods.

2. Wait until the pods are terminated:

    ```bash
    kubectl get pods -n soans
    ```

3. Delete the chart:

    ```bash
    helm delete mysoa -n soans
    ```

## **STEP 3:** Decommission the Infrastructure

1. To decommission the whole infrastructure, use

    ```bash
    <copy>
    terraform destroy
    </copy>
    ```

2. Type `yes` at the prompt

3. If destroy fails for some reason, run the command again.

You are done.

## Acknowledgements
 - **Author** - Emmanuel Leroy, Senior Technical Product Manager
 - **Last Updated By/Date** - Emmanuel Leroy, May 2021

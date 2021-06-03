# Scale an Oracle SOA Suite Domain

## Introduction

In this lab, we will learn how to scale the Oracle SOA Suite Domain provisioned. There are multiple ways to do so.

Estimated Lab Time: 10 minutes.

### Objectives

In this lab, you will scale the number of managed servers in the SOA cluster.

There are 2 ways to do so:

- Editing the domain manifest directly (not recommended).
- Editing the values in the Helm chart (recommended).

## **STEP 1:** Scale by Editing the Domain Manifest

The original way of scaling the Oracle SOA domain when deploying Kubernetes manifests manually, is to edit the domain manifest.

1. Edit the manifest with kubectl (assuming the deployment name and namespace were kept as defaults)

    ```bash
    <copy>
    kubectl edit domain mysoa -n soans
    </copy>
    ```

2. This opens a vim editor where you can see the content of the domain definition. Scroll down to the section:

    ```yaml
    clusters:
    - clusterName: soa_cluster
      replicas: 2
    ```

3. Press the letter `i` to enter edit mode in vim.

4. Change the number of `replicas` to 3.

5. Press the ESC key to exit edit mode

6. Type `:wq` to write the changes and quit the editor (that's 'colon', 'w' and 'q') )

7. Observe the change in the number of managed servers with:

    ```bash
    <copy>
    kubectl get pods -n soans
    </copy>
    ```

    It should show a new entry:

    ```bash
    mysoa-soa-server3   0/1     ContainerCreating   0          6s      <none>      10.0.10.56    <none>           <none>
    ```

## **STEP 2:** Scale by Updating the Helm Chart

The main issue with the previous method is that the changes are no longer tracked by the Helm deployment.

To properly track the changes through Helm, it is recommended to edit the chart input values to scale the number of managed servers.

Let's scale the number of managed servers for the OSB cluster this time, and we'll also observe how the Helm controller returns the SOA cluster to its original number of managed servers.

1. Update the Helm Chart

    ```bash
    <copy>
    helm upgrade mysoa oracle/soa-suite \
      -n soans \
      --reuse-values \
      --set domain.osbCluster.managedServers.count=3
    </copy>
    ```

2. Check the effect of the change:

    ```bash
    <copy>
    kubectl get pods -n soans
    </copy>
    ```

    Will list the changes. We should see the following 

    ```bash
    mysoa-soa-server3   0/1     Terminating         0          6s      <none>      10.0.10.56    <none>           <none>
    mysoa-osb-server3   0/1     ContainerCreating   0          30s     10.1.0.134   10.0.10.56    <none>           <none>
    ```

    The number of replicas for the SOA cluster known to Helm was 2, so our previous change to 3 is overriden and changed back to 2, causing the mysoa-soa-server3 to be terminated, while the change we just made in the values created a new managed server for the OSB cluster, named `mysoa-osb-server3`.

You may now [proceed to the next lab](#next).

## Acknowledgements
 - **Author** - Emmanuel Leroy, Senior Technical Product Manager
 - **Last Updated By/Date** - Emmanuel Leroy, May 2021

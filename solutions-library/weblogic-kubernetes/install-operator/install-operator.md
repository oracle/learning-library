# Install and configure the operator  ###


## Introduction

This lab demonstrates how to Install and configure the operator.

So far on our journey from on-premises WebLogic Server to Oracle Container Engine for Kubernetes, we have created Oracle Container Engine for Kubernetes (OKE) on Oracle Cloud Infrastructure (OCI).

### About Operators
An operator is an application-specific controller that extends Kubernetes to create, configure, and manage instances of complex applications. The Oracle WebLogic Server Kubernetes Operator (the "operator") simplifies the management and operation of WebLogic domains and deployments.


### Objectives
- Clone the operator repository to a Cloud Shell instance
- Prepare the environment
- Install the operator using Helm


### Prerequisites
* An Oracle Paid or LiveLabs Cloud account.
* Google Chrome browser (preferred)
* Lab: Prerequisites
* Lab: OKE on OCI


## **STEP 1**: Clone the operator repository to a Cloud Shell instance  

1.  First, clone the operator git repository to OCI Cloud Shell.
  ```
  <copy>git clone https://github.com/oracle/weblogic-kubernetes-operator.git -b v2.5.0</copy>
  ```
2.  The output should be similar to the following:
  ```
  Cloning into 'weblogic-kubernetes-operator'...
  remote: Enumerating objects: 1568, done.
  remote: Counting objects: 100% (1568/1568), done.
  remote: Compressing objects: 100% (641/641), done.
  remote: Total 123827 (delta 748), reused 1284 (delta 567), pack-reused 122259
  Receiving objects: 100% (123827/123827), 86.55 MiB | 28.25 MiB/s, done.
  Resolving deltas: 100% (74546/74546), done.
  Note: checking out 'b9d4b934ebd90df9726dc4051ece82491bd726c0'.

  You are in 'detached HEAD' state. You can look around, make experimental
  changes and commit them, and you can discard any commits you make in this
  state without impacting any branches by performing another checkout.

  If you want to create a new branch to retain commits you create, you may
  do so (now or later) by using -b with the checkout command again. Example:

    git checkout -b new_branch_name

  Checking out files: 100% (8396/8396), done.
  ```
## **STEP 2**: Prepare the environment 
Kubernetes distinguishes between the concept of a user account and a service account for a number of reasons. The main reason is that user accounts are for humans while service accounts are for processes, which run in pods. The operator also requires service accounts.  If a service account is not specified, it defaults to **default** (for example, the namespace's default service account). If you want to use a different service account, then you must create the operator's namespace and the service account before installing the operator Helm chart.

1.  Create the operator's namespace in advance:
  ```
  <copy>kubectl create namespace sample-weblogic-operator-ns</copy>
  ```
2.  Create the service account:
  ```
  <copy>kubectl create serviceaccount -n sample-weblogic-operator-ns sample-weblogic-operator-sa</copy>
  ```
3.  Finally, add a stable repository to Helm, which will be needed later for 3rd party services.
  ```
  <copy>helm repo add stable https://kubernetes-charts.storage.googleapis.com/</copy>
  ```
## **STEP 3**: Install the operator using Helm 

Use the **helm install** command to install the operator Helm chart. As part of this, you must specify a "release" name for their operator.

You can override the default configuration values in the operator Helm chart by doing one of the following:

- Creating a [custom YAML](https://github.com/oracle/weblogic-kubernetes-operator/blob/v2.5.0/kubernetes/charts/weblogic-operator/values.yaml) file containing the values to be overridden, and specifying the `--value` option on the Helm command line.
- Overriding individual values directly on the Helm command line, using the `--set` option.

Using the last option, simply define overriding values using the `--set` option.

Note the values:

* **name**: The name of the resource.
* **namespace**: Where the operator is deployed.
- **image**: The prebuilt operator 2.5.0 image, available on the public Docker hub.
- **serviceAccount**: The service account required to run the operator.
- **domainNamespaces**: The namespaces where WebLogic domains are deployed in order to control them. Note, the WebLogic domain is not deployed yet, so this value will be updated when namespaces are created for WebLogic deployment.
1.  Before you execute the operator `helm` install, make sure that you are in the operator's local Git repository folder.
  ```
  <copy>cd ~/weblogic-kubernetes-operator/</copy>
  ```
2.  Execute the following `helm install`:
  ```
  <copy>helm install sample-weblogic-operator \
    kubernetes/charts/weblogic-operator \
    --namespace sample-weblogic-operator-ns \
    --set image=oracle/weblogic-kubernetes-operator:2.5.0 \
    --set serviceAccount=sample-weblogic-operator-sa \
    --set "domainNamespaces={}"</copy>
  ```
3.  The output will be similar to the following:
  ```
  NAME: sample-weblogic-operator
  LAST DEPLOYED: Fri Mar  6 18:24:29 2020
  NAMESPACE: sample-weblogic-operator-ns
  STATUS: deployed
  REVISION: 1
  TEST SUITE: None
  ```
3.  Check the operator pod:
  ```
  <copy>kubectl get po -n sample-weblogic-operator-ns</copy>
  ```
  ```bash
  NAME                                READY   STATUS    RESTARTS   AGE
  weblogic-operator-86ff6fccc-gh79p   1/1     Running   0          69s
  ```
4.  Check the operator Helm chart:
  ```
  <copy>helm list -n sample-weblogic-operator-ns</copy>
  ```
  ```
  NAME                            NAMESPACE                       REVISION        UPDATED                                 STATUS          CHART                   APP VERSION
  sample-weblogic-operator        sample-weblogic-operator-ns     1               2020-03-06 18:24:29.312983566 +0000 UTC deployed        weblogic-operator-2.5.0
  ```

The WebLogic Server Kubernetes Operator has been installed. 

You may now **proceed to the next lab**.

## Acknowledgements
* **Author** - Sasanka Abeysinghe, August 2020
* **Last Updated By/Date** - Kay Malcolm, August 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.

# Install and configure Traefik  ###

## Before You Begin
### Objectives
- Prepare the Kubernetes cluster to run WebLogic domains.
- Update the Traefik load balancer and operator configuration.
- Deploy a WebLogic domain on Kubernetes.

### Introduction

Thus far on our journey from On-premises WebLogic Server to Oracle Container Engine for Kubernetes, we have created Oracle Container Engine for Kubernetes (OKE) on Oracle Cloud Infrastructure (OCI), installed and configured the WebLogic Kubernetes operator. Now we need to install and configure the Traefik.

This lab demonstrates how to install the [Traefik](https://traefik.io/) Ingress controller to provide load balancing for WebLogic clusters.

The Oracle WebLogic Server Kubernetes Operator supports three load balancers: Traefik, Voyager, and Apache. Samples are provided in the [documentation](https://github.com/oracle/weblogic-kubernetes-operator/blob/v2.5.0/kubernetes/samples/charts/README.md).

## Required Artifacts

- You should already have completed labs 1, 2, and 3 before beginning this lab.

- **Works better with the Chrome browser**.

## **STEP 1**: Install the Traefik operator with a Helm chart  


Change to your operator local Git repository folder.
```bash
<copy>cd ~/weblogic-kubernetes-operator/</copy>
```
Create a namespace for Traefik:
```bash
<copy>kubectl create namespace traefik</copy>
```
Install the Traefik operator in the `traefik` namespace with the provided sample values:
```bash
<copy>helm install traefik-operator \
stable/traefik \
--namespace traefik \
--values kubernetes/samples/charts/traefik/values.yaml  \
--set "kubernetes.namespaces={traefik}" \
--set "serviceType=LoadBalancer"</copy>
```

The output should be similar to the following:
```bash
NAME: traefik-operator
LAST DEPLOYED: Fri Mar  6 20:31:53 2020
NAMESPACE: traefik
STATUS: deployed
REVISION: 1
TEST SUITE: None
```

NOTES:
1. Get Traefik's load balancer IP/hostname:

     NOTE: It may take a few minutes for this to become available.

     You can watch the status by running:

        
        <copy>kubectl get svc traefik-operator --namespace traefik -w </copy>
        

     Once 'EXTERNAL-IP' is no longer **pending**:

        <copy>kubectl describe svc traefik-operator --namespace traefik | grep Ingress | awk '{print $3}'</copy>

2. Configure DNS records corresponding to Kubernetes ingress resources to point to the load balancer IP/hostname found in step 1


The Traefik installation is basically done. Verify the Traefik (load balancer) services:
```bash
<copy>kubectl get service -n traefik</copy>
```
```bash
NAME                         TYPE           CLUSTER-IP     EXTERNAL-IP      PORT(S)                      AGE
traefik-operator             LoadBalancer   10.96.227.82   158.101.24.114   443:30299/TCP,80:31457/TCP   2m27s
traefik-operator-dashboard   ClusterIP      10.96.53.132   <none>           80/TCP                       2m27s
```
Please note the EXTERNAL-IP of the **traefik-operator** service. This is the public IP address of the load balancer that you will use to access the WebLogic Server Administration Console and the sample application.

To print only the public IP address, execute this command:
```bash
<copy>kubectl describe svc traefik-operator --namespace traefik | grep Ingress | awk '{print $3}'</copy>
```
```bash
158.101.24.114
```

Verify the **helm** charts:
```bash
<copy>helm list -n traefik</copy>
```
```bash
NAME                    NAMESPACE       REVISION        UPDATED                                 STATUS          CHART           APP VERSION
traefik-operator        traefik         1               2020-03-06 20:31:53.069061578 +0000 UTC deployed        traefik-1.86.2  1.7.20  
```
You can also access the Traefik dashboard using `curl`. Use the `EXTERNAL-IP` address from the result above:
```bash
<copy>curl -H 'host: traefik.example.com' http://EXTERNAL_IP_ADDRESS</copy>
```

For example:
```bash
$ curl -H 'host: traefik.example.com' http://158.101.24.114
<a href="/dashboard/">Found</a>.
```
## Acknowledgements

- **Authors/Contributors** - 
- **Last Updated By/Date** - 
- **Workshop Expiration Date** - April 31, 2021

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.    Please include the workshop name and lab in your request.
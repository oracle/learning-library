# Install and configure Traefik

## Introduction

The Oracle WebLogic Server Kubernetes Operator supports three load balancers: Traefik, Voyager, and Apache. Samples are provided in the [documentation](https://github.com/oracle/weblogic-kubernetes-operator/blob/v3.0.0/kubernetes/samples/charts/README.md).

This tutorial demonstrates how to install the [Traefik](https://traefik.io/) Ingress controller to provide load balancing for WebLogic clusters.

Estimated Lab Time: 10 minutes

## **STEP 1**: Install the Traefik operator with a Helm chart


Create a namespace for Traefik:
```bash
<copy>kubectl create namespace traefik</copy>
```
Install the Traefik operator in the `traefik` namespace with the provided sample values:

```bash
<copy>helm repo add traefik https://helm.traefik.io/traefik</copy>
```

Get the value overrides from the github repository:
```bash
<copy>
curl -L -o traefik-values.yaml https://raw.githubusercontent.com/oracle/weblogic-kubernetes-operator/v3.0.0/kubernetes/samples/charts/traefik/values.yaml
</copy>
```

```bash
<copy>helm install traefik-operator \
traefik/traefik \
--namespace traefik \
--values traefik-values.yaml \
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
NOTES:
1. Get Traefik\'s load balancer IP/hostname:

     NOTE: It may take a few minutes for this to become available.

     You can watch the status by running:

         $ kubectl get svc traefik-operator --namespace traefik -w

     Once 'EXTERNAL-IP' is no longer '<pending>':

         $ kubectl describe svc traefik-operator --namespace traefik | grep Ingress | awk '{print $3}'

2. Configure DNS records corresponding to Kubernetes ingress resources to point to the load balancer IP/hostname found in step 1
```

The Traefik installation is basically done. Verify the Traefik (load balancer) services:
```bash
<copy>kubectl get service -n traefik</copy>
```
The output should be similar to the following:
```bash
NAME                         TYPE           CLUSTER-IP     EXTERNAL-IP       PORT(S)                      AGE
traefik-operator             LoadBalancer   10.96.50.120   129.146.148.215   443:31388/TCP,80:31282/TCP   48s
traefik-operator-dashboard   ClusterIP      10.96.206.52   <none>            80/TCP                       48s
```
Please note the EXTERNAL-IP of the *traefik-operator* service. This is the public IP address of the load balancer that you will use to access the WebLogic Server Administration Console and the sample application.

To print only the public IP address, execute this command:
```bash
<copy>kubectl describe svc traefik-operator --namespace traefik | grep Ingress | awk '{print $3}'</copy>
```
The output should be similar to the following:
```bash
129.146.148.215
```

Verify the `helm` charts:
```bash
<copy>helm list -n traefik</copy>
```
The output should be similar to the following:
```bash
NAME                    NAMESPACE       REVISION        UPDATED                                 STATUS          CHART           APP VERSION
traefik-operator        traefik         1               2020-09-03 13:50:09.199419556 +0000 UTC deployed        traefik-1.87.2  1.7.24
```

You may now **proceed to the next lab**.

## Acknowledgements
* **Author** - Maciej Gruszka, Peter Nagy, September 2020
* **Last Updated By/Date**

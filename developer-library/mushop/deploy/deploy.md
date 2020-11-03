# Deploy the MuShop Application

## Introduction

There are four options for deploying MuShop. They range from manual (docker), automated (Helm) to fully automated (Terraform).  

![MuShop Deployment](images/mushop-deploy-options-helm.png)

Designing in microservices offers excellent separation concerns and provides developer independence.  While these benefits are clear, they can often introduce some complexity for the development environment.  Services support configurations that offer flexibility, when necessary, and establish parity as much as possible.  It is essential to use the same tools for development to production.

![MuShop Deployment](images/mushop-diagram.png)  
*Note: This diagram contains services not covered by these labs.*

Estimated Lab Time: 30 minutes

### Objectives

In this lab, you will:

* Gather Cloud Information
* Download Source Code
* Setup OKE Cluster
* Deploy with Helm
* Explore under the Hood

### Prerequisites

* An Oracle Free Tier(Trial), Paid or LiveLabs Cloud Account

## **STEP 1**: Obtain MuShop source code

1. Open up Cloud Shell and clone the github repo.

    ````shell
    <copy>
    git clone https://github.com/oracle-quickstart/oci-cloudnative.git mushop
    </copy>
    ````

1. Change to the mushop directory

    ````shell
    <copy>
    cd mushop
    </copy>
    ````

    ![MuShop Tree](images/mushop-code.png)

    *./deploy:* Collection of application deployment resources  
    *./src:* MuShop individual service code, Dockerfile, etc

1. Check **kubectl** context

    ````shell
    <copy>
    kubectl config current-context
    # cluster-c4daylfgvrg
    </copy>
    ````

1. Set the default **kubectl** namespace to skip adding **--namespace _mushop_** to every command.  You can replace *mushop* with *your name*.

    ````shell
    <copy>
    kubectl create namespace mushop
    </copy>
    ````

    ````shell
    <copy>
    kubectl config set-context --current --namespace=mushop
    </copy>
    ````

## **STEP 2**: OKE Cluster Setup

MuShop provides an umbrella helm chart called setup, which includes several recommended installations on the cluster. These installations represent common 3rd party services, which integrate with Oracle Cloud Infrastructure or enable certain application features.

| Chart | Purpose | Option |
  | --- | --- | --- |
| [Prometheus](https://github.com/helm/charts/blob/master/stable/prometheus/README.md) | Service metrics aggregation | prometheus.enabled |
| [Grafana](https://github.com/helm/charts/blob/master/stable/grafana/README.md) | Infrastructure/service visualization dashboards | grafana.enabled |
| [Metrics Server](https://github.com/helm/charts/blob/master/stable/metrics-server/README.md) | Support for Horizontal Pod Autoscaling | metrics-server.enabled |
| [Ingress Nginx](https://kubernetes.github.io/ingress-nginx/) | Ingress controller and public Load Balancer | ingress-nginx.enabled |
| [Service Catalog](https://github.com/kubernetes-sigs/service-catalog/blob/master/charts/catalog/README.md) | Service Catalog chart utilized by Oracle Service Broker | catalog.enabled |
| [Cert Manager](https://github.com/jetstack/cert-manager/blob/master/README.md) | x509 certificate management for Kubernetes | cert-manager.enabled |  

1. Check kubectl context.

    ````shell
    <copy>
    kubectl config current-context
    </copy>
    ````

1. Create a namespace for MuShop utilities

    ````shell
    <copy>
    kubectl create namespace mushop-utilities
    </copy>
    ````

1. Install cluster dependencies using helm:

    ````shell
    <copy>
    helm dependency update deploy/complete/helm-chart/setup
    </copy>
    ````

1. Install setup helm chart:

    ````shell
    <copy>
    helm install mushop-utils deploy/complete/helm-chart/setup --namespace mushop-utilities
    </copy>
    ````

## **STEP 3**: Hostname Ingress and Deploy with Helm

Part of the cluster setup includes the installation of an nginx ingress controller. This resource exposes an OCI load balancer, with a public ip address mapped to the OKE cluster.

By default, the mushop helm chart creates an Ingress resource, routing ALL traffic on that ip address to the svc/edge component.

1. Locate the EXTERNAL-IP assigned to the ingress controller:

    ````shell
    <copy>
    kubectl get svc mushop-utils-ingress-nginx-controller --namespace mushop-utilities
    </copy>
    ````

    Sample response:

    ````shell
    NAME                                    TYPE           CLUSTER-IP      EXTERNAL-IP       PORT(S)                      AGE
    mushop-utils-ingress-nginx-controller   LoadBalancer   10.96.150.230   129.xxx.xxx.xxx   80:30195/TCP,443:31059/TCP   1m
    ````

## **STEP 4**: Hostname Ingress and Deploy with Helm

Remembering that helm provides a way of packaging and deploying configurable charts, next we will deploy the application in "mock mode" where cloud services are mocked, yet the application is fully functional

1. Deploy the application in "mock mode" where cloud services are mocked, yet the application is fully functional

    ````shell
    <copy>
    helm install mushop deploy/complete/helm-chart/mushop --set global.mock.service="all"
    </copy>
    ````

1. Please be patient. It may take a few moments to download all the application images.

    ````shell
    <copy>
    kubectl get pod --watch
    </copy>
    ````

1. After inspecting the resources created with helm install, launch the application in your browser using the **EXTERNAL-IP** from the nginx ingress.

1. Find the EXTERNAL-IP assigned to the ingress controller.  Open the IP address in your browser.

    ````shell
    <copy>
    kubectl get svc mushop-utils-ingress-nginx-controller --namespace mushop-utilities
    </copy>
    ````

You can complete the optional step or [proceed to the next lab](#next).

## **STEP 5**: (Optional) Under the Hood

1. To get a beter look at all the installed Kubernetes manifests by using the template command.

    ````shell
    <copy>
    mkdir ./out
    <copy>
    ````

    ````shell
    <copy>
    helm template mushop deploy/complete/helm-chart/mushop --set global.mock.service="all" --output-dir ./out
    <copy>
    ````

1. Explore the files, and see each output.

You may now [proceed to the next lab](#next).

## Acknowledgements

* **Author** - Adao Junior
* **Contributors** -  Kay Malcolm (DB Product Management), Adao Junior
* **Last Updated By/Date** - Adao Junior, October 2020

## Need Help?

Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.

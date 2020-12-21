# Functions

## Introduction

Adao, start updating here:

There are three options to deploying MuShop, they range from manual (docker) to automated (Helm).  

Designing in microservices offers excellent separation concerns and provides developer independence.  While these benefits are clear, they can often introduce some complexity for development environment.  Services support configurations that offer flexibility, when necessary, and establish parity as much as possible.  It is important to use the same tools for devleopment all the way to production.

![](images/mushop-deployment.png)

Estimated Lab Time: n minutes

### Objectives

In this lab, you will:
* Gather Cloud Information
* Download Source Code
* Setup OKE Cluster
* Deploy with Helm
* Explore under the Hood
* Clean up

### Prerequisites

* An Oracle Free Tier, Always Free, Paid or LiveLabs Cloud Account

## **STEP 1**: Obtain Oracle Cloud Information

1.  Create a txt file with the following values.  This step will walk you through how to obtain this information.
    - region:       # Region where resources will be provisioned. (ex: us-phoenix-1)
    - tenancy:      # Tenancy OCID value
    - user:         # API User OCID value
    - compartment:  # Compartment OCID value
    - key:          # Private API Key file path (ex: /Users/jdoe/.oci/oci_key.pem)
    - fingerprint:  # Public API Key fingerprint (ex: 43:65:2c...)

## **STEP 2**: Obtain Mushop source code

1.  Open up Cloud Shell and clone the github repo.

    ````
    <copy>
    git clone https://github.com/oracle-quickstart/oci-cloudnative.git mushop
    </copy>
    ````
2.  Change to the mushop directory
    ````
    <copy>
    cd mushop
    </copy>
    ````
    ![](images/mushop-code.png)

3.  Verify CLI is configured correctly by executing a command to list the Cloud Object Storage namespace
    ````
    <copy>
    oci os ns get
    </copy>
    ```` 
4.  Verify CLI is configured correctly by executing a command to list the Cloud Object Storage namespace
    ````
    <copy>
    oci ce cluster create-kubeconfig \
    --cluster-id ocid1.cluster.oc1.iad.aaaaaaaaabbbbbbbbdddddddd...xxx \
    --file $HOME/.kube/config --region us-ashburn-1 --token-version 2.0.0    
    </copy>
    ```` 
5.  Use kubectl to check the configuration
    ````
    <copy>
    kubectl config current-context
    # cluster-c4daylfgvrg
    </copy>
    ```` 
6.  Set the default kubectl namespace to skip adding --namespace <name> to every command.  You can replace *mushop* with *your name*
    ````
    <copy>
    kubectl create namespace mushop 
    kubectl config set-context \
    --current --namespace=mushop
    </copy>
    ```` 

    *TIP:* use kubens to switch namespace easily & often from the command line 

## **STEP 3**: OKE Cluster Setup
MuShop provides an umbrella helm chart called setup, which includes several recommended installations on the cluster. These installations represent common 3rd party services, which integrate with Oracle Cloud Infrastructure or enable certain application features.
|Chart|Purpose|Option|
[Prometheus](https://github.com/helm/charts/blob/master/stable/prometheus/README.md) 	Service metrics aggregation 	prometheus.enabled
[Grafana](https://github.com/helm/charts/blob/master/stable/grafana/README.md) 	Infrastructure/service visualization dashboards 	grafana.enabled
[Metrics Server](https://github.com/helm/charts/blob/master/stable/metrics-server/README.md) 	Support for Horizontal Pod Autoscaling 	metrics-server.enabled
[Ingress Nginx](https://kubernetes.github.io/ingress-nginx/) 	Ingress controller and public Load Balancer 	ingress-nginx.enabled
[Service Catalog](https://github.com/kubernetes-sigs/service-catalog/blob/master/charts/catalog/README.md) 	Service Catalog chart utilized by Oracle Service Broker 	catalog.enabled
1.  Check kubectl context.
    ```` 
    <copy>
    kubectl config current-context
    </copy>
    ```` 
1.  Create a namespace for MuShop utilities: 
    ```` 
    <copy>
    kubectl create namespace mushop-utilities
    </copy>
    ```` 
1.  Install cluster dependencies using helm: 
    ```` 
    <copy>
    helm dependency update deploy/complete/helm-chart/setup
    </copy>
    ```` 

## **STEP 4**: Hostname Ingress and Deploy with Helm

Part of the cluster setup includes the installation of an nginx ingress controller. This resource exposes an OCI load balancer, with a public ip address mapped to the OKE cluster.

By default, the mushop helm chart creates an Ingress resource, routing ALL traffic on that ip address to the svc/edge component. This is OK for simple scenarios, however it may be desired to differentiate ingress traffic, using host names on the same ip address. (for example multiple applications on the cluster) 

Configure the mushop helm chart ingress values in cases where traffic must be differentiated from one service to another: 
1.   Locate the EXTERNAL-IP assigned to the ingress controller: 

    ```` 
    <copy>
    kubectl get svc \
    mushop-utils-ingress-nginx-controller \
    --namespace mushop-utilities    
    </copy>
    ```` 
    Remembering that helm provides a way of packaging and deploying configurable charts, next we will deploy the application in "mock mode" where cloud services are mocked, yet the application is fully functional 

1.   Deploy the application in "mock mode" where cloud services are mocked, yet the application is fully functional 

    ```` 
    <copy>
    helm install mushop deploy/complete/helm-chart/mushop --set global.mock.service="all"
    </copy>
    ```` 
    *or*
    ```` 
    <copy>
    helm install mushop deploy/complete/helm-chart/mushop --set global.mock.service="all" --set ingress.hosts[0]="</copy>yourname.example.com"
    
    ```` 
1.  Please be patient. It may take a few moments to download all the application images. 
    ```` 
    <copy>
    kubectl get pod --watch
    </copy>
    ```` 
2.  After inspecting the resources created with helm install, launch the application in your browser. https://localhost

3.  Find the EXTERNAL-IP assigned to the ingress controller.  Open the IP address in your browser 
    ```` 
    <copy>
    kubectl get svc mushop-utils-ingress-nginx-controller --namespace mushop-utilities    
    </copy>
    ```` 
4.  Alternatively with kubectl configured on localhost.  Proxy to the MuShop app on http://localhost:8000 (or a port of your choice).  *NOTE:* For shared clusters, and host-based ingress, use the hostname you setup earlier. 
    ```` 
    <copy>
    kubectl port-forward svc/edge 8000:80
    </copy>
    ```` 

## **STEP 5**: Under the Hood
1.  To get a beter look at all the installed Kubernetes manifests by using the template command.
    ```` 
    <copy>
    mkdir ./out
    helm template mushop deploy/complete/helm-chart/mushop --set global.mock.service="all" --output-dir ./out
    <copy>
    ```` 
2.  Explore the files, and see each output. 

## **STEP 6**: Clean Up
1.  To get a beter look at all the installed Kubernetes manifests by using the template command.
    ```` 
    <copy>
    helm list
    </copy>
    ```` 
2.  Delete the mushop release
    ```` 
    <copy>
    helm delete mushop
    </copy>
    ````   

You may now [proceed to the next lab](#next).

## Acknowledgements
* **Author** - Adao Junior
* **Contributors** -  Kay Malcolm, DB Product Management
* **Last Updated By/Date** - October 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.

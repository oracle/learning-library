# Setup

## Introduction

In this lab we will provision and setup the resources to execute microservices in your tenancy.  

Estimates Lab Time - 20 minutes

### Objectives

* Clone the setup and microservices code
* Execute setup

### Prerequisites

* An Oracle Cloud paid account or free trial with credits. To sign up for a trial account with $300 in credits for 30 days, click [here](#previous).

Note, you will not be able to complete this workshop with the 'Always Free' account. Make sure that you select the free trial account with credits.

## **STEP 1**: Setup
    - Run `./setup-multicloud.sh` (takes ~20 minutes)
    - Takes CLUSTER_NAME as an argument 
    - This will install verrazzano, deploy workshop microservices, and provide URLs for the Frontend microservice and the consoles...
        - Grafana
        - Prometheus
        - Kibana
        - Elasticsearch
        - Rancher
        - KeyCloak
    - Example output...
    
        `FrontEnd HOST is frontend-helidon-appconf.msdataworkshop.129.146.227.229.nip.io`
        
        `    NAMESPACE         NAME                       CLASS    HOSTS                                                    ADDRESS          PORTS     AGE`
    
            cattle-system       rancher                    <none>   rancher.default.158.101.26.111.nip.io                    158.101.26.111   80, 443   37h
            keycloak            keycloak                   <none>   keycloak.default.158.101.26.111.nip.io                   158.101.26.111   80, 443   37h
            verrazzano-system   verrazzano-ingress         <none>   verrazzano.default.158.101.26.111.nip.io                 158.101.26.111   80, 443   37h
            verrazzano-system   vmi-system-es-ingest       <none>   elasticsearch.vmi.system.default.158.101.26.111.nip.io   158.101.26.111   80, 443   37h
            verrazzano-system   vmi-system-grafana         <none>   grafana.vmi.system.default.158.101.26.111.nip.io         158.101.26.111   80, 443   37h
            verrazzano-system   vmi-system-kibana          <none>   kibana.vmi.system.default.158.101.26.111.nip.io          158.101.26.111   80, 443   37h
            verrazzano-system   vmi-system-prometheus      <none>   prometheus.vmi.system.default.158.101.26.111.nip.io      158.101.26.111   80, 443   37h
            verrazzano-system   vmi-system-prometheus-gw   <none>   prometheus-gw.vmi.system.default.158.101.26.111.nip.io   158.101.26.111   80, 443   37h

## **STEP 2**: Walkthrough of consoles...



Once the setup has completed you are ready to [move on to Lab 3](#next).  Note, the non-java-builds.sh script may continue to run even after the setup has completed.  The non-Java builds are only required in Lab 3 and so we can continue with Lab 2 while the builds continue in the background.

## Acknowledgements

* **Authors** - Paul Parkinson, Developer Evangelist; Richard Exley, Consulting Member of Technical Staff, Oracle MAA and Exadata
* **Adapted for Cloud by** - Nenad Jovicic, Enterprise Strategist, North America Technology Enterprise Architect Solution Engineering Team
* **Documentation** - Lisa Jamen, User Assistance Developer - Helidon
* **Contributors** - Jaden McElvey, Technical Lead - Oracle LiveLabs Intern
* **Last Updated By/Date** - Richard Exley, April 2021

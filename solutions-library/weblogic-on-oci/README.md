# Move Custom WebLogic & Oracle DB Apps to Oracle Cloud Infrastructure

## Overview

This lab is part of Oracle Cloud Infrastructure's Move & Improve workshop series. This lab will walk you through the process of migrating an existing on-premises java application and database to OCI Weblogic Suite and DB System without having to modify the underlying configuration. The workshop utilizes OCI Marketplace image of Weblogic Database, Key Management/Vault. 

Attached below is a sample architecture of the final solution:
![](Architecture.png)

**The entire process may take 3 hours to complete, including provisioning time.**

## Objective

Perform the end-to-end migration of a local WebLogic domain to Oracle Cloud Infrastructure using provisioning with the OCI Marketplace.

- We'll start with a local WebLogic domain with an application backed by a local database, provisioned using Docker/docker-compose
- We'll prepare the OCI tenancy to provision WebLogic Server from the Marketplace, and perform the migration.
- We'll provision a new empty WebLogic domain on OCI with the Marketplace.
- We'll provision a database using the OCI DB as a service as the taregt to migrate the local application database.
- We'll migrate the local application database to the OCI DB as a service using DataPump, by backing up the local database schema, moving the files over to the DB provisioned on OCI and importing into it.
- Finally, we'll migrate the WebLogic domain using Weblogic Deploy Tooling (WDT). We'll discover the local domain, and after editing the model file to target the new domain, we'll update the new domain on OCI.


## Requirements

### 1) Software, credentials and accounts

- Docker installed locally to run the 'on-prems' environment.</br>
  Get Docker here: <a href="https://docs.docker.com/get-docker/" target="_blank">https://docs.docker.com/get-docker/</a>

- Docker Hub Account, to download necessary Docker images</br>
  Sign up here: <a href="https://hub.docker.com/signup" target="_blank">https://hub.docker.com/signup</a>

- Oracle Container Registry account</br>
  <a href="https://container-registry.oracle.com" target="_blank">https://container-registry.oracle.com</a>

- Oracle Cloud Infrastructure account, with proper credentials to create resources</br>
  <a href="https://www.oracle.com/cloud/free/" target="_blank">https://www.oracle.com/cloud/free/</a>

### 2) Get the code

**Download the source code required for this lab from** <a href="./weblogic-to-oci.zip" target="_blank">here</a></br>
or at <a href="https://github.com/oracle/learning-library/raw/master/developer-library/weblogic-to-oci/workshop/weblogic-to-oci.zip" target="_blank">https://github.com/oracle/learning-library/raw/master/developer-library/weblogic-to-oci/workshop/weblogic-to-oci.zip</a>

<!-- Or alternatively use the `git clone` command or the `Download` option to fetch the whole `learning-library` repository locally (~7GB)

<img src="./images/requirements-clone-or-download.png" width="100%"> -->

### 3) Fetch the private docker images:

This repository makes use of Oracle docker images which are licensed and need to be pulled after acknowledging the terms of the license.

- Sign in to Docker Hub and go to the Weblogic image area at:</br>
  <a href="https://hub.docker.com/_/oracle-weblogic-server-12c" target="_blank">https://hub.docker.com/_/oracle-weblogic-server-12c</a>
  
  - Click **Proceed to Checkout**
    then fill in your information, accept the terms of license, and click **Get Content**.

  - Then fetch the image: 

    ```bash
    <copy>
    docker pull store/oracle/weblogic:12.2.1.4
    </copy>
    ```

- Sign in to the **Oracle Container Registry** and accept the license terms for the Database image at:</br>
  <a href="https://container-registry.oracle.com/pls/apex/f?p=113:4:102331870967997::NO:::" target="_blank">https://container-registry.oracle.com/pls/apex/f?p=113:4:102331870967997::NO:::</a>

  - Then fetch the image:

    ```bash
    <copy>
    docker pull container-registry.oracle.com/database/enterprise:12.2.0.1
    </copy>
    ``` 

- Go to the **Instant Client** page and accept the license terms for the SQL Plus client at:</br>
  <a href="https://container-registry.oracle.com/pls/apex/f?p=113:4:103193800236962" target="_blank">https://container-registry.oracle.com/pls/apex/f?p=113:4:103193800236962</a>

  - Then fetch the image:

    ```bash
    <copy>
    docker pull store/oracle/database-instantclient:12.2.0.1
    </copy>
    ```






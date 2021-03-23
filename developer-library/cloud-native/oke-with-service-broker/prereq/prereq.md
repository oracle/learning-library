# Install pre-requisites

## Introduction

In this lab we will install the software required to run the stack to deploy an OKE cluster with OCI Service Broker.

Because the OCI Service Broker depends on Service Catalog, as well as etcd, all of which are deployed as Helm charts in kubernetes, we need kubectl, as well as helm installed to run the stack. Furthermore the OCI CLI is used for some tasks and is required for kubectl.

Estimated Lab Time: 10 minutes

### Objectives

In this lab you will:

- Install the OCI CLI
- Install kubectl >= 1.18 if not already present
- install Helm 3.x

## **STEP 1:** Install the OCI CLI

1. To install the OCI CLI on Linux or Mac OS X, run the command:

    ```bash
    <copy>
    bash -c "$(curl -L https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh)"
    </copy>
    ```

    Hit **enter** to use the defaults for all options.

2. Restart your shell
    ```
    <copy>
    exec -l $SHELL
    </copy>
    ```

3. Configure the OCI CLI

    ```
    <copy>
    oci setup config
    </copy>
    ```

    You will be prompted for:
    - Location of the config. Hit **Enter**
    - `user_ocid`: enter your user OCID
    - `tenancy_ocid`: enter your tenancy OCID
    - `region`: enter your region from the list provided.
    - Generate a RSA key pair: hit **Enter** for Yes (default)
    - Directory for keys: hit **Enter** for the default
    - name for the key: hit **Enter** for the default
    - Passphrase: hit **Enter** for no passphrase


    You should see an output like:

    ```bash
    Private key written to: /home/oracle/.oci/oci_api_key.pem
    Fingerprint: 21:d4:f1:a0:55:a5:c2:ce:e2:c6:88:4f:bf:2f:f3:af
    Config written to ~/.oci/config
    ```


4. Upload the public key to your OCI account

    In order to use the CLI, you need to upload the public key generated to your user account

    Get the key content with 

    ```
    <copy>
    cat ~/.oci/oci_api_key_public.pem
    </copy>
    ```

    or open the file with your prefered editor

    and copy the full printed output to clipboard

    In the OCI web console:

    - Under **User -> User Settings**
    - Click **API Keys**
    - Click **Add Public Key**
    - Click **Paste Public Key**
    - Paste the key copied above.
    - Click **Add**

    You can verify that the Fingerprint generated matches the fingerprint output of the config.

5. Test your CLI

    ```
    <copy>
    oci os ns get
    </copy>
    ```

    This command should output the namespace of your tenancy (usually the name of the tenancy or a randomized string)

    ```
    {
        "data": "your-tenancy-namespace"
    }
    ```

    Make a note of this name for later.

## **STEP 2:** Install `kubectl`

1. *If you are using Docker Desktop on Mac OS X or Windows, `kubectl` should already be installed, and you can skip the install step.*

2. To install `kubectl` run:

    ```bash
    <copy>
    PLATFORM=$(uname)
    curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/${PLATFORM}/amd64/kubectl"
    chmod +x ./kubectl
    sudo mv ./kubectl /usr/local/bin/kubectl
    </copy>
    ```

    On Windows use:

    ```bash
    <copy>
    curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.20.0/bin/windows/amd64/kubectl.exe
    </copy>
    ```

    and add the binary to your PATH

    For more detailed instructions, go to:
    [https://kubernetes.io/docs/tasks/tools/install-kubectl/](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

3. Make sure you have a recent version >= 1.18 with

    ```bash
    <copy>
    kubectl version --client
    </copy>
    ```

## **STEP 3:** Install Helm

1. To install helm on Mac OS X and linux, use:

    ```bash
    <copy>
    curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
    </copy>
    ```

    For more detailed instructions for your specific OS, go to:
    [https://helm.sh/docs/intro/install/](https://helm.sh/docs/intro/install/)

    
## **STEP 4:** Check you have OpenSSL

1. Make sure you have OpenSSL installed with

    ```bash
    <copy>
    openssl version
    </copy>
    ```

    and see if the command is found or fails. 

    It should be present by default on your machine.


You may proceed to the next lab.

## Acknowledgements

 - **Author** - Emmanuel Leroy, January 2021
 - **Last Updated By/Date** - Emmanuel Leroy, January 2021

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabs). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.

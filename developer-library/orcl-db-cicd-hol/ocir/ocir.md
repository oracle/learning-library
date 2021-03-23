# Push Docker Image to Registry (OCIR)

## Introduction

Before we can deploy our application with a CI/CD pipeline in Wercker, we need to push the image to a Docker repository. We will use the repository on Oracle Cloud Infrastructure Registry (OCIR) we created on Oracle Cloud, called [Your Initials]rep (small case, e.g. vltrep).

All information required for pushing and retrieving the built Docker image, deployment on OKE Container Cluster, and Oracle Database connection, will be stored in Wercker variables.

Our deployment will be monitored and managed using Kubernetes Dashboard.

## **Step 1:** Define Wercker Variables

In Wercker, we need to define three environment variables, in the **Environment** tab. Enter the name of the variable in Key field, the value in Value, set Protected or not, and click **Add**.

**DOCKER_USERNAME**

- format [cloud_tenant]/[cloud_username]
- e.g. ocitenantexp/scott.tiger@example.com

**DOCKER_PASSWORD**

- Generated Auth Token on Oracle Cloud 
- }dFhRabc999dfEa7e4:4
- Protected

**DOCKER_REPO**

- format [region].ocir.io/[cloud_tenant]/[registry_OCIR]
- e.g. eu-frankfurt-1.ocir.io/ocitenantexp/vltrep

All three variables must have a Delete button on the right side.

Now, the database connection details are hardcoded in our application. These details may change, so it is a good idea to add them as environment variables. Add these four variables in Wercker:

**DB_USER**

- hr

**DB_PASSWORD**

- WelCom3#2020_
- Protected

**DB_HOST**

- [Your Initials]-host.sub[Number].[Your Initials]vcn.oraclevcn.com

**DB_SERVICE**

- pdb01.sub[Number].[Your Initials]vcn.oraclevcn.com

## **Step 2:** Launch Web Service on Docker

We create a very small linux bash script that will start our web service application on the Docker container when deployed.

````
gedit promotion
````
Paste the following code, save, and close.

````
#!/usr/bin/env bash

# Set virtual environment
. ./activate_env

# Start application
python promotion.py "$@"
````

This script calls another script that activates the Python virtual environment on the Docker container when application is deployed. We need to add this script.

````
gedit activate_env
````

Paste the following code, save, and close.

````
#!/usr/bin/env bash

# Create a virtualenv if it doesn't already exist.
if [ ! -d orclvenv ]; then
	echo "Creating new virtualenv..."
    virtualenv orclvenv
else
	echo "Found an exisitng virtualenv..."
fi

# Activate the virtualenv
echo "Activating virtualenv..."
source orclvenv/bin/activate

# Attempt to install the required pip dependencies, then touch a file once done.
# If the file already exists only re-run the installation if the requirements file
# is newer than the touched file.
if [ ! -f orclvenv/installed -o requirements.pip -nt orclvenv/installed ]; then

    pip install -r requirements.pip

    if [ $? -ne 0 ]; then
        echo "Unable to install requirements. "
        exit 1
    fi

    touch orclvenv/installed
else
	echo "pip dependencies already installed..."
fi
````

This script verifies if Python dependencies in **requirements.pip** are installed, installs missing ones, and activates the virtual environment **orclvenv**. Make both scripts executables.

````
chmod a+x promotion activate_env
````

Now, we can add the Docker push image Step in **wercker.yml**. Add this step at the end of the file.

````
    # Step 4: push application in Docker image to OCIR 
    - internal/docker-push:
            entrypoint: ./promotion
            cmd: 0.0.0.0 8080
            env: "DB_USER=${DB_USER} DB_PASSWORD=${DB_PASSWORD} DB_HOST=${DB_HOST} DB_SERVICE=${DB_SERVICE}"
            working-dir: $WERCKER_ROOT
            tag: $WERCKER_GIT_COMMIT
            ports: "8080"
            username: $DOCKER_USERNAME
            password: $DOCKER_PASSWORD
            repository: $DOCKER_REPO
            registry: https://fra.ocir.io/v2
````

Add the scripts to the master branch, commit and push the changes to the code repository.

````
git add promotion
git add activate_env
git commit -a -m "Add docker push step"
git push
````

Verify the build is successful on Wercker console. Open Oracle Cloud console. Click on hamburger menu ≡, then Developer Services > **Registry (OCIR)**. Click on the repository called [Your Initials]rep. It has a Docker image with Size: 543.77 MB. This is not important, just wanted to show where your build is stored.

## **Step 3:** OCI CLI and Kubectl Configuration

Now we can use this build for the deploy pipeline. The deployment is performed on the Container Cluster (OKE) called [Your Initials]cluster we created. This cluster uses Kubernetes, and we need to configure **kubectl** on our development environment.

On Oracle Cloud console Click on hamburger menu ≡, then Developer Services > **Container Clusters (OKE)**. Click [Your Initials]cluster and **Access Cluster**. Click **Local Access**. We need to follow these steps to configure kubectl, and some more steps to create a missing folder and a config file.

````
oci -v

mkdir -p $HOME/.kube

mkdir -p $HOME/.oci
````

Run OCI setup.

````
oci setup config
````

Provide the requested values.

- Enter a location for your config [/home/oracle/.oci/config]: Enter
- Enter a user OCID: [User OCID] (e.g. ocid1.user.oc1..aa[some_long_string]xi5q)
- Enter a tenancy OCID: [Tenancy OCID] (e.g. ocid1.tenancy.oc1..aa[some_long_string]3gfa)
- Enter a region: eu-frankfurt-1
- Do you want to generate a new RSA key pair? n
- Enter the location of your private key file: /home/oracle/orcl-ws-cicd/keys/id_rsa

It returns a Fingerprint. Compare it with the Fingerprint you got when you generated the API Key and saved in your notes text file. It must be the same.

Create Kubectl configuration. This is the long command which is unique to every Container Cluster.

````
oci ce cluster create-kubeconfig --cluster-id ocid1.cluster.oc1.eu-frankfurt-1.aa[some_long_string]mu2d --file $HOME/.kube/config --region eu-frankfurt-1 --token-version 2.0.0

New config written to the Kubeconfig file /home/oracle/.kube/config
````

Export the location of kubectl configuration:

````
export KUBECONFIG=$HOME/.kube/config
````

Add this export to your .bash_profile by running this command:

````
printf "\nexport KUBECONFIG=$HOME/.kube/config" >> $HOME/.bash_profile
````

For the deployment, we need three variables: OKE_IMAGESECRET, OKE_MASTER, and OKE_TOKEN.

OKE_IMAGESECRET we create it, with a name we choose, e.g. ocirsecret. The creation requires [cloud_region], [cloud_tenant], [cloud_username], generated Auth Token [auth_token] all from Oracle Cloud. And the email address for your account on Docker Hub [docker_email]. 

This is the command we have to run - copy it in your notes file, and change the values with the correct ones:

````
kubectl create secret docker-registry [secret_name] --docker-server=[cloud_region].ocir.io --docker-username='[cloud_tenant]/[cloud_username]' --docker-password='[auth_token]' --docker-email='[docker_email]'
````

E.g.

````
kubectl create secret docker-registry ocirsecret --docker-server=eu-frankfurt-1.ocir.io --docker-username='ocitenantexp/scott.tiger@example.com' --docker-password='}dFhRabc999dfEa7e4:4' --docker-email='scott.tiger@email.com'

secret/ocirsecret created
````

Write in your notes text file the value of OKE_IMAGESECRET: ocirsecret.

On Oracle Cloud console, navigate to hamburger menu ≡, then Developer Services > **Container Clusters (OKE)**. Click [Your Initials]cluster, and copy the value of **Kubernetes Address**. This is the value of OKE_MASTER, write it in your notes text file, adding 'https://' in front of it, if it doesn't start with.

## **Step 4:** Kubernetes Dashboard

Next step is to define an OKE administrator service account and a cluster role binding, both called oke-admin. For the definition we can use a YML file, **oke-admin-service-account.yaml**, already cloned from GitHub. This is the definition:

````
apiVersion: v1
kind: ServiceAccount
metadata:
  name: oke-admin
  namespace: kube-system
---
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRoleBinding
metadata:
  name: oke-admin
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: oke-admin
  namespace: kube-system
````

Create the OKE service account and the cluster role binding in your cluster by running:

````
kubectl apply -f oke-admin-service-account.yaml
````

You can now use the oke-admin service account to view and control the cluster, and to connect to the Kubernetes Dashboard. Obtain an authentication token for the oke-admin service account using the following command: 

````
kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep oke-admin | awk '{print $1}')
````

Write in your notes text file the value of this token, just the sting, without [token:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;] in front of it. This is the value of OKE_TOKEN.

Launch Kubernetes Dashboard on your development environment, and give it a few minutes to start.

````
kubectl proxy &

Starting to serve on 127.0.0.1:8001
````

Hit Enter to get back control of the compute instance. Now we have the three variables required for the deployment. Add these three variables in Wercker:

**OKE_IMAGESECRET**

- ocirsecret

**OKE_MASTER**

- looks line a URL or IP address and a port number
- e.g. https://123.123.123.123:6443 or https://some-name.eu-fra-1.clst.oci.orclcld.com:6443

**OKE_TOKEN**

- [about-10-rows-long-string]
- Protected

On your laptop browser, navigate to [http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/#!/login](http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/#!/login)

Select Token, and enter the value of OKE_TOKEN, Sign In. This is Kubernetes Dashboard. In Overview, under Services, we have one service called **kubernetes**. Under Secrets, there are two secrets: **ocirsecret** and a default one called default-token-[code].

Test you can deploy a simple application on your OKE Cluster. Make sure there are no deployments now.

````
kubectl get deployments
No resources found in default namespace.
````

Deploy a sample application on your OKE Cluster.

````
kubectl create deployment kubernetes-bootcamp --image=gcr.io/google-samples/kubernetes-bootcamp:v1
deployment.apps/kubernetes-bootcamp created
````

List deployments to check if the sample application was deployed successfully.

````
kubectl get deployments
NAME                  READY   UP-TO-DATE   AVAILABLE   AGE
kubernetes-bootcamp   1/1     1            1           19s
````

## Acknowledgements

- **Author** - Valentin Leonard Tabacaru
- **Last Updated By/Date** - Valentin Leonard Tabacaru, Principal Product Manager, DB Product Management, May 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.


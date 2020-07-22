# CI-CD Examples

## Introduction
In this section, there are 3 CI/CDs examples implemented for both Github and Gitlab.

These examples are split into:
* Packer example that builds a custom image having everything prepared for running Thunder code (it will also generate the provider.auto.tfvars file). Based on that image, an instance will be created in OCI.
* Docker example that build an image having everything prepared for running Thunder and also creates a pod in an existing kubernetes cluster based on that image
* Ansible example that imitates a dev/prod scenario


## Packer

This CI/CD solution should be used in 2 steps - it has 2 workflows (pipelines) as follows:

`Create image for Github (/.github/workflows/create_image.yml) or Create Image Stage Gitlab (.gitlab-ci.yml ) that:`
  ```
  - is triggered by a pull_request for master branch
  - builds the oci config using secrets that you need to set
  - validates the packer files from the repo
  - launches the packer build that will create your custom image in OCI and save the image_ocid in a text file
  - installs OCI CLI and fixes file permissions
  - creates OCI bucket and copies the text file with the image ocid to it (to be fetched and used by next workflow)
  ```
`Create instance for Github (/.github/workflows/create_instance.yml) or Create Instance Stage Gitlab (.gitlab-ci.yml) that:`
  ```
  - is triggered by a push to master branch
  - builds the oci config file and key files using repo secrets
  - installs OCI CLI and fixes file permissions
  - downloads the text file containing the image ocid from OCI bucket created in previous workflow
  - creates an instance from the image built on previous workflow with Packer
  - gives instance principal permissions to the newly created instance by creating a dynamic group, adding instance to dynamic group, creating policy for dynamic group giving appropriate permissions
  - builds the provider.auto.tfvars file using repo secrets and copies it on the instance to thunder repository which is already cloned on the instance 
  - deletes the OCI bucket
  ```

### Prerequisites

First you need to have in place your Packer solution for building a custom image - please check the [example](https://github.com/oracle/learning-library/tree/master/solutions-library/infrastructure-automation/thunder/examples/custom_images) from our [learning library public repo](https://github.com/oracle/learning-library). 

So your git repo should contain the following files:
- packer-variables.json 
- oci-packer.json
- install-tools.sh


### Workflow
 
The way this CI/CD is intended to work is when you need to make modifications to the customization of the image that you want to create using Packer you need to create a new branch and modify the *install_tools.sh* file.

The next step is to create a pull request from your branch to master - when you create the pull request, the *Create image* workflow is triggered and a custom image will be created in OCI.

After the pull request is reviewed and approved, when it is merged into the master branch the next workflow *Create instance* is triggered that creates an OCI instance from the custom image.

Now all you need to do is ssh into the instance and start running your terraform code.

### Github Secrets / Gitlab Variables

In order for the workfows to run properly you need to configure some secrets for **GITHUB** (repo -> settings -> secrets) or some variables for **GITLAB** (repo -> settings -> CI/CD -> Variables) as follows:
- OCI\_API\_KEY - the .pem OCI key used in config file
- VM\_SSH\_PUB\_KEY - public key used for creating instance
- VM\_SSH\_PRIVATE\_KEY - private key to be used for ssh-ing into the instance
- OCI_FINGERPRINT - user fingerprint for config file
- OCI_REGION - the OCI region where to deploy
- OCI\_TENANCY\_OCID - the ocid of your tenancy
- OCI\_USER\_OCID - the ocid of your user
- VM\_AVAILABILITY\_DOMAIN - ex. *TenancyIdentifier:US-ASHBURN-AD-1*
- VM\_COMPARTMENT\_OCID - the ocid of your compartment
- VM_SHAPE - the shape for the instance that will be created from the custom image

### You will also have to modify the packer-variables in order to reflect your tenancy:
```
{
  "oci_availability_domain": "US-ASHBURN-AD-1",
  "oci_compartment_ocid": "ocid1....",
  "oci_subnet_ocid": "ocid1.subnet...",
  "image_id": "ocid1.image...",
  "region": "us-ashburn-1",
  "image_name": "myfirstpackerimage",
  "source_script": "./install-tools.sh",
  "fingerprint": "16...",
  "user": "ocid1.user...",
  "tenancy": "ocid1.tenancy...",
  "key_file": "/home/runner/.oci/oci_api_key.pem",
  "shape": "VM.Standard2.1"
}
```

### Notes
- Please make sure that the dynamic group name and the policy name you choose to use in the *Create instance* workflow yaml are unique (there is no dynamic group or policy with the same name already existing)
- Please make sure also that the instance name and bucket name are unique (that you can configure in *Create instance* workflow yaml
- OCI CLI commands from the instance should be used with instance principal authentication:
  - run command on instance *export OCI\_CLI\_AUTH=instance_principal* OR
  - use *--auth instance_principal* at the end of every OCI CLI command
- The workflows run on a host provided by GitHub / Gitlab that terminates after the workflow is complete
- Make sure that Gitlab variables are unprotected


## Docker

By using this example, you will have a working CI/CD pipeline using Github or Gitlab CI/CD for Docker. This Pipeline will create a docker image that will have everything prepared for running Thunder and it will deploy it in an existing kubernetes cluster in a pod.

### Prerequisites
You will need to Create an OCIR auth key by loggin in to Oracle Cloud Infrastructure Registry from the Docker CLI
Follow the steps described in the link (first 4 steps are required):
https://www.oracle.com/webfolder/technetwork/tutorials/obe/oci/registry/index.html

### Github Secrets / Gitlab Variables
You will have to define the secrets (Github) / variables (Gitlab) in order to be able to run the build.
- OKE_REGISTRY - The OKE Registry in which you want to push the image
- OKE\_REGISTRY\_IMAGE - The image that will be built on the runner
- OKE\_REGISTRY\_NEW\_IMAGE - The name of the image that will be built on the runner and pushed on the server
- OKE\_REGISTRY\_USER - The user used for logging in to OKE Registry
- OKE\_REGISTRY\_PASSWORD - The password used for logging in to OKE Registry
- API_KEY - the .pem OCI key used in config file
- FINGERPRINT - user fingerprint for config file
- REGION - the OCI region where to deploy
- TENANCY_OCID - the ocid of your tenancy
- USER_OCID - the ocid of your user
- CLUSTER_ID - the ocid of your OKE cluster ID in which the pod will be created based on the image
- CLUSTER_REGION - The region in which the OKE cluster resides

After you have everything in place, by creating your own repository and having all the prerequisites defined, you can easily trigger a build.

## Ansible

By using this example, you will have a working CI/CD pipeline using Github or Gitlab CI/CD for Ansible.
There are two roles defined at the moment, one for webservers and one for installing MariaDB. These plays are running on existing OEL7 instances mimicking a dev and a production environment.
On merge request, the Ansible plays will run directly on the dev instances, and when you are merging the code into the master branch, everything will run on the production instances. This is similar with what happens in a real production environment when you are using a CI/CD pipeline.

You will have to create your own gitlab / github repository based on this code.

### Prerequisites

You will need to have the dev and prod instances up and running already and have the private ssh keys for connecting to those instances. For simplicity, the same key was used for connecting to all of those instances. 

You will need to add for **Github** as a secret the ssh private key and the ssh public key that can be used to connect to the instances with the following variables:

```
PUBLIC_SSH_KEY
PRIVATE_SSH_KEY
```

* **Gitlab** will need the private key as a variable and should be marked as unprotected, in order to avoid having problems with the key. The variable should be `ssh_private_key`

The key must be in PEM format.
If you have a key in openssh format, you can simply convert it to PEM with the following command:
`ssh-keygen -p -N "" -m pem -f /path/to/key`


In addition to this, you will have to define the hosts file accordingly by putting the public_ip / dns records of those instances in the hosts file.

The hosts file will look like this:
```
[devwebservers]
140.yyy.yyy.yyy

[devdbservers]
152.yyy.yyy.yyy

[prodwebservers]
152.yyy.yyy.yyy

[proddbservers]
152.yyy.yyy.yyy
```

After you have everything in place, by creating your own repository and having all the prerequisites defined, you can easily trigger a dev or a prod build.


## Triggering a Dev Build
To trigger the developement build, you will first have to create a new branch from the master branch

`git checkout -b branch_name`

Modify a file and add it to the origin branch
```
Change file
git add .
git commit -m 'Your commit message'
git push origin branch_name
```

You will now have to create a pull request, and when you are doing this, the dev build will trigger. You can click on it, in order to look at what is happening.

## Triggering a Prod Build
After a pull request is merged into the master branch, the production build will trigger.

[NOT RECOMMENDED] You can also trigger a prod build, by:
```
Change file
git add .
git commit -m 'Your commit message'
git push origin master
```

This is not recommended due to the fact that you will push the code directly into the master branch.


## Known Issues
There are no known issues at the moment
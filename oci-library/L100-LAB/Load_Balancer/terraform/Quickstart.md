# Software tools for working in OCI

## oci-cli

There is an official [command line interface for OCI][oci-cli].

Since it's written in python, you can use a familiar, traditional, python-virtualenv-based approach:

```shell
python3 -m venv venv
source venv/bin/activate
pip install oci-cli
oci --version
```

Usage docs for [oci-cli][cli-doc].
[jq][jq] is convenient for filtering the output.

[oci-cli]: https://github.com/oracle/oci-cli
[cli-doc]: https://docs.cloud.oracle.com/iaas/Content/API/Concepts/cliconcepts.htm
[jq]: https://stedolan.github.io/jq/

## OCI provider for Terraform


There is an official [terraform provider for oci][tf-oci].
From the [documentation][tf-oci-doc]:

> To use the latest OCI Terraform Provider, version 3, run terraform init on the directory that contains the configuration referencing the configuration block, `provider "oci" {.`


[tf-oci]: https://github.com/terraform-providers/terraform-provider-oci
[tf-oci-oci]: https://www.terraform.io/docs/providers/oci/guides/version-3-upgrade.html

# Configuration

You will need to know:

* tenancy OCID
* user OCID
* region

You should create an [API Signing key][api-key] and calculate its fingerprint.
Then you can create a configuration file in `~/.oci/config` that looks somewhat like (ling lines truncated):

```
[DEFAULT]
user=ocid1.user.oc1..aaaaaaaaugrwccij6pil....
fingerprint=64:a5:42:3e:ec:a4:e2:62:88:5c:94:7e:64:15:22:6c
tenancy=ocid1.tenancy.oc1..aaaaaaaaw52ltaall....
key_file=~/.ssh/dhutty-cloud-architect.rsa
region=us-phoenix-1
```

At this point you should be able to list the names of the OCI Resource types that your version of the API supports with:

```
oci search resource-type list | jq '.data[].name'
```

[api-key]: https://docs.cloud.oracle.com/iaas/Content/API/Concepts/apisigningkey.htm

# Usage

```shell
terraform plan
terraform show
```

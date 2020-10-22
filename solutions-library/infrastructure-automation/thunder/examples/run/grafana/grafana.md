# Grafana automation

## Introduction
This project will build Grafana environment using terraform automation.

## Prerequisites
  * Terraform v0.12.13 or greater <https://www.terraform.io/downloads.html/>
  * OCI Provider for Terraform v3.11 or greater <https://github.com/oracle/terraform-provider-oci/releases>
  * VCN already exists (Public Subnet, Route Table, Internet Gateway)

## Deployment
Follow the instructions from Prerequisites links in order to install terraform and oci provider for Terraform:

  * Install terraform and terraform-provider-oci -> sudo yum install terraform terraform-provider-oci –y

You will have to generate an API signing key (public/private keys) and the public key should be uploaded in the OCI
console, for the iam user that will be used to create the resources. Also, you should make sure that this user has
enough permissions to create resources in OCI. In order to generate the API Signing key, follow the steps
from: <https://docs.us-phoenix-1.oraclecloud.com/Content/API/Concepts/apisigningkey.htm#How>
The API signing key will generate a fingerprint in the OCI console, and that fingerprint will be used in a terraform
file described below.

In addition to this, you are required to generate a ssh key for the user the will run the scripts.

You will have to generate a terraform provider configuration as follows:

```
provider_oci = {
  tenancy       = "The id of the tenancy"
  user_id       = "The id of the user"
  key_file_path = "The path to the oci api private key created in the Deployment section"
  fingerprint   = "The fingerprint of the above key"
  region        = "The region in which you want to spawn grafana instance"
}
```

## Grafana

This module creates an instance, a dynamic group and an instance principal. It is also installing and configuring Grafana to use oci datasource. Grafana is using the OCI Metrics dashboard in order to be able to monitor the different component from OCI.

After you run the code, you will need to import the dashboard from */dashboards* folder manually.
To do this you need to:
* connect to the grafana instance by using the **grafana_connection_url** output
* use admin/admin as the credentials
* click on the + button located on the left bar and click import.
* copy and paste the content from */dashboards/oci_dashboard.json* and upload it
* Select *oci* datasource to be used for the dashboard.
* [If required] if the variables don't display any value you need to go to variables section from dashboard settings and turn on and off the include all option and save the changes. After doing this the variables will be refreshed and you will be able to select different compartments/regions.


The variables for this module are described bellow:

*instance_params*

  * ad (the availability domain of the instance)
  * shape (the shape of the instance)
  * hostname (the hostname of the instance)
  * assign\_public\_ip (set to true in order to have a public ip, false otherwise)
  * boot\_volume\_size (the boot volume size of the instance's boot volume)
  * source_type (should be set to image)
  * source_id (the image ocid)
  * preserve\_boot\_volume (set to 1 if you want to preserve the boot volume after the instance deletion, 0 otherwise)
  * subnet_id (a public subnet where instance will be created - the security lists needs to have port 3000 opened)
  * compartment_id (compartmend ocid where the instance will be created)

*ssh\_public\_key* - the public ssh key path used for connecting to the instance

*ssh\_private\_key* - the private ssh key path used for connecting to the instance

*home_region* - Home region for tenancy

*instance\_principal\_params*

* dg_description (The description of the dynamic group)
* dg_name (The name of the dynamic group)
* policy_description (The description of the policy)
* policy_name (The name of the policy)


### Running the code


Go to thunder->examples->run->grafana of the repository:

```
# Run init to get terraform modules
$ terraform init

# Run the plan command to see what will happen.
$ terraform plan --var-file=path_to_provider.auto.tfvars

# If the plan looks right, apply it.
$ terraform apply --var-file=path_to_provider.auto.tfvars

# If you are done with this infrastructure, take it down
$ terraform destroy
```


## Known issues
**At the moment, there are no known issues**

## Utils
[Grafana on OCI](https://grafana.com/blog/2019/02/25/oracle-cloud-infrastructure-as-a-data-source-for-grafana/)

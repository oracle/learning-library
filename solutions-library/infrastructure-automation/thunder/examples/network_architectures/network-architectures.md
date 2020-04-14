# Network Architectures

## Introduction
This segment of the framework provides a standard baseline for best practices around networking architecture. These three (for now) models will provide a great starting point for enterprise customers who are looking to prep their business for OCI. 

## N-Tier Webapp Architecture

Components within the legacy application or SOA pattern can be tiered in multiple ways. Starting with the 2-Tier Application, a customer may have a single server, or multiple servers handling requests of the application presentation, business, and persistence to that are connected to a stand-alone database.

![N-Tier Webapp Architecture](./img/n-tier.png)

## SaaS Isolated Architecture

 Network isolation ensures that the applications and data are segregated from the other deployments in the tenancy.

![SaaS Isolated Architecture](./img/isv-Isolated-Arch.png)

## SaaS Shared Architecture

This ensures that the applications and data are segregated from the other deployments in separate subnets with different security lists and access. This can be achieved using the peering functionality having the hub VCN peered to separate tenant subnets. This patterns generally mapped as a baseline for providing customer management and control (cmc2) across the network

![SaaS Shared Architecture](./img/isv-shared-arch.png)


All the phases will need an oci provider which can be defined in the terraform.tfvars or *.auto.tfvars file in every component and the values must reflect your OCI tenancy:
```
provider_oci = {
  tenancy       = ""
  user_id       = ""
  fingerprint   = ""
  key_file_path = ""
  region        = ""
}
```

## Running the code

In order to run the code, you will simply have to go to the directory containing the desired architecture you want to create (e.g **thunder/examples/network_architectures/saas\_isolated\_arch**) and do the following:

```
# Run init to get terraform modules
$ terraform init

# Create the infrastructure
$ terraform apply --var-file=path_to_provider.auto.tfvars_file

# If you are done with this infrastructure, take it down
$ terraform destroy --var-file=path_to_provider.auto.tfvars_file
```

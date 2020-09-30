# Enterprise Tier Resources

## Introduction
In this example, all the resources from crawl and walk are instantiated.
You have full flexibility on provisioning the resources from here (you can scale anything up or down, modify resources parameters), just by modifying the **terraform.tfvars** files as explained in the crawl/walk examples.
There are no other external variables in this example.

Don't forget to populate the provider with the details of your tenancy as specified in the prerequisites lab.

## Tips
All of the components from crawl and walk are in this example. You may want to use just some pieces from this example and you can easily do that.
There are 10 modules that are instantiated in this example:
- IAM 
- Network
- ADW
- DBaaS
- Compute Instances
- DNS
- FSS
- Instance Principal
- Load Balancer
- Object Storage

There are 2 ways in which you can avoid creating resources from a specific module:
- Comment out in **main.tf** from your example, the module that creates your resource and in **outputs.tf** from your example any reference to that module.
- Another way would be to identify the parameters of your module, and remove from **terraform.tfvars** all the data from those parameters, keeping an empty map for all of those parameters.

When you are removing a module, you should take a look at its dependencies. 
For example, let's say you want to remove **IAM** from here. All of the other modules, have dependencies to IAM at their respective **compartment_ids** params:

```
module "network" {
  source           = "../../modules/network"
  ------------------------------------------
  compartment_ids  = module.iam.compartments
  ------------------------------------------
}
```

In order to keep this solution working, you will have to create a new variable with a name of your choice for the compartments in the example's **variables.tf** file (e.g. compartment_ids), add its values to the example's **terraform.tfvars**. 
In the **main.tf**, you will have to add the new variable at the network level.

```
module "network" {
  source           = "../../modules/network"
  ------------------------------------------
  compartment_ids  = var.compartment_ids
  ------------------------------------------
}
```

All of the components work on this principle.

## Running the code

In order to be able to spin up the enterprise tier resources, you will have to navigate to **thunder -> examples -> enterprise_tier**.

```
# Run init to get terraform modules
$ terraform init

# Create the infrastructure
$ terraform apply --var-file=path_to_provider.auto.tfvars_file

# If you are done with this infrastructure, take it down
$ terraform destroy --var-file=path_to_provider.auto.tfvars_file
```

# Oracle Cloud Adoption Frameworks

Crawl, walk, run framework leverages our experiences and best practices in assisting ISV organizations around the world adopting OCI. This project is open source and maintained by Oracle Corp. 

In the span of a few days or hours, the code examples provided here establish an easy to understand path to gaining operational proficiency in OCI, including the vast majority components required to build and operate your software. Use as little or as much as you find useful here to shorten your time to market, we welcome the collaboration.

Both of the solutions are building infrastructure automations and they are based mostly on terraform. All of the modules developed in these automations are generic, having no hardcoded variables in the module code. Everything can be easily modified by changing the specific **terraform.tfvars** file of the example that you are going to run. 


## [Lightning](./lightning/README.md)
Lightning is an OCI resource manager based framework. It is meant for Proof of Concepts, helping customers get familiar with OCI faster.
There are 2 resource manager stacks (zip archives) in this framework: 
- **free_tier** (containing the always free components that can be deployed in OCI)
- **enterprise_tier** (containing IAM, Network, Compute, Load Balancers, Block & Object Storage, ADW/ATP, DNS, File System Service)
For more details on how to run the stacks, click on the title.

### [Click for Lightning Workshop](https://oracle.github.io/learning-library/solutions-library/infrastructure-automation/lightning/workshop/index.html)

## [Thunder](./thunder/README.md)
Thunder is a Terraform/Python based framework containing multiple examples on how to quickly spin up different components in OCI. It is meant for both production environments and proof of concepts, due to the fact that is fully customizable. 

Before starting with the frameworks, you will need to:
* Install Terraform (v0.12.15+) 
* Install Python (v3.6+)
* Gather your tenancy details 

There is also a partner image in OCI (Oracle Cloud Developer Image), that will have the prerequisites already installed (you will still need to gather your tenancy details).
For more details on how to run the different components, click on the title.

### [Click for Thunder Workshop](https://oracle.github.io/learning-library/solutions-library/infrastructure-automation/thunder/workshop/index.html)

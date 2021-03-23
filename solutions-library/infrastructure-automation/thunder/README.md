# Oracle ISV Thunder Cloud Adoption Framework

This crawl, walk, run framework leverages our experiences and best practices in assisting
ISV organizations around the world adopting OCI. This project is open source and maintained by Oracle Corp.

In the span of a few days or hours, the code examples provided here establish an easy to understand path to gaining operational proficiency in OCI, including the vast majority components required to build and operate your software. Use as little or as much as you find useful here to shorten your time to market, we welcome the collaboration.

Why bother with creating all the infrastructure manually, or creating all the terraform code from scratch when the only thing that you will have to modify in order to achieve the desired infrastructure is a **terraform.tfvars** file?

>***DISCLAIMER:***: The code examples provided here are not an alternative to training/enablement activities or reviewing the [OCI documentation](https://docs.cloud.oracle.com/iaas/Content/home.htm). Users are expected to be comfortable operating on the linux command line and have familiarity with Public Cloud concepts and tools including [Terraform](https://github.com/hashicorp/terraform), [Python](https://www.python.org/), and [Ansible](https://github.com/ansible/ansible).


## Dependencies

- OCI Tenancy
- Workstation with Terraform installed or quickly spin up [Oracle Cloud Developer Image](https://cloudmarketplace.oracle.com/marketplace/en_US/listing/54030984) from OCI Marketplace **_available directly through Console_**


## Getting Started

Before working through the examples, set up a config file with the required credentials on your Workstation or Instance described in Dependencies. See [SDK and Tool Configuration](https://docs.us-phoenix-1.oraclecloud.com/Content/API/Concepts/sdkconfig.htm) for instructions.

The examples are organized as follows:

| Type      | Description | Components    |
| :----:       |    :----:   |   :----: |
| Crawl     | Independent examples for OCI's basic resources       | adw_atp, dbaas, iam, instances, network  |
| Walk      | Independent examples for OCI's advanced resources       | dns, fss, instance-principal, load-balancer, object-storage  |
| Free Tier      | Contains the always free components       | 1 Instance, 1 LB, 1 Network, 1 ATP, 1 Object Storage Bucket  |
| Enterprise Tier      | Starting point for all automations       | Contains all crawl and walk terraform components  |
| Run      | Different examples that may help you get proficient experience on OCI.       | backup-restore, glusterfs, grafana, start-stop, asg, remote-peering, kms, waas, fss-redudancy  |
| Network Architectures      | Contains network architecture examples       | N Tier Web App, SaaS Isolated/Shared  |
| Custom Images      | Contains custom images examples       | Packer OCI/Non-OCI builder images, move images from region 1 to region 2  |
| Developer Tools      | Contains developer tools examples       | OKE, API Gateway, Functions, Marketplace Instances  |
| CI CD      | CI/CD Examples for Github and Gitlab | Packer, Ansible, Docker based solutions  |


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

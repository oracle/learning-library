# Lab Introduction and Overview #

## Thunder

This crawl, walk, run framework leverages our experiences and best practices in assisting
ISV organizations around the world adopting OCI. This project is open source and maintained by Oracle Corp.

In the span of a few days or hours, the code examples provided here establish an easy to understand path to gaining operational proficiency in OCI, including the vast majority components required to build and operate your software. Use as little or as much as you find useful here to shorten your time to market, we welcome the collaboration.

Why bother with creating all the infrastructure manually, or creating all the terraform code from scratch when the only thing that you will have to modify in order to achieve the desired infrastructure is a **terraform.tfvars** file?

Solutions in this framework are split between multiple examples containing both terraform and python automations.
The examples are organized as follows:


| Type      | Description | Components    |
| :----:       |    :----:   |   :----: |
| Crawl      | Independent examples for OCI's basic resources       | adw_atp, dbaas, iam, instances, network  |
| Walk      | Independent examples for OCI's advanced resources       | dns, fss, instance-principal, load-balancer, object-storage  |
| Free Tier      | Contains the always free components       | 1 Instance, 1 LB, 1 Network, 1 ATP, 1 Object Storage Bucket  |
| Enterprise Tier      | Starting point for all automations       | Contains all crawl and walk terraform components  |
| Run      | Different examples that may help you get proficient experience on OCI.       | backup-restore, glusterfs, grafana, start-stop, asg, remote-peering, kms, waas, fss-redudancy  |
| Network Architectures      | Contains network architecture examples       | N Tier Web App, SaaS Isolated/Shared  |
| Custom Images      | Contains custom images examples       | Packer OCI/Non-OCI builder images, move images from region 1 to region 2  |
| Developer Tools      | Contains developer tools examples       | OKE, API Gateway, Functions, Marketplace Instances  |
| CI CD      | CI/CD Examples for Github and Gitlab | Packer, Ansible, Docker based solutions  |


## Acknowledgements

**Authors/Contributors** - Flavius Dinu, Ionut Sturzu, Ionut Irimia, Cristian Cozma, Marius Ciotir, Sorin Ionescu, Laura Paraschiv, Bogdan Darie, Emanuel Grama, Travis Mitchell, Thomas Liakos

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

<table>
  <tr>
    <th width="10">Type</th>
    <th width="200">Description</th>
    <th width="10">C1</th>
    <th width="10">C2</th>
    <th width="10">C3</th>
    <th width="10">C4</th>
    <th width="10">C5</th>
    <th width="10">C6</th>
    <th width="10">C7</th>
    <th width="10">C8</th>
  </tr>
  <tr>
    <td><a href=./examples/enterprise_tier/enterprise-tier.md>enterprise_tier</td>
    <td>Contains all terraform components</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
  </tr>
  <tr>
    <td><a href=./examples/free_tier/free-tier.md>free_tier</td>
    <td>Contains the always free components</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
  </tr>
  <tr>
    <td>crawl</td>
    <td>The crawl is just getting the basics set up in OCI. How do I establish the basic building blocks needed for my journey?</td>
    <td><a href=./examples/crawl/adw/adw.md>adw_atp</td>
    <td><a href=./examples/crawl/dbaas/dbaas.md>dbaas</td>
    <td><a href=./examples/crawl/iam/iam.md>iam</td>
    <td><a href=./examples/crawl/instances/compute.md>instances</td>
    <td><a href=./examples/crawl/network/network.md>network</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
  </tr>
  <tr>
    <td>walk</td>
    <td>When you're looking to walk, the way you want to think about it is: In the crawl stage, you've established the foundations in the environment, now you're ready to start introducing components and concepts to take advantage of scale.</td>
    <td><a href=./examples/walk/dns/dns.md>dns</td>
    <td><a href=./examples/walk/fss/fss.md>fss</td>
    <td><a href=./examples/walk/instance-principal/instance-principal.md>instance-principal</td>
    <td><a href=./examples/walk/load-balancer/load-balancer.md>load-balancer</td>
    <td><a href=./examples/walk/object-storage/object-storage.md>object-storage</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
  </tr>
  <tr>
    <td>run</td>
    <td>Now as you move on to the run, you're ready to start visualizing what your application will look like in OCI and designing your Architecture. You can also think through what your operating model will look like.</td>
    <td><a href=./examples/run/backup-restore/backup-restore.md>backup-restore</td>
    <td><a href=./examples/run/glusterfs/glusterfs.md>glusterfs</td>
    <td><a href=./examples/run/grafana/grafana.md>grafana</td>
    <td><a href=./examples/run/start-stop/start-stop.md>start-stop</td>
    <td><a href=./examples/run/asg/asg.md>asg</td>
    <td><a href=./examples/run/remote-peering/remote-peering.md>remote-peering</td>
    <td><a href=./examples/run/kms/kms.md>kms</td>
    <td><a href=./examples/run/waas/waas.md>waas</td>
  </tr>
  <tr>
    <td><a href=./examples/network_architectures/network-architectures.md>network architectures</td>
    <td>Contains network architecture examples</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
  </tr>
  <tr>
    <td><a href=./examples/custom_images/custom-images.md>custom images</td>
    <td>Contains custom images examples</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
  </tr>
</table>

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

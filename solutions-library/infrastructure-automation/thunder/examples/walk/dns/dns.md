# DNS Examples


## Introduction

The Oracle Cloud Infrastructure Domain Name System (DNS) service lets you create and manage your DNS zones. You can create zones, add records to zones, and allow Oracle Cloud Infrastructure's edge network to handle your domain's DNS queries.

## Description

The terraform module uses the following variables:

* Zone Parameters
    * compartment_name - The name of the compartment
    * zone_name - The name of the zone
    * zone_type - The type of the zone (PRIMARY or SECONDARY)
    * external_masters - External master servers for the zone. externalMasters becomes a required parameter when the zoneType value is SECONDARY
      * ip - The ip of the external master

* DNS Records Params
    * zone_name - The name of the zone
    * domain - The domain of the record type
    * rtype - The record type (e.g A)
    * ttl - The Time To Live for the record, in seconds.
    * use_instance - If it is set to true, you will use an instance from the list of instances as a dns record
    * instance\_name - Set it to the name of the instance if use\_instance is true, otherwise set it to null
    * use_lb - If it is set to true, you will use a load balancer from the list of load balancers as a dns record
    * lb\_name - Set it to the name of the load balancer if use\_lb is true, otherwise set it to null
    * rdata - If use\_instance and use\_lb are set to false, you can provide a manual input for rdata

## Dependencies
Apart from the **provider.auto.tfvars**, there may be some other dependencies in the **terraform.tfvars** file that you will have to address.
All the dependencies from this section should have resources that already exist in OCI.

### Compartment Dependency
In order to be able to run the sample code, you will have to prepare a map variable (like in the **terraform.tfvars** file) called **compartment\_ids**, which will hold key/value pairs with the names and ids of the compartments that you want to use.
This variable will be external in order to offer multiple ways of linking them from a terraform perspective.

```
compartment_ids = {
  sandbox = "ocid1.compartment.oc1..aaaaaaaaiu3vfcpbjwwgpil3xakqts4jhtjq42kktmisriiszdvvouwsirgq"
}
```

### Instance Dependency
In order to be able to run the sample code, you will have to prepare a map variable (like in the **terraform.tfvars** file) called **private\_ip\_instances**, which will hold key/value pairs with the names and private_ips of the instances that you want to use.
This variable will be external in order to offer multiple ways of linking them from a terraform perspective.

```
private_ip_instances = {
  hur1 = "10.0.1.3"
}
```

### Load Balancer Dependency
In order to be able to run the sample code, you will have to prepare a map variable (like in the **terraform.tfvars** file) called **load\_balancer\_params**, which will hold key/value pairs with the names, lb_ids and comp_ids of the load_balancers that you want to use.
This variable will be external in order to offer multiple ways of linking them from a terraform perspective.

```
load_balancer_params = {
  hur-lb = {
    lb_id              = "ocid1.loadbalancer.oc1.eu-frankfurt-1.aaaaaaaah24kceloiufpn7qffdcqmtjcmfykubempro5ial2ihti26ubhyzq"
    comp_id            = "ocid1.compartment.oc1..aaaaaaaaiu3vfcpbjwwgpil3xakqts4jhtjq42kktmisriiszdvvouwsirgq"
  }
}
```

## Example

In the example, the following components are created:
  * two zones (one primary, one secondary)
  * three records (one based on the instances list, one based on the load balancer list, one based on manual input)

A list of instances is given in this example and based on those instances, records can be created. The same thing is happening for the load balancers, where you have to set a load balancer list containing also the compartment id in order to be able to get the load balancers.

```
compartment_ids = {
  sandbox = "ocid1.compartment.oc1..aaaaaaaaiu3vfcpbjwwgpil3xakqts4jhtjq42kktmisriiszdvvouwsirgq"
}
instances = {
  hur1 = "10.0.1.3"
}

load_balancer_params = {
  hur-lb = {
    lb_id              = "ocid1.loadbalancer.oc1.eu-frankfurt-1.aaaaaaaah24kceloiufpn7qffdcqmtjcmfykubempro5ial2ihti26ubhyzq"
    comp_id            = "ocid1.compartment.oc1..aaaaaaaaiu3vfcpbjwwgpil3xakqts4jhtjq42kktmisriiszdvvouwsirgq"
  }
}
zone_params = {
  "hur1.com" = {
    compartment_name  = "sandbox"
    zone_name         = "hur1.com"
    zone_type         = "PRIMARY"
    external_masters  = []
  }
  "hur2.com" = {
    compartment_name = "sandbox"
    zone_name        = "hur2.com"
    zone_type        = "SECONDARY"
    external_masters = [
      {
        ip = "2.2.2.2"
      },
      {
        ip = "1.1.1.1"
      },
    ]
  }
}

dns_records_params = {
  "primary1.hur1.com" = {
    zone_name         = "hur1.com"
    domain            = "primary1.hur1.com"
    rtype             = "A"
    ttl               = 300
    rdata             = null
    use_instance      = true
    instance_name     = "hur1"
    use_lb            = null
    lb_name           = null
  }
  "primary2.hur1.com" = {
    zone_name         = "hur1.com"
    domain            = "primary2.hur1.com"
    rtype             = "A"
    ttl               = 300
    rdata             = null
    use_instance      = false
    instance_name     = null
    use_lb            = true
    lb_name          = "hur-lb"
  }
  "primary3.hur1.com" = {
    zone_name         = "hur1.com"
    domain            = "primary3.hur1.com"
    rtype             = "A"
    ttl               = 300
    rdata             = "1.1.1.1"
    use_instance      = false
    instance_name     = null
    use_lb            = false
    lb_name           = null
  }
}
```

This is just an example, but the number of the resources can be increased/decreased to suit any needs.

Don't forget to populate the provider with the details of your tenancy as specified in the main README.md file.


## Running the code

Go to **thunder/examples/walk/dns**
```
# Run init to get terraform modules
$ terraform init

# Create the infrastructure
$ terraform apply --var-file=path_to_provider.auto.tfvars

# If you are done with this infrastructure, take it down
$ terraform destroy --var-file=path_to_provider.auto.tfvars
```


## Useful links
[DNS Zone Management](https://docs.cloud.oracle.com/iaas/Content/DNS/Concepts/dnszonemanagement.htm)

[Terraform DNS Zone](https://www.terraform.io/docs/providers/oci/r/dns_zone.html)

[Terraform DNS Record](https://www.terraform.io/docs/providers/oci/r/dns_record.html)
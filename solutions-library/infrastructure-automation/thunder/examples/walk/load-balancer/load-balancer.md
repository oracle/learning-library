# Load balancer

## Introduction

The Oracle Cloud Infrastructure Load Balancing service provides automated traffic distribution from one entry point to multiple servers reachable from your virtual cloud network (VCN). The service offers a load balancer with your choice of a public or private IP address, and provisioned bandwidth.

## Description

This module will create multiple load balancers, listeners, certificates, path routes, virual hostnames, backend sets and backends.
The following parameters are supported:

* Load balancer parameters
    * shape - The shape of the load balancer (e.g 100MBps)
    * compartment_name - The name of the compartment in which the load balancer will be created
    * subnet_name - A list of subnet names in which the load balancer will be created
    * display_name - The name of the load balancer
    * is_private - Whether or not the load balancer is private

* Backend sets
    * name - The name of the backend set
    * lb_name - The name of the load balancer
    * policy - The policy of the load balancer (e.g ROUND_ROBIN)
    * hc_port - Healthcheck port
    * hc_protocol - Healthcheck protocol 
    * hc_response - Healthcheck response in ms
    * hc_url - Healthcheck url

* Listeners 
    * lb_name - The name of the load balancer
    * hostname_names - The hostname names for virtual hostnames if used (set it to null if you do not want to use hostnames)
    * name - The name of the listener
    * backend\_set\_name - The name of the backend set
    * port - The port of listener
    * protocol - The protocol of the listener
    * path\_route\_set - The path route set if sued (set it to null if you do not want to use path route)
    * ssl
      * cert_name - The name of the certificate
      * verify\_cert\_peer - Whether to very the peer cert or not
  
* backend_params
    * backendset_name - The name of the backend set
    * use_instance - Whether to use the instance as a backend. If set to false, it will use a load balancer as backend
    * instance_name - The name of the instance if used (if not can be set to any number)
    * lb_name - The name of the load balancer if used (if not can be set to any number)
    * port - The port of the backend
    
* path\_route\_sets 
    * lb_name - The name of the load balancer
    * name - The name of the path route
    * routes
      * path - The path string to match against the incoming URI path.
      * match\_type - The type of matching to apply to incoming URIs (e.g EXACT\_MATCH)
      * backend_set - The name of the backend set

* virtual_hostnames 
    * hostname - The hostname of the virtual hostname
    * name - The name of the virtual hostname
    * lb_name - The name of the load balancer

* certificates
    * name - The name of the certificate
    * lb_name - The index of the load balancer
    * private_key - path to the private key
    * public_certificate - path to the public certificate
    * passphrase - The passphrase of the certificate

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

### Subnet Dependency
In order to be able to run the sample code, you will have to prepare a map variable (like in the **terraform.tfvars** file) called **subnet\_ids**, which will hold key/value pairs with the names and ids of the subnets that you want to use.
This variable will be external in order to offer multiple ways of linking them from a terraform perspective.

```
subnet_ids = {
  hur1pub  = "ocid1.subnet.oc1.eu-zurich-1.aaaaaaaapejshjhsljycynokehdhw47oh4vhp2rlakzudnlp5by6gsg6jzfa"
  hur1priv = "ocid1.subnet.oc1.eu-zurich-1.aaaaaaaamcf3qooqlrsoycjkegvqlet2gt3hbrsnurxjj2wezmjs3jhzke6q"
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

## Example

In the example, the following components are created:
* One load balancer
* One listener
* One backend set
* One backend


In the example from below, there is a list of compartments containing 1 element. By setting in lb\_params `compartment_name` to sandbox, The load balancer elements will be created the sandbox compartment `ocid1.compartment.oc1..aaaaaaaaiu3vfcpbjwwgpil3xakqts4jhtjq42kktmisriiszdvvouwsirgq`. The same thing is happening for the subnet_ids and instances. All lists can be extended in order to satisfy your needs.

```
private_ip_instances = {
  hur1 = "10.0.1.3"
}

compartment_ids = {
  sandbox = "ocid1.compartment.oc1..aaaaaaaaiu3vfcpbjwwgpil3xakqts4jhtjq42kktmisriiszdvvouwsirgq"
}

subnet_ids = {
  hur1pub = "ocid1.subnet.oc1.eu-frankfurt-1.aaaaaaaaka6k2tp7dtasvyp7rly4ypevudwtahtoozsumjnazjl52xpbsrpq"
}

lb_params = {
  "hur-lb" = {
    shape            = "100Mbps"
    compartment_name = "sandbox"
    subnet_names     = ["hur1pub"]
    display_name     = "hur-lb"
    is_private       = false
  }
}

backend_sets = {
  "hur1-bs" = {
    name        = "hur1-bs"
    lb_name     = "hur-lb"
    policy      = "ROUND_ROBIN"
    hc_port     = 80
    hc_protocol = "HTTP"
    hc_url      = "/"
  }
}

listeners = {
  "hur-list" = {
    lb_name          = "hur-lb"
    name             = "hur-list"
    backend_set_name = "hur1-bs"
    port             = 80
    protocol         = "HTTP"
    ssl              = []
  }
}

backend_params = {
  "hur1-bs" = {
    backendset_name = "hur1-bs"
    use_instance    = true
    instance_name   = "hur1"
    lb_name         = "hur-lb"
    port            = 80
    lb_backend_name = ""
  }
}

certificates = {}
```

This is just an example and everything can be up/down scaled.
Don't forget to populate the provider with the details of your tenancy as specified in the main README.md file.

## Running the code

Go to **thunder/examples/walk/load-balancer**
```
# Run init to get terraform modules
$ terraform init

# Create the infrastructure
$ terraform apply --var-file=path_to_provider.auto.tfvars

# If you are done with this infrastructure, take it down
$ terraform destroy --var-file=path_to_provider.auto.tfvars
```


## Useful links
[Load Balancer Overview](https://docs.cloud.oracle.com/iaas/Content/Balance/Concepts/balanceoverview.htm)

[Terraform Load Balancer](https://www.terraform.io/docs/providers/oci/r/load\_balancer\_load\_balancer.html)
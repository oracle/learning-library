# AutoScaling Group Examples

## Introduction

Autoscaling enables you to automatically adjust the number of Compute instances in an instance pool based on performance metrics such as CPU utilization. This helps you provide consistent performance for your end users during periods of high demand, and helps you reduce your costs during periods of low demand.

## Description

The ASG module is able to create instance configurations, instance pools and autoscaling group configurations.

* Auto Scaling Group parameters
    * compartment_name - The compartment name in which the asg components will be created
    * name - The name of the asg components
    * freeform_tags - The freeform tags for the asg
    * shape - The shape of the asg
    * assign\_public\_ip - Whether or not to assign a public ip to the asg instances (to assing a public ip, the asg instances should be in a public subnet)
    * ssh\_public\_key - The path to ssh public key
    * hostname - The hostname used for the asg
    * size - The size of the boot volume in GBs
    * state - The state of the asg (can be RUNNING or STOPPED)
    * p_config - The placement configuration (can be repeated multiple times. In order to spread the instances between 2 ads, you should have at least 2 rules for 2 different ads.)
      * ad - The ad in which auto scaling should spawn instances
      * subnet - The subnet name in which auto scaling should spawn instances
    * lb\_config - If you want to place the instances from asg behind a load balancer (if you don't the lb\_config should be an empty list -> [])
      * backend\_set\_name - The name of the backend set in which you want to place the asg instances
      * lb_name - The name of the load balancer that should contain the instances
      * lb_port - The port on which the traffic will be balanced
    * policy_name - The name of the asg policy
    * initial_capacity - The initial capacity of asg instances (1, 2, 3..., etc)
    * max_capacity - The maximum number of asg instances
    * min_capacity - The minimum number of asg instances
    * policy_type - The type of policy that should be used by autoscaling configuration
    * rules - The list of rules for the autoscaling configuration
      * rule_name - The name of the rule
      * action_type - The action Type
      * action_value - The action value (Negative number for scale down. Positive number for Scale up)
      * metrics - The list of metrics for the rules
        * metric_type - The type of metric to be used
        * metric_operator - Metric operator (GT, GTE, LT, LTE)
        * threshold_value - The threshold value
    * cool\_down\_in\_seconds - cool down in seconds
    * is\_autoscaling\_enabled - Whether or not autoscaling is enabled

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

### Load balancer Dependency
In order to be able to run the sample code, you will have to prepare a map variable (like in the **terraform.tfvars** file) called **load\_balancer\_ids**, which will hold key/value pairs with the names and ids of the load balancers that you want to use.
This variable will be external in order to offer multiple ways of linking them from a terraform perspective.
By default, this variable will have no load balancer attached, but if you want to add the asg behind the load balancer you will have to add name/id pairs for this.
```
load_balancer_ids = {}
```

### Backend Set Dependency
In order to be able to run the sample code, you will have to prepare a map variable (like in the **terraform.tfvars** file) called **backend\_set\_ids**, which will hold key/value pairs with the names and ids of the backend sets that you want to use.
This variable will be external in order to offer multiple ways of linking them from a terraform perspective.
By default, this variable will have no backend sets attached, but if you want to add the asg behind the load balancer you will have to add name/id pairs for this.
```
backend_set_ids = {}
```

## Example
In the provided example, the following resources are created: 
* 1 Autoscaling Group
  
.
In the example from below, there is a list of compartments containing 1 elements and a list of subnets containing 2 elements. By setting in compute\_params `compartment_name` to sandbox, the instances will be created in the sandbox compartment `ocid1.compartment.oc1..aaaaaaaaiu3vfcpbjwwgpil3xakqts4jhtjq42kktmisriiszdvvouwsirgq`. The same thing is happening to subnet\_ids, backend\_sets and load\_balance\r_ids. All lists can be extended in order to satisfy your needs.


The example is based on terraform.tfvars values:

```
compartment_ids = {
  sandbox = "ocid1.compartment.oc1..aaaaaaaaiu3vfcpbjwwgpil3xakqts4jhtjq42kktmisriiszdvvouwsirgq"
}
subnet_ids      = {
  hur1pub  = "ocid1.subnet.oc1.iad.aaaaaaaa2c7arzk7ur3vaaom44erjti6bcot2ihd4ikokkoens7mxnwfzcba"
  hur1priv = "ocid1.subnet.oc1.eu-zurich-1.aaaaaaaaqmrzegawxhx3lem554otznorygybovk7a5ek5i75opbwv7kvo6yq"
}

images = {
  ap-mumbai-1    = "ocid1.image.oc1.ap-mumbai-1.aaaaaaaa46gx23hrdtxenjyt4p5cc3c4mbvyiqxcb3mmrxnmjn3rfxgvqcma"
  ap-seoul-1     = "ocid1.image.oc1.ap-seoul-1.aaaaaaaavwjewurl3nvcyq6bgpbrapk4wfwu6qz2ljlrj2yk3cfqexeq64na"
  ap-sydney-1    = "ocid1.image.oc1.ap-sydney-1.aaaaaaaae5qy5o6s2ve2lt4aetmd7s4ydpupowhs6fdl25w4qpkdidbuva5q"
  ap-tokyo-1     = "ocid1.image.oc1.ap-tokyo-1.aaaaaaaa54xb7m4f42vckxkrmtlpys32quyjfldbkhq5zsbmw2r6v5hzgvkq"
  ca-toronto-1   = "ocid1.image.oc1.ca-toronto-1.aaaaaaaagupuj5dfue6gvpmlzzppvwryu4gjatkn2hedocbxbvrtrsmnc5oq"
  eu-frankfurt-1 = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaa3bu75jht762mfvwroa2gdck6boqwyktztyu5dfhftcycucyp63ma"
  eu-zurich-1    = "ocid1.image.oc1.eu-zurich-1.aaaaaaaadx6lizhaqdnuabw4m5dvutmh5hkzoih373632egxnitybcripb2a"
  sa-saopaulo-1  = "ocid1.image.oc1.sa-saopaulo-1.aaaaaaaa3ke6hsjwdshzoh4mtjq3m6f7rhv4c4dkfljr53kjppvtiio7nv3q"
  uk-london-1    = "ocid1.image.oc1.uk-london-1.aaaaaaaasutdhza5wtsrxa236ewtmfa6ixezlaxwxbw7vti2wyi5oobsgoeq"
  us-ashburn-1   = "ocid1.image.oc1.iad.aaaaaaaaox73mjjcopg6damp7tssjccpp5opktr3hwgr63u2lacdt2nver5a"
  us-langley-1   = "ocid1.image.oc2.us-langley-1.aaaaaaaaxyipolnyhfw3t34nparhtlez5cbslyzbvlwxky6ph4mh4s22zmnq"
  us-luke-1      = "ocid1.image.oc2.us-luke-1.aaaaaaaa5dtevrzzxk35dwslew5e6zcqljtfu5hzolcedr467gzuqdg3ls5a"
  us-phoenix-1   = "ocid1.image.oc1.phx.aaaaaaaauuj2b3bvpbtpcyrfdvxu7tuajrwsmajhn6uhvx4oquecap63jywa"
}

backend_sets      = {}
load_balancer_ids = {}

asg_params = {
  asg1 = {
    compartment_name = "sandbox"
    name             = "asg1"
    freeform_tags    = {}
    shape            = "VM.Standard2.1"
    assign_public_ip = "true"
    ssh_public_key   = "/root/.ssh/id_rsa.pub"
    hostname         = "asg1"
    size             = 2
    state            = "RUNNING" # Can be RUNNING or STOPPED
    p_config         = [
      {
        ad     = 1
        subnet = "hur1pub"
      },
      {
        ad     = 2
        subnet = "hur1pub"
      },
      {
        ad     = 3
        subnet = "hur1pub"
      }
    ]
    lb_config        = []
    initial_capacity = 2
    max_capacity     = 6
    min_capacity     = 2
    policy_name      = "asg_policy"
    policy_type      = "threshold"
    rules            = [
      {
        rule_name    = "scaleUp"
        action_type  = "CHANGE_COUNT_BY"
        action_value = 2
        metrics      = [
          {
            metric_type     = "CPU_UTILIZATION"
            metric_operator = "GT"
            threshold_value = 70
          }
        ]
      },
      {
        rule_name    = "scaleDown"
        action_type  = "CHANGE_COUNT_BY"
        action_value = -1
        metrics      = [
          {
            metric_type     = "CPU_UTILIZATION"
            metric_operator = "LT"
            threshold_value = 30
          }
        ]
      }
    ]
    cool_down_in_seconds   = 300
    is_autoscaling_enabled = true
  }
}

```

This is just an example, but the number of the resources can be increased/decreased to suit any needs by adding another map in the specific resource type.

Don't forget to populate the provider with the details of your tenancy as specified in the main README.md file.

## Running the code

Go to **thunder/examples/run/asg**

```
# Run init to get terraform modules
$ terraform init

# Create the infrastructure
$ terraform apply --var-file=path_to_provider.auto.tfvars

# If you are done with this infrastructure, take it down
$ terraform destroy --var-file=path_to_provider.auto.tfvars
```

## Useful Links
[Autoscaling Instance Pools](https://docs.cloud.oracle.com/en-us/iaas/Content/Compute/Tasks/autoscalinginstancepools.htm)

[Creating Instance Pools](https://docs.cloud.oracle.com/en-us/iaas/Content/Compute/Tasks/creatinginstancepool.htm)

[Creating Instance Configuration](https://docs.cloud.oracle.com/en-us/iaas/Content/Compute/Tasks/creatinginstanceconfig.htm)
# How to use Crawl and Walk Examples

## Introduction

All of the examples from crawl and walk work on the same principle.
In both of these folders there are independent examples for different OCI Components.

## Code Walkthrough 
After setting up the **provider.auto.tfvars**, you will have to check out the **terraform.tfvars** files for each of the examples in crawl and walk.
In all of these examples, there will be some external dependencies, that you will have to fill in.

The network example, will have a dependency to a compartment resource.
In the below examples, there are 2 vcns created **hur1** and **hur2** in a compartment called **sandbox** which already existed before running this code. 

```
compartment_ids = {
  sandbox = "ocid1.compartment.oc1..aaaaaaaaiu3vfcpbjwwgpil3xakqts4jhtjq42kktmisriiszdvvouwsirgq"
}

vcn_params = {
  hur1 = {
    compartment_name = "sandbox"
    display_name     = "hur1"
    vcn_cidr         = "10.0.0.0/16"
    dns_label        = "hur1"
  }
  hur2 = {
    compartment_name = "sandbox"
    display_name     = "hur2"
    vcn_cidr         = "11.0.0.0/16"
    dns_label        = "hur2"
  }
}
```

You will have to change the **compartment_ids** variable to something that reflects your tenancy, and do the changes to the vcn resources in order to have them created in the correct compartments.

Let's suppose you already have 2 compartments (**comp1** and **comp2**) and you want to create 2 vcns (**vcnA**, **vcnB**) in **comp1** and 1 vcn (**vcnC**) in **comp2**.
Due to the fact that compartments are external to this example, you will have to go the console, and get the ids for **comp1** and **comp2** and add them to the **compartment_ids** variable. Let's suppose the id for **comp1** is **ocid1.compartment.oc1..aaaaaaaacomp1** and for **comp2** is **ocid1.compartment.oc1..aaaaaaaacomp2**.

The **compartment_ids** variable will look like this:
```
compartment_ids = {
  comp1 = "ocid1.compartment.oc1..aaaaaaaacomp1"
  comp2 = "ocid1.compartment.oc1..aaaaaaaacomp2"
}
```

You will also have to change the **vcn_params** in order to reflect the creation of 3 vcns instead of 2, with the correct mappings to comp1 and comp2 and the name change.

```
vcn_params = {
  vcnA = {
    compartment_name = "comp1"
    display_name     = "vcnA"
    vcn_cidr         = "10.0.0.0/16"
    dns_label        = "vcnA"
  }
  vcnB = {
    compartment_name = "comp1"
    display_name     = "vcnB"
    vcn_cidr         = "11.0.0.0/16"
    dns_label        = "vcnb"
  }
  vcnC = {
    compartment_name = "comp2"
    display_name     = "vcnC"
    vcn_cidr         = "12.0.0.0/16"
    dns_label        = "vcnc"
  }
}
```

All the mappings between all the resources are made by name and all of them will have a parameter that does the linking. All the names of a resource type (e.g vcn), should be unique, in order to be able to spin them up and make the links with other resources.
Everything can be easily scaled up, just by adding another map in the params of the resources you are interested in (as you've seen in the example above).

Some of these independent examples will have more than one external variable, but all of them are easily spotted at the beginning of their corresponding README.md file.


### Running the Code

There are examples for both **crawl** and **walk** phases. Each component will have its own section on how to run the code, and you will find it at the end of the lab.

### Crawl 

Crawl consists of different components. In order to access the labs you can [click here](https://oracle.github.io/learning-library/solutions-library/infrastructure-automation/thunder/examples/crawl/crawl-workshop/index.html?lab=lab-1-crawl-intro)
The available components in crawl are:
- IAM
- Network
- ADW
- DBaaS
- Compute Instances

### Walk

Walk consists of different components. In order to access the labs you can [click here](https://oracle.github.io/learning-library/solutions-library/infrastructure-automation/thunder/examples/walk/walk-workshop/index.html?lab=lab-1-walk-intro)


The available components in walk are:
- DNS
- FSS
- Instance Principal
- Load Balancer
- Object Storage


In each of these components, you will find examples on how to modify the **terraform.tfvars** file and how to run the code after achieving your desired infrastructure.
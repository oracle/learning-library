# DbaaS Examples

## Introduction
DBaaS extends the Oracle Private Cloud Management solution by automating the lifecycle of a database and allowing users to request database services through self-service portal.

## Description

The DbaaS module is able to create VM and BareMetal DbaaS.

Parameters
  * compartment_name - The compartment name in which the DB will be created
  * subnet_name - The name of the subnet in which the DB will be created
  * ad - The availability domain number in which the DB will be created
  * cpu\_core\_count - The number of CPUs for the DB
  * db\_edition - The DB edition (can be STANDARD\_EDITION, ENTERPRISE\_EDITION, ENTERPRISE\_EDITION\_HIGH\_PERFORMANCE, ENTERPRISE\_EDITION\_EXTREME\_PERFORMANCE)
  * db_name - The name of the database
  * db\_admin\_password - The admin password of the DB
  * db_workload - The workload of the database
  * pdb_name - The name of the pdb
  * enable\_auto\_backup - Whether you want auto backups or not
  * db_version - The version of the DB (11.2.0.4, 12.1.0.2, 12.2.0.1)
  * display_name - The display name of the database system
  * disk_redudancy - The disk redundancy
  * shape - The shape of the database 
  * ssh\_public\_key - The path to the ssh public key which will be uploaded on the DB system
  * hostname - The hostname of the node
  * data\_storage\_size\_in_gb - The data storage size of the DB
  * license_model - The license model
  * node_count - Number of DB nodes


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

## Example
In the provided example, there are 2 DB Systems created

* hur1dbaas
* hur2dbaas

In the example from below, there is a list of compartments containing 1 element and a list of subnets containing one element. By setting in database\_params `compartment_name` to sandbox, The databases will be created in the following compartment `ocid1.compartment.oc1..aaaaaaaaiu3vfcpbjwwgpil3xakqts4jhtjq42kktmisriiszdvvouwsirgq`. The same thing is happening to subnet\_ids. All lists can be extended in order to satisfy your needs.

The example is based on terraform.tfvars values:

```
compartment_ids = {
  sandbox = "ocid1.compartment.oc1..aaaaaaaaiu3vfcpbjwwgpil3xakqts4jhtjq42kktmisriiszdvvouwsirgq"
}

subnet_ids      = {
  hur1pub  = "ocid1.subnet.oc1.eu-zurich-1.aaaaaaaapejshjhsljycynokehdhw47oh4vhp2rlakzudnlp5by6gsg6jzfa"
  hur1priv = "ocid1.subnet.oc1.eu-zurich-1.aaaaaaaamcf3qooqlrsoycjkegvqlet2gt3hbrsnurxjj2wezmjs3jhzke6q"
}

database_params = {
  hur1dbaas = {
    compartment_name        = "sandbox"
    ad                      = 1
    cpu_core_count          = 2
    db_edition              = "ENTERPRISE_EDITION"
    db_name                 = "hur1dbaas"
    db_admin_password       = "BEstrO0ng_#11"
    db_workload             = "OLTP"
    pdb_name                = "hur1pdbdbaas"
    enable_auto_backup      = true
    db_version              = "12.1.0.2"
    display_name            = "hur1dbaas"
    disk_redundancy         = "HIGH"
    shape                   = "VM.Standard2.8"
    subnet_name             = "hur1pub"
    ssh_public_key          = "/root/.ssh/id_rsa.pub"
    hostname                = "hur1dbaas"
    data_storage_size_in_gb = 256
    license_model           = "BRING_YOUR_OWN_LICENSE"
    node_count              = 1
  },
  hur2dbaas = {
    compartment_name        = "sandbox"
    ad                      = 1
    cpu_core_count          = 2
    db_edition              = "ENTERPRISE_EDITION_EXTREME_PERFORMANCE"
    db_name                 = "hur2dbaas"
    db_admin_password       = "BEstrO0ng_#11"
    db_workload             = "OLTP"
    pdb_name                = "hur2pdbdbaas"
    enable_auto_backup      = true
    db_version              = "12.1.0.2"
    display_name            = "hur2dbaas"
    disk_redundancy         = "NORMAL"
    shape                   = "VM.Standard2.8"
    subnet_name             = "hur1pub"
    ssh_public_key          = "/root/.ssh/id_rsa.pub"
    hostname                = "hur2dbaas"
    data_storage_size_in_gb = 256
    license_model           = "BRING_YOUR_OWN_LICENSE"
    node_count              = 1
  },
}
```

This is just an example, but the number of the resources can be increased/decreased to suit any needs.

For example if you want to increase the number of DB systems to 3, you will have to modify the db_params variable in the terraform.tfvars file, by adding another map containing the configurations of the new dbaas.

Don't forget to populate the provider with the details of your tenancy as specified in the main README.md file.

## Running the code

Go to **thunder/examples/crawl/dbaas**

```
# Run init to get terraform modules
$ terraform init

# Create the infrastructure
$ terraform apply --var-file=path_to_provider.auto.tfvars

# If you are done with this infrastructure, take it down
$ terraform destroy --var-file=path_to_provider.auto.tfvars
```

## Useful Links
[Database FAQ](https://cloud.oracle.com/database/faq)

[Database Overview](https://docs.cloud.oracle.com/iaas/Content/Database/Concepts/databaseoverview.htm)

[Terraform Database Resource](https://www.terraform.io/docs/providers/oci/r/database_db_system.html)

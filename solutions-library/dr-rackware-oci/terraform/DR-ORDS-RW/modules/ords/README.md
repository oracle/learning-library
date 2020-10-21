    #     ___  ____     _    ____ _     _____
    #    / _ \|  _ \   / \  / ___| |   | ____|
    #   | | | | |_) | / _ \| |   | |   |  _|
    #   | |_| |  _ < / ___ | |___| |___| |___
    #    \___/|_| \_/_/   \_\____|_____|_____|
***
## Compute Instance for Appication Express with ORDS with Terraform

This creates a Compute Instance to run ORDS (Oracle Rest Data Service), which can be used for Oracle Applicaton Express (APEX). 
ORDS and APEX are configured for a single database by the scripts at the first time. You can add additional databases to be monitored or managed later.

### Using this scripts
* To run this terraform scripts, URLs of OCI Object Storage Service for the follwoing files is required.
  * ORDS (war extension)
  * [Optional] Tomcat 8.5 (tar.gz extension) 
* With using setup.sh, specify required information such as authentication, target database, compute instance and URLs for required files in an interview format.
  * You can also edit env-vars file directly.
* Source env-vars
  * `$ . env-vars`
* All the passwords of users which are creatd by this scripts are the same as DB admin password.

### How to run the scripts

#### `env-vars`
Is used to export the environmental variables used in the configuration.

Before you plan, apply, or destroy the configuration source the file -  
`$ . env-vars`

You can update the values in variables.tf for your environments to build if needed.

Here is the typical steps to run terraform commands from launch to termination.  
You will ask an admin password for the target database when issueing terraform commands.

```console
$ cd <directory where *tf files are located> 
$ ./setup.sh
$ . env-vars
$ terraform init  
$ terraform plan 
$ terraform apply  
$ terraform show 
$ terraform paln -destroy
$ terraform destroy 
```

### Files in the configuration

#### `compute.tf`
Defines the compute resource

#### `remote-exec.tf`
This remote-exec.tf transfers files and setups Web Container, ORDS and SSL configurations.

#### `./userdata/*`
The user-data scripts that get injected into an instance on launch.

#### `variables.tf`
Defines the variables used in the configuration

#### `datasources.tf`
Defines the datasources used in the configuration

#### `zone.tf`
Defines the DNS zone used in the configuration

#### `record.tf`
Defines the DNS record used in the configuration

#### `outputs.tf`
Defines the outputs of the configuration

#### `provider.tf`
Specifies and passes authentication details to the OCI TF provider

#### `terraform.tfstate`
#### `terraform.tfstate.backup`
These are the state files used by terraform. Care should be taken to consider locking issues (by default, these files are not locked to prevent sharing) and if these files are lost the infrstructure continues to run but will not longer be managed by Terraform.

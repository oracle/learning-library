# GlusterFS

## Introduction
This project will build GlusterFS infrastructure using terraform both georeplicated and simple volumes.

## Prerequisites
* Terraform v0.12.12 or greater <https://www.terraform.io/downloads.html>
* The networking components should already exist (VCN, route tables, etc.)
* The compartment(s) should already exist
* You will need to have ssh connectivity from the instance you are running the code to the glusterfs nodes that will be provisioned by it
* NAT Gateways should be configured for all the instances
* 24007-24009/tcp and 49152-49251/tcp should be open

GlusterFS Geo Replicated Volume
* VCN from 1st region should be peered with the VCN from the 2nd region


## Deployment
Follow the instructions from Prerequisites links in order to install terraform.
* Download the terraform version suitable for your operating system
* Unzip the archive
* Add the executable to the PATH

You will have to generate an API signing key (public/private keys) and the public key should be uploaded in the OCI console, for the iam user that will be used to create the resources. Also, you should make sure that this user has enough permissions to create resources in OCI. In order to generate the API Signing key, follow the steps from: <https://docs.us-phoenix-1.oraclecloud.com/Content/API/Concepts/apisigningkey.htm#How>
The API signing key will generate a fingerprint in the OCI console, and that fingerprint will be used in a terraform file described below.

You will also need to generate an OpenSSH public key pair in order for you and terraform to be able to access the GlusterFS compute nodes through SSH protocol. Please store those keys in a place accessible like your user home .ssh directory.


## GlusterFS Examples
There is a folder in thunder->examples->run->glusterfs called **examples**.
In the **examples** folder there are two sub-folders containing different instantiations of simple glusterfs volumes and geo-replicated glusterfs volumes.
The simple glusterfs volumes will have all the servers created in the same region, and the geo-replicated volumes will have servers created in a DR region.
For geo-replication, when you create a volume in one of the regions, the other one should be identical in order to avoid inconsistencies.

In order to be able to run them you should create a file with a **.tfvars** extension that will contain the information related to the provider as follows:

```
provider_oci = {
  tenancy       = "The id of the tenancy"
  user_id       = "The id of the user"
  key_file_path = "The path to the oci api private key created in the Deployment section"
  fingerprint   = "The fingerprint of the above key"
  region        = "The region in which you want to spawn the glusterfs volume"
  region2       = "The region used for DR, which should be used only for geo-replication"
}
```

Apart from that, you should also modify the paths to the ssh public and private keys and also the **comp\_id** and **subnet\_id** of the **instance\_params** variable and **instance\_params\_2** variable in case you are using geo-replication.

```
ssh_public_key  = "/home/opc/.ssh/id_rsa.pub"
ssh_private_key = "/home/opc/.ssh/id_rsa"

instance_params = {
  gfstest1 = {
    ad                   = 1
    shape                = "VM.Standard2.8"
    hostname             = "gfstest1"
    preserve_boot_volume = true
    comp_id              = "ocid1.compartment.oc1...."
    subnet_id            = "ocid1.subnet.oc1......."
  }
  gfstest2 = {
    ad                   = 2
    shape                = "VM.Standard2.8"
    hostname             = "gfstest2"
    preserve_boot_volume = true
    comp_id              = "ocid1.compartment.oc1...."
    subnet_id            = "ocid1.subnet.oc1......."
  }
}
```

In the above example, there are two instances created called **gfstest1** and **gfstest2**. You can increase the number of instances easily, by adding another map in the **instance\_params** variable.

The links between the instances and the block volumes are made by the instances names based on the **instance\_name** parameter in the **bv\_params** variable.

```
bv_params = {
  gfstest11 = {
    name          = "gfstest11"
    size_in_gbs   = 100
    instance_name = "gfstest1"
  }
  gfstest21 = {
    name          = "gfstest21"
    size_in_gbs   = 100
    instance_name = "gfstest2"
  }
}
```

In the above example, there are two block volumes created called **gfstest11** and **gfstest21**. You can increase the number of block volumes easily, by adding another map in the **bv\_params** variable.

All other parameters can be modified (names, shapes, ad, etc.)

Every example has a **gluster\_params** variable which contains the volume type and the replica count (for distributed volumes the replica will be set to an empty string, due to the fact that a distributed volume does not use any replicas).

```
gluster_params = {
  replica_number = 2
  volume_type    = "replicated"
}
```


### Distributed
A distributed volume will split all the files between the bricks that are contained in a glusterfs volume.
For example, if you have 2 bricks in your volume (brickA, brickB) and you create two files, fileA and fileB, they will be split between the two bricks (brickA will have fileA, brickB will have fileB)

#### Simple Distributed
In the examples->glusterfs\_volume->distributed there is a simple glusterfs volume instantiation that contains 2 servers, each of them having one brick attached.

#### Geo-Replicated Distributed
In the examples->georeplicated\_glusterfs\_volume->distributed there is a geo-replicated glusterfs volume instantiation that contains 2 servers per region, each of them having one brick attached.
Basically, there will be 2 master nodes and 2 slave nodes and they will have a 1-1 relationship (If you create a file, it will also be copied to one of the slave bricks, even though this is a distributed glusterfs volume).



### Replicated
A replicated volume mirrors the files based on the replica number that is set in **gluster\_params**
For example, if you have three bricks and a replica set to three and you create a file, that file will be added to all of the bricks. 

#### Simple Replicated
In the examples->glusterfs\_volume->replicated there is a simple glusterfs volume instantiation that contains 2 servers, each of them having one brick attached.

#### Geo-Replicated Replicated
In the examples->georeplicated\_glusterfs\_volume->replicated there is a geo-replicated glusterfs volume instantiation that contains 2 servers per region, each of them having one brick attached.
Basically, there will be 2 master nodes and 2 slave nodes and they will have a many to many relationship (If you create a file, it will be copied to all of the bricks).



### Distributed Replicated
A distributed replicated volume mirrors the files based on the replica number that is set in **gluster\_params**
For example, if you have four bricks and a replica set to two and you create a file, that file will be added to two of the bricks.

In both of the examples you will initially obtain a **Replicated** volume, but if you add more bricks based on the replica count, you will be able to obtain a true distributed replicated volume.

#### Simple Distributed Replicated
In the examples->glusterfs\_volume->distributed\_replicated there is a simple glusterfs volume instantiation that contains 2 servers, each of them having one brick attached.

#### Geo-Replicated Distributed Replicated
In the examples->georeplicated\_glusterfs\_volume->distributed\_replicated there is a geo-replicated glusterfs volume instantiation that contains 2 servers per region, each of them having one brick attached.
Basically, there will be 2 master nodes and 2 slave nodes and they will have a many to many relationship (If you create a file, it will be copied to all of the bricks).



### Dispersed
Dispersed volumes are based on erasure codes. It stripes the encoded data of files, with some redundancy added, across multiple bricks in the volume. You can use dispersed volumes to have a configurable level of reliability with minimum space waste. A dispersed volume can be created by specifying the number of bricks in a disperse set.
Similar to RAID 5.

#### Simple Dispersed
In the examples->glusterfs_volume->dispersed there is a simple glusterfs volume instantiation that contains 3 servers, each of them having one brick attached.

#### Geo-Replicated Dispersed (unstable)
In the examples->georeplicated\_glusterfs\_volume->dispersed there is a geo-replicated glusterfs volume instantiation that contains 3 servers per region, each of them having one brick attached.
Basically, there will be 3 master nodes and 3 slave nodes and they will have a many to many relationship (If you create a file, chunks of it will be copied to all of the bricks).


### Distributed Dispersed
Distributed dispersed volumes are the equivalent to distributed replicated volumes, but using dispersed subvolumes instead of replicated ones. When you create a distributed dispersed volume, the number of bricks specified in the **terraform.tfvars** must be a multiple of the replica number.

#### Simple Distributed Dispersed
In the examples->glusterfs\_volume->distributed\_dispersed there is a simple glusterfs volume instantiation that contains 3 servers, each of them having one brick attached.

#### Geo-Replicated Distributed Dispersed (unstable)
In the examples->georeplicated\_glusterfs\_volume->distributed\_dispersed there is a geo-replicated glusterfs volume instantiation that contains 3 servers per region, each of them having one brick attached.
Basically, there will be 3 master nodes and 3 slave nodes and they will have a many to many relationship (If you create a file, chunks of it will be copied to all of the bricks).



## Running the code

### Terraform

Go to examples->georeplicated/simple->volume_type directory:

```
# Do the necessary changes to the variables mentioned in the GlusterFS Examples section.

# Run init to get terraform modules
$ terraform init

# Run the plan command to see what will happen.
$ terraform plan

# If the plan looks right, apply it.
$ terraform apply

# If you are done with this infrastructure, take it down
$ terraform destroy
```

### Mounting the GlusterFS Volume
For NFS please consult the following: https://docs.gluster.org/en/latest/Administrator%20Guide/Setting%20Up%20Clients/#auto-nfs

Example mount:
sudo mount -t nfs4 node_ip:/glustervol /path\_to\_mount



## Automated Testing Method


### **Simple Volumes**

The test will be made with 3 parameters: 

**1st**: the IP address of the first server. This IP will be stored in **CLUSTERIP** variable. In case of geo-redundancy, this IP will be the masters's IP.

**2nd**: value 0 or 1 stored in **GEORED** variable. Value 0 means without geo-redundancy(simple volumes) and 1 with geo-redundancy.

**3rd**: the IP address of the slave server. This IP will be stored in **SLAVE** variable and you will give value only if **GEORED** variable will have value 1. For simple volume the value will be 0.

The parameters of glustervol can be seen using the command: **gluster volume info glustervol**. A filter is made after *Type* parameter whose value is stored in **TYPE** variable. Deppending on the value of TYPE variable (Distribute, Replicate, Disperse) some actions will be taken: it will mount *server_IP:/glustervol* from server to */u100*, then in *u100* folder will be created 10 files with names like "test.number", where number will be the number of the file, and who will have from 100Mbps to 1Gbps.

The number of bricks will be stored in a variable named **BRICKS** and will be displayed. In the  folder */tmp* it will be created a file named *gluster.status* in which will be stored the name of the bricks, the servers IP's and the path. 

In the folder */tmp* will be created a file named *servers_bricks.txt* which will contain the servers IP's in one column and the path in another column. These values ​​will be read line by line and then the IP and the path will be desplayed separately. 

For each server it will be displayed the hostname and all the files found in the path along with all of the necessary details and in that moment the comparison between servers can be made. 
In the end the /u100 will be unmounted. 




### **Geo-replicated**

In geo-replicated case, we apply those told to simple volumes with some additions.

If the value of the variable **GEORED** will be 1, we will check the status of all geo-replication sessions. In the folder */tmp* will be created a file named *servers_bricks.txt* which will contain the slave servers IP's in one column and the path in another column. These values ​​will be read line by line and then the IP and the path will be desplayed separately. 




## Utils
[Setting up GlusterFS volumes](https://docs.gluster.org/en/latest/Administrator%20Guide/Setting%20Up%20Volumes/)

[GlusterFS Disaster Recovery](https://access.redhat.com/documentation/en-us/red_hat_gluster_storage/3.1/html/administration_guide/sect-disaster_recovery)

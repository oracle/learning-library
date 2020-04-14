# Custom Images Examples

## Introduction
In this section, you will learn how to use an automation that creates a custom image from a running instance and how to create and upload different images to OCI using Packer.

## Generate custom Image from an Instance 

### Prerequisites
* Install Python3.6 -> sudo yum install python36 -y
* Install setup tools -> sudo yum install python36-setuptools
* Install pip -> sudo python3.6 -m easy_install pip
* Install oci with pip -> sudo python3.6 -m pip install oci

You will have to generate a config file for oci in **/home/user/.oci/config**. If you are running the code as root, the path will be: **/root/.oci/config**

The contents of this file should be:
```
[DEFAULT]
user=ocid1.user.oc1..aaaaaaaav6zc6gd6attdvesbaqj2klp2mribm4rfacbstzk7sag6yhmzetqa
fingerprint=d7:07:3f:b6:f6:f1:ce:d3:0e:fd:24:e7:20:f0:3f:6a
key_file=/root/.oci/oci_api_key.pem
tenancy=ocid1.tenancy.oc1..aaaaaaaaksusyefovxt64bsovu523r5ez6qz25pcnqjw2a243qjmft5n7drq
region=us-ashburn-1
```

### Create and move custom image(s)
Based on a compartment that you would pass to the script, a list of instances and a destination region, the script will create the image(s) from the specified instance(s) and move the image(s) to the indicated destination region. 

The script does not delete the image(s) from the home region (from config file), so it will exist in both of them.


Examples of running the code:
```
# Display help
$ python3.6 start_stop.py --help
or
$ python3.6 start_stop.py -h

# Run script
$ python3.6 custom_image.py -compartment comp_name -destination_region dest_region -instances instance_name1 instance_name2  
```


## Packer Examples
There are 2 types of image examples:
* OCI - internal images which use the oracle-oci builder. Packer adds the desired settings on top of an existing image from OCI
* QEMU - external images which use the qemu builder. Packer adds the desired settings on top of an official linux image


### Prerequisites
* Packer https://www.packer.io/docs/install/index.html


### Packer installation
In order to install Packer, you can use a precompiled binary or you can install directly from source by using the url from the prerequisites. The easiest way is to use a precompiled binary.
To install the precompiled binary, download the appropriate package for your system. Packer is currently packaged as a zip file.
Once the zip is downloaded, unzip it into any directory. The packer binary inside is all that is necessary to run Packer (or packer.exe for Windows). Any additional files, if any, aren't required to run Packer.
Copy the binary to anywhere on your system. If you intend to access it from the command-line, make sure to place it somewhere on your PATH.

### OCI example
Go to the folder: *examples/custom_images/packer/oci*

This example is creating a packer image in OCI containing terraform, oci-cli, ansible, oci ansible modules, packer and python3.
The image is built from an existing base image. The base image OCID is specified in the packer variables file.

#### Example files
In this folder, we have 3 files:
* oci-packer.json - packer template file
* install-tools.sh - provisioning script used for customizations
* packer-variables.json - file with values for packer variables

#### Creating the image
Update the packer variables file with your details.

You can validate the syntax and configuration of the template file:
```
packer validate -var-file packer-variables.json oci-packer.json
```
You can check what the template file is defining:
```
packer inspect oci-packer.json
```

Then you can build the image:
```
PACKER_LOG=1 packer build -var-file packer-variables.json oci-packer.json
```

#### Using the image
The image will be shown in the OCI console, under **Compute**, in the **Custom Image** section.

The new custom image can be used for creating new instances:
* from the OCI console
* from terraform code (by using the custom image OCID)

### QEMU examples
Go to the folder specific to the desired operating system and version: *packer/qemu/OS* (for ex: *packer/qemu/centos7*)

These examples will create a qcow2 image starting from an official linux image

For the moment, the following options are available:
* CentOS 6
* CentOS 7
* Oracle Linux 6
* Oracle Linux 7

The source of the base ISO images is:
* for CentOS - official mirrors
* for Oracle Linux - from https://blogs.oracle.com/linux/oracle-linux-iso-images-download-options

#### Example files
Each folder has some files in it which are used for building the image:
* OS-ARCHITECTURE.json - packer template file
* OS-ARCHITECTURE.ks - kickstart automation file
* OS-ARCHITECTURE.sh - provisioning script used for customizations
* other files - used for advanced customization

#### Creating the image
You can validate the syntax and configuration of the template:
```
packer validate image_name.json
```
You can check what the template file is defining:
```
packer inspect image_name.json
```

Then you can build the image:
```
PACKER_LOG=1 packer build image_name.json
```

#### Using the image
After the image is built, a qcow2 image file will be created in a folder. The folder is specified by the *output_directory* parameter from the json template file.

In order to use the image, you will have to:
* create an **Object Storage Bucket** in OCI
* upload the resulting qcow2 image in the bucket
* create a PAR for the object
* add the PAR URL in the OCI console, under **Compute**, in the **Custom Image** section

The new custom image can be used for creating new instances:
* from the OCI console
* from terraform code (by using the custom image OCID)
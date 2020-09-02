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

The contents of this file should look like:
```
[DEFAULT]
user=ocid1.user.........
fingerprint=.........
key_file=path_to_oci_api_private_key
tenancy=ocid1.tenancy......
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

These templates build QCOW2 images from scratch using an official ISO. The following are available:
* CentOS 6
* CentOS 7
* Oracle Linux 6
* Oracle Linux 7
* Windows 10 Enterprise Evaluation
* Windows 10 Pro
* Windows 2016 Server (Server Core)
* Windows 2016 Server (Desktop)
* Windows 2019 Server (Server Core)
* Windows 2019 Server (Desktop)

The source of the base ISO images is:
* for CentOS - official mirrors
* for Oracle Linux - https://blogs.oracle.com/linux/oracle-linux-iso-images-download-options
* for Windows 10 Pro/Enterprise - https://www.microsoft.com/en-us/software-download/windows10
* for Windows 2016/2019 Server - https://www.microsoft.com/en-us/evalcenter/evaluate-windows-server-2016

### Linux templates
Each folder has the following files which are used for building the image:
* OS-ARCHITECTURE.json - packer template
* OS-ARCHITECTURE.ks - kickstart
* OS-ARCHITECTURE.sh - provisioning script used for customizations
* other files - used for advanced customization

### Creating the image
Validate the syntax and configuration of the template:
```
packer validate OS-ARCHITECTURE.json
```
Check what the template file is defining:
```
packer inspect OS-ARCHITECTURE.json
```
Build the image:
```
PACKER_LOG=1 packer build OS-ARCHITECTURE.json
```

### Windows templates
Each Windows template folder is structured as follows:
* a *floppy* subfolder containg two subfolders - *drivers* and *scripts*. The *drivers* subfolder contains the VirtIO drivers for network interface and SCSCI.
The *scripts* contains five scripts:
- SETUP.BAT: sets the WinRM service to automatically start at boot and then runs WinRM.ps1 
- WinRM.ps1: configures the WinRM service in the virtual machine to accept connections
- autounattend.xml: Windows unattended setup file
- sysprep.xml: used for sysprepping the virtual machine
- unattend.xml: injected in the virtual machine when the building process is finished. Sets the opc and Administrator account password and enables ICMP on the virtual machine.
- windows\_version-x86\_64.json - packer template

To find out more details on how Windows Setup process works check https://docs.microsoft.com/en-us/windows-hardware/manufacture/desktop/how-configuration-passes-work

### Creating the image
Validate the syntax and configuration of the template:
```
packer validate windows_version-x86_64.json
```
Build the image:
```
PACKER_LOG=1 packer build windows_version-x86_64.json
```



### Importing the image
Once the building process is finished with success the *output_directory* will be created containing the QCOW2 image.

In order to use the image, you will have to:
* create an **Object Storage Bucket** in OCI
* upload the resulting qcow2 image in the bucket
* Import image using Compute / Custom Images / Import Image dialog. Use the option IMPORT FROM AN OBJECT STORAGE BUCKET

Once the import process is successfully finished a new custom image will appear in Compute / Custom Images console. The new custom image can be
used just like any other base image.

## Known issues
**At the moment, there are no known issues**

---
layout: ziplab
description: Learn how to launch a Virual Machine using Oracle Cloud Infrastructure Computer Service
tags: Oracle Cloud, Oracle Cloud Infrastructure, OCI, Virtual Machine, VM, Virtual Cloud Network, VCN
permalink: /ziplabs/oci-vm/index.html
---
# Create a Virtual Machine Instance Using Oracle Cloud Infrastructure Compute #

## Before You Begin ##
This 20-minute tutorial shows you how to create a Virtual Machine (VM) instance using Oracle Cloud Infrastructure (OCI) Compute Service. Before you can create a VM, you'll create a Virual Cloud Network (VCN).

### Background ###
Oracle Cloud Infrastructure Compute Service lets you create Virtual Machine instances on which you can run your mission-critical applications with high availability.

Before you can launch an instance, you need to have a VCN to launch it into. In the VCN, you launch the instance into a subnet. A subnet is a subdivision of your VCN that you define in a single Availability Domain. The subnet directs traffic according to a route table. In this tutorial, you'll access the instance over the internet using its public IP address, so your route table will direct traffic to an Internet Gateway. The subnet also uses a security list to control traffic in and out of the instance.

### What Do You Need? ###
* Access to an instance of Oracle Cloud Infrastructure Compute Service
* A Virtual Cloud Network in the compartment in which the instance will run
* An SSH key pair (if creating a Linux VM)


## Create a Virtual Cloud Network ##
1. Sign in to the Oracle Cloud Platform.
2. Click the menu icon to expand the menu on the left edge of the screen.
3. Click **Services**.
4. Click **Compute**.

    ![](img/MyServicesMenu.png)
    
    [Description of the illustration MyServicesMenu.png](files/MyServicesMenu.txt)

5. Click the OCI menu icon to expand the menu on the left edge of the screen.
6. Select **Networking**.
7. Click **Virtual Cloud Networks**.
    
    ![](img/OCIMenu1.png)

    [Description of the illustration OCIMenu1.png](files/OCIMenu1.txt)

8. Select the root compartment from the Compartment dropdown menu.

    ![](img/Compartment.png)

    [Description of the illustration Compartment.png](files/Compartment.txt)

9. Click the button **Create Virtual Cloud Network**.
10. In the Create Virtual Cloud Network dialog box, enter the following information:
     * **Create in Compartment**: Select the root compartment.
     * **Name**: `user01_Network`
     * Select **Create Virtual Cloud Network Plus Related Resources**.
     * The box to **Use DNS Host Names in this VCN** should be checked.
     * Scroll down. The box to **View detail page after this resource is created** should be checked.
11. Click the button **Create Virtual Cloud Network** to close the dialog box. A confirmation page with the details of the cloud network is diplayed.
12. Click **Close**.


## Create a Virtual Machine Instance ##
1. Click the OIC menu icon to expand the menu on the left edge of the screen.
2. Select **Compute**.
3. Click **Instances**.
    
    ![](img/OCIMenu2.png)

    [Description of the illustration OCIMenu2.png](files/OCIMenu2.txt)

4. Ensure the root compartment is still selected in the Compartment dropdown menu.

    ![](img/Compartment.png)

    [Description of the illustration Compartment.png](files/Compartment.txt)

5. Click the button **Create Instance**.
6. In the Create Instance dialog box, enter the following information:
     * **Name**: Keep the default value.
     * **Availability Domain**: Keep the default value.
     * **Boot Volume**: `Oracle-Provided OS Image`
     * **Image Operating System**: `Oracle Linux 7.5`.
     * **Shape Type**: `Virtual Machine`
     * **Shape**: `VM.Standard2.1 (1 OCPU, 15GB RAM)`
     * **Image Version**: Choose the latest version.
     * **Boot Volume Configuration**: Keep the default values. The boxes should remain unchecked.
     * **SSH Key**: Select `Paste SSH Keys`. An example SSH key to paste is: 
     <pre><code>ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDVNPh09u35ejTZun3FNEGhrjL/CovPsHAh79pN0QVprxEJaW2zjmaBZF1Q6lkuyTRvraomIlduCYxrlnwCe8oyER5dY1zuJATWm7ZiqgsvIkhj8L+ea9dBZRvFvcnFsNFnt4ALZYkW2nB2EeTdvqVMHERjFKfbRMCcO0dusmBUEsvaaqLtrvVuHBjwoXIDKkT/PFkix4DWRZRkZIjmZ/y9kwrHO4W1FYsFi4LP1xIB1c9y2H4w0SBXAMv4NCSFEIgWPQly2NywMsgEbddjW+zPz+7YjYqjWfz5Fgchu7+N1gejsIdzg1/aLvDpze6TN9xLcZx5gt04jA3TR+xfs2Ab Tim@Corsair</code></pre>
         
    ![](img/pastesshkey.png)

    [Description of the illustration pastesshkey.png](files/pastesshkey.txt)

7. In the Networking section:
     * Choose the Virtual Cloud Network you created earlier, `user01_Network`
     * Keep the default values for the remaining fields.
8. Scroll down and click the button **Create Instance** to close the dialog box.
     * While the instance is being created, its state is displayed as `PROVISIONING`.
     * The status changes to `RUNNING` when the instance is fully operational.


## Want to Learn More? ##
* [Oracle Cloud Infrastructure Training](https://education.oracle.com/learn/iaas/pPillar_640) from Oracle University 
* [Oracle Cloud Infrastructure 2018 Architect Associate Certification](https://education.oracle.com/es/oracle-cloud-infrastructure-2018-architect-associate/pexam_1Z0-932) from Oracle University
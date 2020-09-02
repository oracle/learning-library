<table class="tbl-heading"><tr><td class="td-logo">![](images/obe_tag.png)

November 08, 2018
</td>
<td class="td-banner">
# Lab 9: Configure Oracle Cloud Infrastructure Command Line Interface
</td></tr><table>
 

## Introduction

This lab walks you through some examples using the Oracle Cloud Infrastructure Command Line Interface for Autonomous Transaction Processing.

The CLI is a small footprint tool that you can use on its own or with the Console to complete Oracle Cloud Infrastructure tasks. The CLI provides the same core functionality as the Console, plus additional commands. Some of these, such as the ability to run scripts, extend the Console's functionality.

This CLI and sample is dual-licensed under the Universal Permissive License 1.0 and the Apache License 2.0; third-party content is separately licensed as described in the code.

The CLI is built on Python (version 2.7.5 or later), running on Mac, Windows, or Linux. The Python code makes calls to Oracle Cloud Infrastructure APIs to provide the functionality implemented for the various services. These are REST APIs that use HTTPS requests and responses. For more information, see [About the API](https://docs.cloud.oracle.com/iaas/Content/API/Concepts/usingapi.htm)


### See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
## Objectives

- Configure Oracle Cloud Infrastructure Command Line Interface
- Run examples using OCI-CLI for Autonomous Transaction Processing database

## Required Artifacts

- The following lab requires an Oracle Public Cloud account. You may use your own cloud account, a cloud account that you obtained through a trial, or a training account whose details were given to you by an Oracle instructor.

- A user created in that account, in a group with a policy that grants the desired permissions. This account user can be you, another person, or a system that calls the API. For an example of how to set up a new user, group, compartment, and policy, see [Adding Users](https://docs.cloud.oracle.com/iaas/Content/GSG/Tasks/addingusers.htm)

- Python version 2.7.5 or later, running on Mac, Windows, or Linux.

#### Note: If you use the CLI Installer and do not have Python on your machine, the Installer offers to automatically install Python for you.


## Steps

### **STEP 1: Install Oracle Cloud Infrastructure Command Line Interface (OCI-CLI)**

- There are two ways to install the CLI and you can use the one that is best suited for your environment. Use either of the following options:
    - Automatically installing the CLI and dependencies with the CLI installer
    - Manually installing the CLI and dependencies within a virtual environment

#### Using the CLI installer

The installer uses a script to install the CLI and programs that are required. You can use the installer to eliminate most of the manual steps to install the CLI. The installer script:

- Installs Python 
    - During installation, you are prompted to provide a location for installing the binaries and executables. If Python is not installed on your computer, or the installed version of Python is incompatible with the CLI, you are prompted to install Python.
    - The installer doesn't try to install Python on a MacOS computer. However, the script notifies you if the version of Python on the computer is too old or incompatible.

- Installs virtualenv and creates a virtual environment

- Installs the latest version of the CLI

    - The installer overwrites an existing installation if you chose to do so. Respond with Y when prompted to upgrade the CLI to the newest version.
    - During the installation, you are asked if you want to update your PATH. Updating the PATH adds the CLI executable ("oci.exe") to your PATH. Adding oci.exe to the PATH lets you invoke the CLI without providing the full path to the executable. If you want to update your PATH, respond with Y when prompted. You are notified when to close and restart the terminal session.

To install the CLI on any compute with Bash

- Open a terminal 
- To run the installer script, run the following command
- Respond to the installer's prompts

```
bash -c "$(curl -L https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh)"
```

![](./images/900/OCI-CLI-Install.png)


### **STEP 2: Configure OCI CLI**

- This step describes the required configuration for the CLI and includes optional configurations that enable you to extend CLI functionality. 

- Before using the CLI, you have to create a config file that contains the required credentials for working with Oracle Cloud Infrastructure. You can create this file using a setup dialog or manually, using a text editor.

- To have the CLI walk you through the first-time setup process, step by step, use

```
oci setup config
```

- The command prompts you for the information required for the config file and the API public/private keys. The setup dialog generates an API key pair and creates the config file.


![](./images/900/OCI-Setup-Config.png)

- Once you run the above command, you will need to enter the following:

    - **Enter a location for your config [/Users/tejus/.oci/config]**: Press Return key
    - **Enter a user OCID**: This is located on your user information page in OCI console

    Login to OCI console and click on Menu, Identity and Users. Click on the User and navigate to User Details page. Copy the User OCID.

    ![](./images/900/UserOCID1.png)

    ![](./images/900/UserOCID2.png)


    - **Enter a tenancy OCID**: This is located in the bottom left of your OCI console
    
    Login to OCI console click on User icon on top right corner on the page and click on Tenancy and copy Tenancy OCID

    ![](./images/900/TenancyOCID1.png)

    ![](./images/900/TenancyOCID2.png)

    - **Enter a region (e.g. eu-frankfurt-1, uk-london-1, us-ashburn-1, us-phoenix-1)**: Select a region

    - **Do you want to generate a new RSA key pair? (If you decline you will be asked to supply the path to an existing key.) [Y/n]**: Y
    - **Enter a directory for your keys to be created [/Users/tejus/.oci]**: Press Return key
    - **Enter a name for your key [oci_api_key]**: Press Return key
    - **Enter a passphrase for your private key (empty for no passphrase)**: Press Return key
    
### **STEP 3: Add public key to Oracle Cloud Infrastructure**

- Now that you have a private / public key combo , you must add it to OCI Console:

Add public key to OCI User setting

- Open Terminal and navigate to folder containing **oci_api_key_public.pem**. Copy the public key.

```
cat oci_api_key_public.pem
```

![](./images/900/OCIPublicKeycleare.png)

- Login to your OCI console and click on Menu and select Identity and Users. Select a User and navigate to User Detial page.

- Click on Add Public Key under API Keys section.

![](./images/900/APIKeys.png)

- Paste Public key which you copied from CLI in Add Public Key

![](./images/900/AddPublicKey.png)


Once you add the key run the below command to autocomplete OCI setup.

```
oci setup autocomplete
```

### **STEP 4: Interacting with Oracle Autonomous Database**

Now that you have setup OCI CLI, let us now look at examples of using Autonomous Transaction Processing Database. 

#### Creating Database

Open your command line interface and run the following command to create an Autonomous Transaction Processing Database

```
oci db autonomous-database create --admin-password [password] --compartment-id [OCID] --cpu-core-count [integer] --data-storage-size-in-tbs [integer] --db-name [Database Name]
```

For example:

```
oci db autonomous-database create --admin-password "WElcome_123#" -c ocid1.compartment.oc1..aaaaaaaahnmqede4hg2sdom74lpljjwyu6nc6o2jr77rc5wagez3cwutu57a --cpu-core-count 1 --data-storage-size-in-tbs 1 --db-name "TejusDB"
```

You are expected to see the following output in the command line interface

![](./images/900/CreateDBOutput.png)

#### Get Databse

Open your command line interface and run the following command to get details of an Autonomous Transaction Processing Database

```
oci db autonomous-database get --autonomous-database-id [OCID]
```

For Example:

```
oci db autonomous-database get --autonomous-database-id ocid1.autonomousdatabase.oc1.phx.abyhqljrbfftoc3spn4aepi32ihhlhesfwztsjpjkwz2cgppexf3ercpu7ja
```

You are expected to see the following output in the command line interface

![](./images/900/GetDBOutput.png)

#### Listing Database

Open your command line interface and run the following command to List all Autonomous Transaction Processing Database

```
oci db autonomous-database list --compartment-id [OCID]
```

For example:

```
oci db autonomous-database list -c ocid1.compartment.oc1..aaaaaaaahnmqede4hg2sdom74lpljjwyu6nc6o2jr77rc5wagez3cwutu57a
```

You are expected to see the following output in the command line interface

![](./images/900/ListDBOutput.png)

#### Deleting Database

Open your command line interface and run the following command to delete an Autonomous Transaction Processing Database

```
 oci db autonomous-database delete --autonomous-database-id [OCID]
```

For example:

```
oci db autonomous-database delete --autonomous-database-id ocid1.autonomousdatabase.oc1.phx.abyhqljrbfftoc3spn4aepi32ihhlhesfwztsjpjkwz2cgppexf3ercpu7ja
```

You are expected to see the following output in the command line interface.

You will be asked **Are you sure you want to delete this resource? [y/N]** type Y to comfirm.

![](./images/900/DeleteDBOutput.png)

Login to OCI console and naviagte to Autonomous Transaction Processing Database from Menu and confirm that the database is **Terminating**.

![](./images/900/TerminateDBOutput.png)


#### Bonus Step: In similar way you can try the follwing examples

#### Restore Databse 

Open your command line interface and run the following command to Restore Autonomous Transaction Processing Database

```
oci db autonomous-database restore --autonomous-database-id [OCID] --timestamp [datetime]
```

#### Start Database

Open your command line interface and run the following command to Start Autonomous Transaction Processing Database

```
oci db autonomous-database start --autonomous-database-id [OCID]
```

#### Stop Database

Open your command line interface and run the following command to Stop Autonomous Transaction Processing Database

```
oci db autonomous-database stop --autonomous-database-id [OCID]
```

#### Update Database

```
oci db autonomous-database update --autonomous-database-id [OCID] --cpu-core-count [integer]
```

For further examples on how to work with OCI CLI with different services please refer to Oracle documentation [here](https://docs.cloud.oracle.com/iaas/tools/oci-cli/latest/oci_cli_docs/cmdref/db.html).


You have successfully configured Oracle Cloud Infrastructure Command Line Interface and ran examples on Autonomous Transaction Processing Database.

-   You are now ready to move to the next lab.

<table>
<tr><td class="td-logo">[![](images/obe_tag.png)](#)</td>
<td class="td-banner">
## Great Work - All Done!
</td>
</tr>
<table>
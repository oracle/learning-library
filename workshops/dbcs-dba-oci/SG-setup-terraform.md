# Setup

This workshop requires several setups steps that are normally done in advance as part of an automated process prior to running the labs.  In cases where a customer wishes to run through the workshop themselves on their own they must first walk through the following steps.  Note there are two setup options: The first is manual, and the second (this one) uses Terraform with the Oracle Terraform OCI Provider.  This is the recommended set as it has fewer steps and configures the cloud automatically.  We have left the manual one in place so you can see what the Terraform process will do for you.  This workshop was built on and for version 12.2 of the database, but will also work with 18c with minor changes.  The setup instructions and lab docs have notes at various places on what you need to do to run the workshop using 18c.  **Note: You must be off VPN to run the setup, and to do the labs.**

### **STEP 1**: Download the Terraform Configuration Files, and Install Terraform and the Oracle Terraform OCI-Provider

**Click to Download**

[TF.zip](https://oracle.github.io/learning-library/workshops/dbcs-dba-oci/TF.zip)

- Extract the Terraform configuration files from the git above into your Terraform working directory.  In our case we are extracting from `TF.zip` to `d:`.  De-select the Path.

	![](images/SG-setup-terraform/002.png)
	
- Download and install Terraform.  You have options for where you want to install it.  For the purposes of documenting the instructions we will use `d:\tf` directory, and will reference this throughout.
```
https://www.terraform.io/downloads.html
```
 
 -	Download and install the Oracle Terraform Provider for OCI.
```
https://github.com/oracle/terraform-provider-oci/releases
```

- The directory should look like this, with the terraform and oci provider and configuration files all on one directory, and keys and scripts sub-directories from the git.

	![](images/SG-setup-terraform/002.1.png)

### **STEP 2**: Generate a SSH and an API Key Pair using git bash.

- Open `Git Bash` from your program menu. Change directories to your terraform\keys directory.  In our case it is `d:/TF/keys`.

	![](images/SG-setup-terraform/003.png)

- Generate your ssh public key.  Enter the following (assuming your tf directory is d:/tf).
```
ssh-keygen
```
![](images/SG-setup-terraform/004.png)

- Rename the `publicKey` to `privateKey`.  The `publicKey.pub` is the public one, the other is the private one.

	![](images/SG-setup-terraform/005.png)

- Generate the api private and public keys (PEM format) for the api user.  Also change permissions of the private key.
```
openssl genrsa -out d:/tf/keys/oci_api_key.pem 2048
chmod go-rwx d:/tf/keys/oci_api_key.pem
openssl rsa -pubout -in d:/tf/keys/oci_api_key.pem -out d:/tf/keys/oci_api_key_public.pem
```
![](images/SG-setup-terraform/006.png)

- The keys directory should look like this.

![](images/SG-setup-terraform/007.png)

### **STEP 3**: Download the Oracle Backup Module, the Adobe Yum Repository, and the public yum ol6 repository to your Terraform directory (we are using D:\tf).

- Go to the following site to download opc_installer.zip and save to `d:\tf\scripts\ws` folder in your Terraform location:  `http://www.oracle.com/technetwork/database/availability/oracle-cloud-backup-2162729.html`

	![](images/SG-setup-terraform/017.png)

	![](images/SG-setup-terraform/018.png)

- Go to the following site and download the adobe repository: `https://get.adobe.com/flashplayer/`.  Do not select the default - select download for a different operating system (Linux 64 bit).

	![](images/SG-setup-terraform/019.png)

- Select the version YUM and save to the `d:\tf\scripts\ws` directory in your Terraform location.

	![](images/SG-setup-terraform/020.png)

	![](images/SG-setup-terraform/021.png)

- Go to `https://public-yum.oracle.com/public-yum-ol6.repo` and save the page results to your `d:\tf\scripts\ws` directory in your Terraform location.  

	![](images/SG-setup-terraform/022.png)

-	Then save to your `d:\tf\scripts\ws` directory.  Name the file `public-yum-ol6.repo`.

	![](images/SG-setup-terraform/023.png)

### **STEP 4**: Log into the Cloud Console and Retrieve Account Information

- We need to update the env-vars.bat file in the Terraform directory.  Open this file to review what needs to be updated.

	![](images/SG-setup-terraform/024.png)

	![](images/SG-setup-terraform/025.png)

-	Update your password.  We suggest you use your cloud password.

	![](images/SG-setup-terraform/026.png)

- Update the following keys by retrieving them from your cloud account:
	- `tenancy_ocid`
	- ` user_ocid`
	- `fingerprint`
	- `region`
	- `compartment_ocid`

- Log into your Cloud account:

	![](images/SG-setup-terraform/027.png)

- Select Customize Dashboard to view Database (OCI) Services.

	![](images/SG-setup-terraform/028.png)

	![](images/SG-setup-terraform/029.png)

- Select Database (OCI) and then Open the Database Service Console.

	![](images/SG-setup-terraform/030.png)

	![](images/SG-setup-terraform/031.png)

- Select Tenancy and copy the tenancy_ocid.  Update the env-vars.bat file with this value (paste carefully between the double quotes).

	![](images/SG-setup-terraform/032.png)

	![](images/SG-setup-terraform/033.png)

- Next go to Identity - Users.  Copy the user_ocid and paste into the env-vars.bat file.  Note if you are using a trial account the api_user will not exist.  In that case use the user_ocid of the trial account user.

	![](images/SG-setup-terraform/034.png)

	![](images/SG-setup-terraform/035.png)

- While in this screen Add your Public pem Key.  You will need to navigate to your Terraform /keys directory and open and select the contents to copy.  Paste into the window here.

	![](images/SG-setup-terraform/036.png)

	![](images/SG-setup-terraform/037.png)

- Copy the fingerprint from the public key and paste into the fingerprint field in the env-vars.bat file.

	![](images/SG-setup-terraform/038.png)

- Next go to Identity - Compartments.  

	![](images/SG-setup-terraform/039.png)

- Select the `Demo` compartment and copy the OCID key.  Note customers may use a different compartment.

	![](images/SG-setup-terraform/040.png)

- Copy the Region value into the region varable in env-vars.bat.

	![](images/SG-setup-terraform/044.png)

### **STEP 5**: Run Terraform.

-	**OPTIONAL 18c Update:**  This workshop was created for Database 12.2.  IF you want to run this workshop on Database 18c you need to update the Terraform Configuration to specify this database version.  Go to your Terraform directory and open the variables.tf file.  Otherwise skip this step.
	- Update `variables.tf`

	![](images/SG-setup-terraform/056.png)

	![](images/SG-setup-terraform/057.png)

- Update `scripts\alpha\oci_alpha_install_as_oracle.sh` and `scripts\ws\oci_ws_install_as_oracle.sh`

	![](images/SG-setup-terraform/058.png)

	![](images/SG-setup-terraform/059.png)

- Open a command window in the Terraform directory and enter `env-vars.bat`.

	![](images/SG-setup-terraform/045.png)

-	Then enter `terraform init`.  You should see the following.

	![](images/SG-setup-terraform/046.png)

- Then enter `terraform plan`

	![](images/SG-setup-terraform/047.png)

- Then enter `terraform apply`.  You will be prompted to enter yes after a few seconds.

	![](images/SG-setup-terraform/048.png)

- When it completes you should see this.

	![](images/SG-setup-terraform/049.png)

**Important:**  If you manually change services in the console and you wish to re-run this script you need to either first run `terraform destroy` or manually delete all the services in the console and delete the terraform state and .terraform directory and files (any terraform files created from the first run).

You should now be able to VNC into your WorkshopInstance.

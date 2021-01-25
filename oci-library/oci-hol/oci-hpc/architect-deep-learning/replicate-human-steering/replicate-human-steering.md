# Prepare your Tenancy for the Data Science Service using Infrastructure as Code

## Introduction

In this lab you will be preparing your tenancy for the data science service using infrastructure as code, otherwise known as Terraform. 

**Estimated Lab Time: 1 hour**

### Objectives

As a Data Scientist, Data Engineer, Power User or Developer:

- Create a Stack in Resource Manager to create your cloud infrastructure resources
- Create a compartment for your stack to live in
- View and Run a Stack on OCI

### Prerequisites

- An Oracle Cloud Infrastructure account with privileges to create stacks and compartments.
- Familiarity with Terraform is helpful, but not necessary
- Familiarty with navigating through the Oracle Cloud Infrastructure console is helpful
 


## **STEP 1: Log in to the Cloud Console**
1. In a browser, go to https://console.us-ashburn-1.oraclecloud.com, and log in with your provided credentials.

## **STEP 2: Create your Compartment**
1. Click the Hamburger Menu (≡) on the top left corner.
    ![](./images/click_hamburger.png)
2. Scroll down to "Identity" and click on "Compartments"
    ![](./images/identity.png)
3. Click the "Create Compartment" button in the top left corner.
    ![](./images/create_compartment.png)
4. Name the comparatment "data_science" and click "Create Compartment".
    ![](./images/data_science_compartment.png)

## **STEP 3: Create a Stack to use a Terraform Template that creates the required VCN, Subnet, User Group, and Policies**
1. Click the Hamburger Menu (≡) on the top left corner. Then, scroll down to "Resource Manager" and click on "Stacks".
    ![](./images/resource_manager_stacks.png)
2. Click "Create Stack" in the top left corner.
    ![](./images/create_stack.png)
3. Confirm the origin of the Terraform configuration is "My Configuration" (Uploading a Terraform configuration: .zip file). Then, upload the .zip file provided here (Need LiveLabs team to show me how to do this part).
    ![](./images/upload_zip.png)
4. Make sure you are creating this stack in the "data_science" compartment. The Terraform version should be **0.12.x**.
    ![](./images/tf_version.png)
5. Click the "Next" in the bottom left corner of the page. Proceed to configure your variables. They should be filled in already, but confirm they are the correct values.
    ![](./images/configure_variables.png)
6. Once again, click "Next" in the bottom left corner of the page. Review that your Stack information and variables look correct, and click "Create" in the bottom left corner.
    ![](./images/review_and_create_stack.png)
7. On the stack details page, from the **Terraform Actions** menu, select **Apply**.
    ![](./images/tf_apply.png)
8. Select **Automatically Approve**, and then click **Apply**. Wait for the resources to be created.
    ![](./images/automatically_approve.png)
9. Finally, locate the new user group named **data_science_managers** and add users to it.


## **STEP 3: Preconfigured Image**
The image is preconfigured with the following applications:
   * Anaconda
   * PyTorch
   * Jupyter Notebooks
   * Panda
   * Python 3.6
   * Scikit-learn
   * Updated CUDA drivers for NVIDIA Tesla GPU support (P100/V100)
   * Docker
   * NVIDIA GPU Cloud Container

You can pull all the following container runtime images from NVIDIA:
   * TensorFlow 2.0
   * Matplotlib
   * Seaborn
   * Keras
   * Caffee
   * Theano
   * MXNet

This script has been tested multiple times with customers.

#!/bin/bash -v
if [ ! -f nvidia.te ]; then
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install -y docker-ce docker-ce-cli containerd.io
curl -s -L https://nvidia.github.io/nvidia-docker/rhel7.6/nvidia-docker.repo | sudo tee
/etc/yum.repos.d/nvidia-docker.repo
sudo yum install --disableexcludes=all -y nvidia-container-toolkit nvidia-docker2
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker opc
cat <<EOT >> nvidia.te
module nvidia 1.0;
require {
    type unlabeled_t;
    type container_runtime_t;
    class key create;
}

allow container_runtime_t unlabeled_t:key create;\
EOT
checkmodule -M -m -o nvidia.mod nvidia.te
semodule_package -o nvidia.pp -m nvidia.mod
sudo semodule -i nvidia.pp
wget https://repo.anaconda.com/archive/Anaconda3-2019.07-Linux-x86_64.sh
chmod 777 Anaconda3-2019.07-Linux-x86_64.sh
bash ./Anaconda3-2019.07-Linux-x86_64.sh -b


# For pytorch
anaconda3/bin/conda install pytorch torchvision cudatoolkit=10.1 -c pytorch
echo "export PATH=/home/opc/anaconda3/bin/:\$PATH" >> /home/opc/.bashrc
fi



Repeat the preceding section for the Scikit-learn, Panda, and other Python data-science-related libraries or frameworks.


#### All Done! This completes the demo for provisioning an HPC Cluster from Oracle MarketPlace Image.

## Acknowledgements
* **Author** - High Performance Compute Team
* **Contributors** -  Chris Iwicki, Harrison Dvoor, Gloria Lee, Selene Song, Bre Mendonca
* **Last Updated By/Date** - Harrison Dvoor (9/28/20)


## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like us to follow up with you, enter your email in the *Feedback Comments* section.

**You may now proceed to the next lab**
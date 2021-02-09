# Disaster Recovery Network and Connectivity Setup
## Introduction
This solution provides a Network Architecture deployment to demonstrate Disaster Recovery scenario across 2 regions [ examples are geared towards region Montreal & Toronto and can be used for any OCI regions].

Estimated Lab Time 45-60 minutes


### Objectives
- Deploy Terraform to setup necessary architecture for DR

### Prerequisites
1. Download & unzip the [Terraform zip file](https://objectstorage.us-ashburn-1.oraclecloud.com/p/t2RvGol1cuJOc4lGwlHHp7j7MnknHtDzJeEMWYrP10-5fSWTFOs2yLreGhDjKgAW/n/c4u03/b/solutions-library/o/DR-ORDS-RW-master.zip) to your local machine.

2.  Create your own private/public key pair on your local system.
3.  Zip up all of the files in to a zip folder. The zip file name is not important.
    Just make sure it has the follow structure.
    
        rackware/
        ├── data_sources.tf
        ├── dr-ords-schema.yaml
        ├── main.tf
        ├── modules
        │   ├── bastion_instance
        │   │   ├── main.tf
        │   │   ├── outputs.tf
        │   │   └── variables.tf
        │   ├── dbaas
        │   │   ├── main.tf
        │   │   ├── outputs.tf
        │   │   └── variables.tf
        │   ├── network
        │   │   ├── main.tf
        │   │   ├── outputs.tf
        │   │   └── variables.tf
        │   └── ords
        │       ├── main.tf
        │       ├── outputs.tf
        │       ├── README.md
        │       ├── remote-exec.tf
        │       └── variables.tf
        ├── outputs.tf
        ├── providers.tf
        ├── terraform.tfvars
        ├── userdata
        │   ├── bootstrap.sh
        │   ├── files_init
        │   │   └── config_init.sh
        │   ├── files_init.zip
        │   ├── files_jetty
        │   │   ├── apex_add_db.sh
        │   │   ├── apex_inst_check.sql
        │   │   ├── apex_setup_base.exp
        │   │   ├── config_apex1.sql
        │   │   ├── config_apex2.sql
        │   │   ├── config_cert.sh
        │   │   ├── config_jetty_apex.sh
        │   │   ├── config_jetty_ca-ssl.sh
        │   │   ├── config_jetty_init.sh
        │   │   ├── config_jetty_ords.sh
        │   │   ├── dns_ocidns.sh
        │   │   ├── ords_add_db.sh
        │   │   ├── ords_pu_check.sql
        │   │   ├── ords_setup_base.exp
        │   │   ├── ords_validate_base.exp
        │   │   ├── pw_prof_chk.sql
        │   │   ├── pw_verify_base.sql
        │   │   ├── pw_verify_null.sql
        │   │   ├── start_ords.sh
        │   │   └── stop_ords.sh
        │   └── files_jetty.zip
        └── variables.tf

    
## **STEP 1:** Create Stack    
1. Navigate to the resource manager tab in OCI and select **Stacks**. 
    ![](./images/select-stacks.png)

    Then select **Create Stack** to create a new stack to import the "DR-ORDS-RW.zip” zip file.
    ![](./images/create-stack.png)

2. Select **My Configuration**, choose the **.ZIP FILE** button, click **Browse** and import the zip file into the stack 
    ![](./images/stack-info.png)

3. Input the configuration for the instances.
    ![](./images/ResourceManager-Input-Basic.PNG)

4. Input the configuration for the vcn.
    ![](./images/ResourceManager-Network.PNG)

5. Copy your public and private key. Make sure you are using the correct format.
    ![](./images/ResourceManager-Keys.PNG)

6. Input the configuration for the object storage. Make sure to copy the following link [apex](https://objectstorage.us-ashburn-1.oraclecloud.com/p/MieIN2uqptIk7iiVZG16a5pabojWpeDrkkk-HMowLlG0joiD6WET0tPA6GPstEVF/n/c4u03/b/solutions-library/o/apex_20.1.zip) into the URL\_APEX\_FILE field.
   Make sure to copy the following link [ords](https://objectstorage.us-ashburn-1.oraclecloud.com/p/10lp9s-Kd2pNy9otaToA6UloTJjoat5V5IAJB_tUQtcabWvm6OvKkLAYM0-gbeL3/n/c4u03/b/solutions-library/o/ords.war) into the URL\_ORDS\_FILE field.
    ![](./images/ResourceManager-ObjectStorage.PNG)

7. Review & click on the **Create** button
    ![](./images/ResourceManager-Review.PNG)

## **STEP 2:** Plans

1.  Select **Plan** from the Terraform Actions dropdown menu.
    ![](./images/ResourceManager-Plan-2.PNG)

2.  Make sure everything looks okay and then select **Plan**
    ![](./images/ResourceManager-Plan-3.PNG)

3.  Wait until the icon turns green.
    ![](./images/ResourceManager-Plan-4.PNG)

## **STEP 3:** Apply

1.  Select **Apply** from the Terraform Actions dropdown menu.
    ![](./images/ResourceManager-Apply-1.PNG)

2.  Wait until the icon turns green.
    ![](./images/ResourceManager-Apply-2.PNG)


You may now **proceed to the next lab.**

## Troubleshooting
   A possible issue you make face is not having enough resources. Test to make sure 
   that you can create a drg manual in both regions you want to deploy the resources
   in.

## Acknowledgements
- **Author** - Saul Chavez
- **Last Updated by/date** Will Bullock, November 2020
- **Lab Expiry Date** - 11/30/2021

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/oracle-maa-dataguard-rac). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.


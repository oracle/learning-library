# Provision the Application Database on OCI with DBaaS

## Introduction: 

This lab with guide you through provisioning a Application Database

Estimated Lab Time: 30-35 min including ~25-30 min provisioning time.

### Objectives

In this lab you will:

- Provision the Application Database as a Database VM.
- Create a Security List with proper ports open


## **STEP 1:** Provision the Database System

1. Go to **Database -> Bare Metal, VM and Exadata**

  ![](./images/provision-db-10.png =40%x*)

2. Click **Create DB System**

  ![](./images/provision-db-11.png)

3. Make sure you are in the **SOAMPCompartment** and name your **Database System**

  ![](/images/provision-db-12.png)

4. Select an Availability Domain or keep the default, keep the default **Virtual Machine** and select a **Shape** that is available.

  ![](./images/provision-db-13-ad-shape.png =70%x*)

5. Keep the defaults for **Total node count** and **Database Edition**

  ![](./images/provision-db-14.png =70%x*)

6. Select **Logical Volume Manager** 

  ![](./images/db-lvm.png =70%x*)

7. Keep defaults for **Storage**

  ![](./images/provision-db-16-storage.png =70%x*)

8. Add your **SSH public key** 

  ![](./images/provision-db-17-ssh.png =70%x*)

9. Keep the default **License Included**

  ![](./images/provision-db-18-license.png =70%x*)

10. Select the **Virtual cloud network** `SOAMP1VCN`, the **Client subnet** `Private Subnet-SOAMP1VCN(regional)` and set a **Hostname prefix** of `soamp2db`

  ![](./images/db-network.png =70%x*)

11. Click **Next**

12. Name the Database `SOAMP2DB`

  ![](./images/db-name.png =70%x*)

13. Select the **Database version** `19c`

  ![](./images/db-version.png =70%x*)

14. Name the **PDB** `PDB1`

  ![](./images/db-pdbname.png =70%x*)


15. Enter and confirm the **SYS Database password**: 

    you can create your own password followed all instructions or you can copy below

    ```
    <copy>
    WELcome##123
    </copy>
    ```

  ![](./images/db-password.png =70%x*)

16. Keep the default of **Transaction Processing** for **Workload type** and **Backup**

17. Optionally you can select **Enable automatic backups** for the period of `60 days` and scheduling `Anytime` and 

  ![](./images/provision-db-21.png)

18. Click **Create DB System**

  This will usually take up to 40 minutes to provision.

  ![](./images/provision-db-22.png)

## **STEP 2:** Check the status of the database provisioning

Before you can proceed to the next lab, you need to check that the DB has been fully provisioned

1. Go to **Oracle Databases -> BM, VM, Exadata**

2. Make sure you are in the correct Compartment.

3. Check the status of the database is `Available` or wait until it is before proceeding to the next lab.

  ![](./images/db-available.png =70%x*)

You may proceed to the next lab.

## Acknowledgements

 - **Author** - Akshay Saxena, September 2020
 - **Last Updated By/Date** - Akshay Saxena, September 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.

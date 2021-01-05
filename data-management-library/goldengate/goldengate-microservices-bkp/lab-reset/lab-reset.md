# Reset Lab

## Introduction
This lab will reset the GoldenGate Microservices Workshop and allow you to start from the beginning if required.
........

*Estimated Lab Time*:  15 minutes

### Objective:

In this lab we will demonstrate how to ***RESET*** the deployments, which will remove the deployments and any Extracts, Replicats and Distribution Paths that are under those deployments.
If needed there is a second step to recreate the deployments.  This will not create any Extracts, Replicats or Distribution Paths.
Also, if needed there is a third step to refresh the databases.

### Prerequisites
This lab assumes you have:
- A Free Tier, Paid or LiveLabs Oracle Cloud account
- SSH Private Key to access the host via SSH
- You have completed:
    - Lab: Generate SSH Keys
    - Lab: Prepare Setup
    - Lab: Environment Setup
    - Lab: Configure GoldenGate

## **STEP 1**: Remove Deployments.

1. If you don't have a terminal window opened yet, right click on the Desktop of the VNC session and se

    ![](./images/terminal3.png " ")

                       

2.  From the Terminal window in the VNC Console, navigate to the Reset directory under ~/OGG181_WHKSHP.

        $ cd ~/OGG181_WHKSHP/Reset


3. From here you will run the script to delete deployment.  In order to do this, you will need to run the ***delete_deployment.sh*** script. To run this script, you need to execute the following at the command line:

Example of of parameters. See table below
        $ sh delete_deployment.sh A1 A2 A3 A4 A5 A6 A6 A7 A8

Once the script is executed, you will see a statement saying that the ***“Successfully Setup Software.”*** indicates that deployment has been deleted.

Below example will guide to how to delete the deployment **"Target"** - (***SanFran***)

|    Argument    | DESCRIPTION	       	        |       Example	      |
|-----------------|-----------------------------|---------------------|
|      A1         |Deployment Name	            |   SanFran           |
|      A2         |Admin User Password	        |   Welcome1          |
|      A3         |Service Manager Port     	|   16000             |
|      A4         |Administration Server Port	|   17001             |
|      A5         |Distribution Server Port 	|   17002             |
|      A6         |Receiver Server Port         |   17003             |
|      A7         |Metrics Server Port          |   17004             |
|      A8         |Metrics Server UDP Port      |   17005             |

4.  From the terminal enter **"./delete_deployment.sh SanFran welcome1 16000 17001 17002 17003 17004 17005"**

        [oracle@OGG181DB183 Reset]$ ./delete_deployment.sh SanFran Welcome1 16000 17001 17002 17003 17004 17005
        Successfully Setup Software.
        [oracle@OGG181DB183 Reset]$

Below example will guide to how to delete the deployment **"Source"** - (***Atlanta***).

|    Arguement    | DESCRIPTION	       	        |       VALUES	      |
|-----------------|-----------------------------|---------------------|
|      A1         |Deployment Name	            | 	Atlanta	          |
|      A2         |Admin User Password	        |	Welcome1          |
|      A3         |Service Manager Port     	| 	16000	          |
|      A4         |Administration Server Port	| 	16001	          |
|      A5         |Distribution Server Port 	|	16002	          |
|      A6         |Receiver Server Port         |   16003    	      |
|      A7         |Metrics Server Port          |   16004             |
|      A8         |Metrics Server UDP Port      |   16005             |

5.  From the terminal enter **"./delete_deployment.sh Atlanta welcome1 16000 16001 16002 16003 16004 16005"**

        [oracle@OGG181DB183 Reset]$ ./delete_deployment.sh Atlanta Welcome1 16000 16001 16002 16003 16004 16005
        Successfully Setup Software.
        [oracle@OGG181DB183 Reset]$

## **STEP 2**: Create Deployments (if needed)

1. Run the **build_deployments.sh** script.  This script does the following:

    -   Creates the ***Atlanta*** and  ***SanFran*** deployments using a response file for OGGCA.
    -   Creates the Credentials for the deployments for uni-directional replication (Atlanta to SanFran).

## **STEP 3**: Refresh Databases (if needed)

In this step you will run several scripts.

1. Run the **clone_pdb_reset.sh** script.  This script drops the source and target PDBs.

        [oracle@OGG181DB183 db]$ ./clone_pdb_reset.sh

2. Run the **clone_pdb_181.sh** script.  This script recreates the source by cloning a base PDB.

        [oracle@OGG181DB183 db]$ ./clone_pdb_181.sh

3. Run the **clone_pdb_182.sh** script.  This script recreates the target by cloning the source PDB.  
        ** NOTE: ** This is a clone of the 181 PDB, so you must run the ** clone_pdb_181.sh ** script first.

        [oracle@OGG181DB183 db]$ ./clone_pdb_182.sh

You may now *proceed to the next lab*.

## Learn More

* [GoldenGate Microservices](https://docs.oracle.com/en/middleware/goldengate/core/19.1/understanding/getting-started-oracle-goldengate.html#GUID-F317FD3B-5078-47BA-A4EC-8A138C36BD59)


## Acknowledgements
* **Author** - Brian Elliott, Data Integration, November 2020
* **Contributors** - Zia Khan
* **Last Updated By/Date** - Brian Elliott, December 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
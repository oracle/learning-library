# Initialize Environment

## Introduction

In this lab we will review and startup all components required to successfully run this workshop.

*Estimated Lab Time:* 10 Minutes.

### Objectives
- Initialize the workshop environment.

### Prerequisites
This lab assumes you have:
- A Free Tier, Paid or LiveLabs Oracle Cloud account
- SSH Private Key to access the host via SSH
- You have completed:
    - Lab: Generate SSH Keys (*Free-tier* and *Paid Tenants* only)
    - Lab: Prepare Setup (*Free-tier* and *Paid Tenants* only)
    - Lab: Environment Setup

## **Step 0**: Running your Lab
### Access the graphical desktop
For ease of execution of this workshop, your instance has been pre-configured for remote graphical desktop accessible using any modern browser on your laptop or workstation. Proceed as detailed below to login.

1. Launch your browser to the following URL

    ```
    URL: <copy>http://[your instance public-ip address]:8080/guacamole</copy>
    ```

2. Provide login credentials

    ```
    Username: <copy>oracle</copy>
    ```
    ```
    Password: <copy>Guac.LiveLabs_</copy>
    ```

    ![](./images/guacamole-login.png " ")

    *Note*: There is an underscore `_` character at the end of the password.

3. Click on *Terminal* icon on the desktop to start a terminal

    ![](./images/guacamole-landing.png " ")

### Login to Host using SSH Key based authentication
While all command line tasks included in this workshop can be performed from a terminal session from the remote desktop session as shown above, you can optionally use your preferred SSH client.

Refer to *Lab Environment Setup* for detailed instructions relevant to your SSH client type (for example, Putty on Windows or Native such as terminal on Mac OS).


## **Step 1**: Start the Database
1. From any of the terminal session started above, go to folder /home/opc:

    ```
    <copy>
    cd /home/opc

    </copy>
    ```
2. Run the script file env_setup.sh to initialize the environment variables. This will setup the environment variables needed to start the Services.

    ```
    <copy>
    source env_setup.sh
    </copy>
    ```
3. Run the script file to start the database.

    ```
    <copy>
    ./db_start.sh
    </copy>
    ```

This will start the database and listener. The script could take 2-5 minutes to run.

## **STEP 2**: Start the Oracle WebLogic Server
1. Open a terminal on noVNC Remote Desktop and set up the environment variables.

    ```
    <copy>
    source /home/opc/env_setup.sh
    </copy>
    ```

2. Navigate to the Domain Home.

    ```
    <copy>
    cd $DOMAIN_HOME
    </copy>
    ```

3. Run startWebLogic.sh script. This will start the WebLogic services.

    ```
    <copy>
    ./startWebLogic.sh
    </copy>
    ```

This script could take 2-5 minutes to start the WebLogic server.

## **STEP 3**: Start the Oracle GoldenGate Veridata Server
You can start the Veridata server only after the WebLogic server is up and running.

1. Open a terminal on noVNC Remote Desktop and set up the environment variables.

    ```
    <copy>
    source /home/opc/env_setup.sh
    </copy>
    ```

2. Navigate to the Veridata Domain Home.

    ```
    <copy>
    cd $DOMAIN_HOME/veridata/bin
    </copy>
    ```

3. Run veridataServer.sh script and provide the WebLogic credentials when prompted.    This will start the Oracle GoldenGate Veridata server.

    ```
    <copy>
    ./veridataServer.sh start
    </copy>
    ```

   **User Name**: weblogic

   **Password**: welcome1

This script could take 2-5 minutes to start the Veridata server.

## **STEP 4**: Start the Oracle GoldenGate Veridata Agent

1. Open a terminal on noVNC Remote Desktop and set up the environment variables.

     ```
     <copy>
     source /home/opc/env_setup.sh
     </copy>
     ```

2. Navigate to the Veridata Agent location.

     ```
     <copy>
     cd /home/opc/agent1
     </copy>
     ```

3.  Run agent.sh script. This will start the Oracle GoldenGate Veridata agent.

    ```
    <copy>
    ./agent.sh run
    </copy>
    ```

You may now [proceed to the next lab](#next).

## Acknowledgements
* **Author** - Anuradha Chepuri, Principal UA Developer, Oracle GoldenGate User Assistance
* **Contributors** -  Nisharahmed Soneji, Senior Principal Product Manager and Sukin Varghese, Senior Member of Technical staff
* **Last Updated By/Date** - Anuradha Chepuri, Oracle GoldenGate User Assistance, June 2021

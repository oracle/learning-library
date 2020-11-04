# Sample Schema Setup

## Introduction
This lab will show you how to setup your database schemas for the subsequent labs.

### Prerequisites
- An Oracle LiveLabs or Paid Oracle Cloud account
- Lab: Generate SSH Key
- Lab: Build a DB System
  
## **STEP**: Install Sample Data

In this step, you will install a selection of the Oracle Database Sample Schemas.  For more information on these schemas, please review the Schema agreement at the end of this lab.

By completing the instructions below the sample schemas **SH**, **OE**, and **HR** will be installed. These schemas are used in Oracle documentation to show SQL language concepts and other database features. The schemas themselves are documented in Oracle Database Sample Schemas [Oracle Database Sample Schemas](https://www.oracle.com/pls/topic/lookup?ctx=dblatest&id=COMSC).

Copy the following commands into your terminal. These commands download the files needed to run the lab.  (Note: *You should run these scripts as the oracle user*.  Run a *whoami* to ensure the value *oracle* comes back.)

1.  If you aren't already logged in to the Oracle Cloud, open up a web browser and re-login to Oracle Cloud. 

2.  Start Cloudshell
   
    *Note:* You can also use Putty or MAC Cygwin if you chose those formats in the earlier lab.  
    ![](../clusterware/images/start-cloudshell.png " ")

3.  Connect to node 1 as the *opc* user (you identified the IP address of node 1 in the Build DB System lab). 

    ````
    ssh -i ~/.ssh/sshkeyname opc@<<Node 1 Public IP Address>>
    ````
    ![](../clusterware/images/racnode1-login.png " ")

4.  Switch to the oracle user
   
    ````
    <copy>
    sudo su - oracle
    </copy>
    ````

    Note: If you are running in Windows using putty, ensure your Session Timeout is set to greater than 0.
5.  Get the seutp files
    ````
    <copy>    
    whoami   
    cd /home/oracle/

    wget https://objectstorage.uk-london-1.oraclecloud.com/p/vKlh5hZ1wX-YB4K-ou5zNrL4GCsfQmj1z1y8LhIsFdU/n/lrojildid9yx/b/labtest_bucket/o/setupDB.sh.gz

    gunzip setupDB.sh.gz;

    chmod +x setupDB.sh
    </copy>
    ````
    ![](./images/setup-num5.png " " )

6. The script **setupDB.sh** assumes the password for SYS and SYSTEM user. Edit the script using vi.

    ````
    vi setupDB.sh
    ````
    ![](./images/setup-num6.png " " )

7. Replace the db_pwd with the password you entered when your database was setup.

    ````
    # Pwds may need to be changed
    db_pwd="W3lc0m3#W3lc0m3#"
    ````
     ![](./images/setup-num7.png " " )

8. To save the file press the **esc** key and **wq!** to save the file.
   
9.  No other lines need to be changed.  Run the **setupDB.sh** script

    ````
    <copy>
    /home/oracle/setupDB.sh
    </copy>
    ````

    ![](./images/setup-num7.png " " )

    *Note:* There may be some drop user errors, ignore them.  Please be patient as this script takes some time.

Congratulations! Now you have the data to run subsequent labs.

You may now *proceed to the next lab*.

## Oracle Database Sample Schemas Agreement

Copyright (c) 2019 Oracle

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

*THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.*

## Acknowledgements

- **Author** - Troy Anthony, DB Product Management
- **Contributors** - Anoosha Pilli, Anoosha Pilli, Kay Malcolm
- **Last Updated By/Date** - Kay Malcolm, October 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/oracle-maa-dataguard-rac). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.

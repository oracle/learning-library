# Sample Schema Setup

## Introduction
This lab will show you how to setup your database schemas for the subsequent labs.

## **Step**: Install Sample Data

In this step, you will install a selection of the Oracle Database Sample Schemas.  For more information on these schemas, please review the Schema agreement at the end of this lab.

By completing the instructions below the sample schemas **SH**, **OE**, and **HR** will be installed. These schemas are used in Oracle documentation to show SQL language concepts and other database features. The schemas themselves are documented in Oracle Database Sample Schemas [Oracle Database Sample Schemas](https://www.oracle.com/pls/topic/lookup?ctx=dblatest&id=COMSC).

1.  Copy the following commands into your terminal. These commands download the files needed to run the lab.  (Note: *You should run these scripts as the opc user*.  Run a *whoami* to ensure the value *opc* comes back.  If you are stil the oracle user, type the **exit** command to return back to opc)

    Note: If you are running in Windows using putty, ensure your Session Timeout is set to greater than 0.
    ```
    whoami
    ```

    ````
    <copy>
    cd /home/opc/

    wget https://objectstorage.us-ashburn-1.oraclecloud.com/p/3chG0fCfimn_Dq6kER9r0qOBqjPLfM3I4b3l0EaN2w4/n/c4u03/b/labfiles/o/nfscripts.zip

    unzip nfscripts.zip;

    chmod +x *.sh

    /home/opc/setupNF.sh
    </copy>
    ````

    ![](./images/step1.1-setupscript1.png " " )

    ![](./images/setupNFresults.png " " )

2.  Switch now to the oracle user and run oraenv to set up your environment.  Enter *ORCL* when prompted for the SID.
    ````
    <copy>
    sudo su - oracle
    . oraenv
    </copy>
    ORCL
    ````
    ![](./images/oraenv.png " " )

3.  Install the Sample Schemas by running the script below. Accept the default SID *ORCL* when prompted.

    ````
    <copy>
    . /home/oracle/setupNF_DB.sh
    </copy>
    ````

    ![](./images/setupNFscriptresults.png " " )

Congratulations! Now you have the environment to run the labs.

You may now *proceed to the next lab*.

## Oracle Database Sample Schemas Agreement

Copyright (c) 2019 Oracle

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

*THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.*

## **Acknowledgements**

- **Author** - Troy Anthony, DB Product Management
- **Contributors** - Anoosha Pilli, Anoosha Pilli, Kay Malcolm
- **Last Updated By/Date** - Kay Malcolm, August 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.

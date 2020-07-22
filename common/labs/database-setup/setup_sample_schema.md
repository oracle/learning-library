# Setup Sample Schemas- LiveLabs #

## Introduction
This lab will show you how to install a portion of the Sample Schemas in your database.

## Step 1: Install Sample Data

In this step, you will install a selection of the Oracle Database Sample Schemas.  For more information on these schemas, please review the Schema agreement at the end of this lab.

By completing the instruction below the sample schemas **SH**, **OE**, and **HR** will be installed. These schemas are used in Oracle documentation to show SQL language concepts and other database features. The schemas themselves are documented in Oracle Database Sample Schemas [Oracle Database Sample Schemas](https://www.oracle.com/pls/topic/lookup?ctx=dblatest&id=COMSC).

1.  Copy the following commands into your terminal. These commands download the files needed to run the lab.

    Note: If you are running in Windows using putty, ensure your Session Timeout is set to greater than 0.

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

    ![](./images/step1.1-setupscript2.png " " )

2.  Install the Sample Schemas.

    ````
    <copy>
    sudo su - oracle
    . /home/oracle/setupNF_DB.sh
    </copy>
    ````

    ![](./images/step1.2-setupcomplete.png " " )

Congratulations! Now you have the environment to run the labs.

## Oracle Database Sample Schemas Agreement

Copyright (c) 2019 Oracle

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

*THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.*

## Acknowledgements

- **Author** - Troy Anthony, DB Product Management
- **Last Updated By/Date** - Troy Anthony, May 21 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.

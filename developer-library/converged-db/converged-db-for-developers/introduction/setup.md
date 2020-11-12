# Environment Setup 

**Before starting this lab, please make sure prerequisites are completed which includes installation of Putty, Tiger vnc viewer and Postman on your local desktop.**

## Introduction

This lab will show you that how to start database instance and listener from putty window,also this covers how to setup vncserver and sqldeveloper etc. 


## Step 1: Start the Database

1. Open up putty and create a new connection. Enter the IP address assigned to your instance.

  **Note**: **Make sure VPN is not connected.**

 ![](./images/putty_snap.png " ") 

2. Load the ppk file provided to you. Expand Connection then SSH and select auth.
   
  Click on Browse and select the file.
 ![](./images/putty_snap1.png " ")

3. Click on Connection and mention 60 in the box “ Seconds between keep alives(0 to turn off)”. Next, click on open.
 ![](./images/putty_snap2.png " ")

4. Click Yes once prompted for Putty security alert 

 ![](./images/putty_snap3.png " ")

5. Once putty is started, provide below details-
  - Login as: opc
  - sudo su - oracle

 ![](./images/putty_snap4.png " ")

6. Check for the oratab file and get the SID  and the oracle home details for the DB to start.

   ````
    <copy>
   cat /etc/oratab 
    </copy>
   ````

   ![](./images/putty_snap5.png " ")


7. Start the database
 
  ````
    <copy>
   . oraenv
   ConvergedCDB
   sqlplus "/as sysdba"
   startup 
    </copy>
   ````

   ![](./images/putty_snap6.png " ")

8. Check for the pdbs status and open it
  
  ````
    <copy>
   show pdbs
   alter pluggable database all open;
   show pdbs 
    </copy>
   ````

   ![](./images/putty_snap7.png " ")

9.	Give a Exit
 
 ````
    <copy>
   exit
    </copy>
   ````

10. Get the complete hostname of the server.

````
    <copy>
   cat /etc/hosts
    </copy>
   ````
 ![](./images/putty_snap8.png " ")

  **Note:**In above screenshot red highlighted one is the full qualified hostname. Gather similar details from your respective instance.

11.	Open tnsnames.ora in vi-editor and replace the old hostname by new hostname

````
    <copy>
   cd $ORACLE_HOME/network/admin
   vi tnsnames.ora
    </copy>
   ````
Press Esc and type as below
````
    <copy>
   :%s/convergeddb.suxxxxx.XX.oraclevcn.com/full_qualified_hostname
    </copy>
   ````
 Hit a Enter, notice the changes. Again press Esc and type as below to save the file

````
    <copy>
   :wq!
    </copy>
   ````
12.	Similarly do the same changes for listener.ora through vi-editor

 ````
    <copy>
   vi listener.ora
    </copy>
   ````
Press Esc and type as below
````
    <copy>
   :%s/convergeddb.suxxxxx.XX.oraclevcn.com/full_qualified_hostname
    </copy>
   ````
 Hit a Enter, notice the changes. Again press Esc and type as below to save the file

````
    <copy>
   :wq!
    </copy>
   ````
13.	Check for the listener name. 
````
    <copy>
   cat listener.ora
    </copy>
   ````

![](./images/putty_snap9.png " ")

14.	Start the listener
````
    <copy>
   lsnrctl start LISTENER_CONVERGEDDB
    </copy>
   ````
![](./images/putty_snap10.png " ")

15.	Check the listener status
````
    <copy>
   lsnrctl status LISTENER_CONVERGEDDB
    </copy>
   ````
![](./images/putty_snap11.png " ")

16.	Register the service into database. Connect to sqlplus. Please update the fully\_qualified\_hostname in the alter command. 
````
    <copy>
   sqlplus " / as sysdba"
   alter system set local_listener='(ADDRESS = (PROTOCOL=TCP)(HOST=<\fully_qualified_hostname>)(PORT=1521))';
   alter system register;
    </copy>
   ````
![](./images/putty_snap12.png " ")

17.	After registering do a exit  and  check the listener status.
````
    <copy>
   lsnrctl status LISTENER_CONVERGEDDB
    </copy>
   ````
![](./images/putty_snap13.png " ")

18.	Check if the database and listener is up and running
````
    <copy>
   ps -ef|grep pmon
   ps -ef|grep tns

    </copy>
   ````
![](./images/putty_snap14.png " ")

## Step 2: Start VNC  

1. Run the below command and start vncserver as **oracle** user. 

````
    <copy>
   vncserver
   </copy>
   ````
![](./images/vnc1.png " ")

2. Check if the  vncserver process is running.
  ````
    <copy>
   ps -ef|grep vnc
   </copy>
   ````
![](./images/vnc2.png " ")

3. Lets do the tunnelling  for the  port mentioned in the vnc process

Go to putty settings -> SSH -> Tunnels and provide the source port and destination details.

![](./images/vnc3.png " ")

4.	Then click on Add, Once we click on add we can see an entry in the forwarded ports, then click on Apply.

![](./images/vnc4.png " ")

5.	Start the VNC viewer.Provide the VNC server details, click on connect and provide the password as “vncserver”.
![](./images/vnc5.png " ")

6.	Open a terminal in vnc and follow below steps to start the sqldeveloper.
````
    <copy>
   cd /u01/graph/jdk-11.0.5/
   export JAVA_HOME=/u01/graph/jdk-11.0.5/
   echo $JAVA_HOME
   sqldeveloper
   </copy>
   ````

## Acknowledgements

- **Authors** - Balasubramanian Ramamoorthy, Arvind Bhope
- **Contributors** - Laxmi Amarappanavar, Kanika Sharma, Venkata Bandaru, Ashish Kumar, Priya Dhuriya, Maniselvan K.
- **Team** - North America Database Specialists.
- **Last Updated By** - Kay Malcolm, Director, Database Product Management, June 2020
- **Expiration Date** - June 2021   

**Issues-**
Please submit an issue on our [issues](https://github.com/oracle/learning-library/issues) page. We review it regularly.
  



















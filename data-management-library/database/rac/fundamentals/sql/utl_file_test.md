# PL/SQL Packages

## Introduction
This lab walks you through the operation of PL/SQL packages in a clustered environment

Estimated Lab Time: 10 Minutes

### Prerequisites
- An Oracle LiveLabs or Paid Oracle Cloud account
- Lab: Generate SSH Key
- Lab: Build a DB System
- Lab: Fast Application Notification
- Lab: Install Sample Schema
- Lab: Services
  
### About PL/SQL Packages
With any PL/SQL operations on RAC you must be aware that the code could execute on any node where its service lives. This could also impact packages like DBMS\_PIPE, UTL\_MAIL, UTL\_HTTP (proxy server source IP rules for example), or even DBMS\_RLS (refreshing policies).

In this example we will use the **UTL\_FILE** package as representative of any PL/SQL package that actions outside the database.

In using the **UTL\_FILE** package, PL/SQL programs can read and write operating system text files. UTL\_FILE provides a restricted version of operating system stream file I/O.

The set of files and directories that are accessible to the user through UTL\_FILE is controlled by a number of factors and database parameters. Foremost of these is the set of directory objects that have been granted to the user.

Assuming the user has both READ and WRITE access to the directory object USER\_DIR, the user can open a file located in the operating system directory described by USER\_DIR, but not in subdirectories or parent directories of this directory.

Lastly, the client (text I/O) and server implementations are subject to operating system file permission checking.

UTL\_FILE provides file access both on the client side and on the server side. When run on the server, UTL\_FILE provides access to all operating system files that are accessible from the server. On the client side, UTL\_FILE provides access to operating system files that are accessible from the client.

## **STEP 1:**  Create a DIRECTORY OBJECT and write a file in this location

1.  If you aren't already logged in to the Oracle Cloud, open up a web browser and re-login to Oracle Cloud. 

2.  Start Cloudshell
    
    *Note:* You can also use Putty or MAC Cygwin if you chose those formats in the earlier lab.  
    ![](../clusterware/images/start-cloudshell.png " ")

3.  Connect to **node 1** as the *opc* user (you identified the IP address of node 1 in the Build DB System lab). 

    ````
    ssh -i ~/.ssh/sshkeyname opc@<<Node 1 Public IP Address>>
    ````
    ![](../clusterware/images/racnode1-login.png " ")

4. Connect to the pluggable database, **PDB1** as the *SH* user

    ````
    <copy>
    sudo su - oracle
    sqlplus sh/W3lc0m3#W3lc0m3#@//racnode-scan.tfexsubdbsys.tfexvcndbsys.oraclevcn.com/pdb1.tfexsubdbsys.tfexvcndbsys.oraclevcn.com
    </copy>
    ````

5. As the SH user create a DIRECTORY OBJECT and use UTL\_FILE to write a file in this directory

    ````
    <copy>
    create directory orahome as '/home/oracle';

    declare fl utl_file.file_type;
    begin
        fl := utl_file.fopen('ORAHOME','data.txt','w');
        utl_file.put_line(fl, 'Some sample data for an oracle test.', TRUE);
        utl_file.fclose(fl);  
    end;
    /
    </copy>
    ````
    ![](./images/dir-num5.png " " )


## **STEP 2:** Reconnect to SQL\*Plus and read the file you just created

1. Connect to the pluggable database, **PDB1** as the SH user and read the file **data.txt** 10 or 20 times

    ````
    <copy>
    declare fl utl_file.file_type;
    begin
        fl := utl_file.fopen('ORAHOME','data.txt','r');
        utl_file.get_line(fl, data);
        utl_file.fclose(fl);  
    end;
    /
    exit;
    </copy>
    ````

2. Did some of the *get_line* commands fail? Why?

   Use operating system commands to examine the directory **/home/oracle** on each of the cluster nodes
    ````
    <copy>
    cd /home/oracle
    ls -al data.txt
    </copy>
    ````
    ![](./images/sched-1.png " " )

## Acknowledgements
* **Authors** - Troy Anthony, Anil Nair
* **Contributors** - Kay Malcolm
* **Last Updated By/Date** - Kay Malcolm, October 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/oracle-maa-dataguard-rac). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.

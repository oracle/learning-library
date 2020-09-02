

#Validate Provisioning

##Validate the DBCS VM

1. Open the navigation menu. Under **Database** section,  click **Bare Metal, VM, and Exadata**.![image-20200216172240506](./img/image-20200216172240506.png)
2. There is a DB system name DBCS*yyyymmddhhmm*. The sufix number is the time when you provision the  database. Click the DB system name link.![image-20200216191624066](./img/image-20200216191624066.png)
3. In the DB system Details page, You can review the general information like **Shape**, **Database software edition**, **License Type**, **Host Domain Name**, etc. In the **Databases** section there is a database named **ORCL**. You can find the **DB Unique Name**, **Workload Type**, **Database Version**, etc. Click the **Nodes** under the **Resources**.![image-20200216191957002](./img/image-20200216191957002.png)
4. In the **Notes** section, you can find information like **Node Name**, **Public IP Address**, **Private IP Address**, etc. ![image-20200216202043453](./img/image-20200216202043453.png)
5. Now you can test to connect the database using database client tools. The connect string like:

```
sqlplus username/password@<public ip>:1521/<db unique name>.<domain>
```

For example:

```
$ sqlplus system/WElcome_123#@132.145.95.84:1521/ORCL_icn1sc.sn202002161001.vcn202002161001.oraclevcn.com

SQL*Plus: Release 18.0.0.0.0 Production on Sun Feb 16 20:29:32 2020
Version 18.1.0.0.0

Copyright (c) 1982, 2018, Oracle.  All rights reserved.

Last Successful login time: Sun Feb 16 2020 19:42:41 +08:00

Connected to:
Oracle Database 19c EE Extreme Perf Release 19.0.0.0.0 - Production
Version 19.5.0.0.0

SQL> 
```



##Release the stack's resources

After you complete all the labs, you can running a destroy job to release associated resources of the stack. 

1. Back to the **Stack Details** page. Go to **Terraform Actions** and select **Destroy**.![image-20200216204056265](./img/image-20200216204056265.png)
2. In the Destroy dialog, accept the default values and click **Destroy**.![image-20200216204136345](./img/image-20200216204136345.png)
3. You can monitor the status and review the results of a destroy job by viewing the state or the logs.![image-20200216204321102](./img/image-20200216204321102.png)
4. Wait until the state change to succeeded, all the resources create by this stack are released. You can then delete the stack.![image-20200216205058935](./img/image-20200216205058935.png)
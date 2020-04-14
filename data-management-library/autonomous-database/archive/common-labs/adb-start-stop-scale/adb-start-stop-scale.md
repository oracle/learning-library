![](./media/adb-certification-title.png)
# Managing and maintaining the Autonomous Database

## Table of Contents

- [Module 1: Starting the Autonomous Database](#module-1--starting-the-autonomous-database)
- [Module 2: Changing the ADMIN password](#module-2--changing-the-admin-password)
- [Module 3: Creating Autonomous Database Users](#module-2--creating-autonomous-database-users)
- [Module 4: Stopping the Autonomous Database](#module-1--stopping-the-autonomous-database)

***** 


## Module 1:  Starting the Autonomous Database

If your database is not running, please start it up using the following steps:

1. From the **Details** page of your ADB service, click **Start** to start your
service.

![](media/adb-start-db.png)
<p align="center">Figure 1-1</p>

2. Click **Start** again when prompted for confirmation.

![](media/a1684875990ec5bc69ad3e3959ff61f0.png)
<p align="center">Figure 1-2</p>

The ADB service will take a few seconds to start. For example, if you
provisioned ATP service, you would notice the status of **STARTING** as follows:

![](media/adb-starting-msg.png)
<p align="center">Figure 1-3</p>

When the service is started, the status will change to **AVAILABLE**.

![](media/adb-available-msg.png)
<p align="center">Figure 1-4</p>

[Back to Top](#table-of-contents)

## Module 2: Changing the ADMIN password

You many need to change the ADMIN password. 

You can change the password from the details page under **ACTIONS** or click on **Administration** --> **Set Administrator Password**.  

![](media/adb-setadmin-pw.png)
<p align="center">Figure 2-1</p>

Update the password.

![](media/adb-newadmin-pw.png)
<p align="center">Figure 2-1</p>

[Back to Top](#table-of-contents)

## Module 3: Creating Autonomous Database Users

To create users in your database, connect to the database as the ADMIN use SQL Developer Web tool.  From your database details page, click on **Service Console** --> **Development** --> **SQL Developer Web**.  

![](media/adb-sqldevweb-login.png)
<p align="center">Figure 3-1</p>

As the ADMIN user run the following SQL statement.  You can use any name for the new user.

>create user tammy;

>alter user tammy identified by AABBcc123456# account unlock;

>grant create session, dwrole to tammy;



![](media/adb-createuser-tammy.png)
<p align="center">Figure 3-2</p>

Was your user created?

> select * from all_users where usernmae ='TAMMY';

![](media/adb-show-newuser.png)
<p align="center">Figure 3-3</p>


To allow that user to access the SQL Developer Web, you will need to REST enable it.  Execute the following:

BEGIN

    ords_admin.enable_schema (
        p_enabled               => TRUE,
        p_schema                => 'THATJEFFSMITH',
        p_url_mapping_type      => 'BASE_PATH',
        p_url_mapping_pattern   => 'tjs',
        p_auto_rest_auth        => TRUE
    );
    COMMIT;
END;
/

![](media/adb-enablenewuser-sqldevweb.png)
<p align="center">Figure 3-4</p>

If you run this above code, you’ll be able to login to SQL Developer Web with the new usser. Just mind that the URL will look have to look something like this…


https://yourservicedomain-1.oraclecloudapps.com/ords/tammy/_sdw/?nav=worksheet

Copy the URL from your browser that you are currently logged into as ADMIN in SQL Developer web.

![](media/adb-adminurl.png)
<p align="center">Figure 3-5</p>

Now paste that URL to another browswer window and change /admin/ to /tammy/

Note that I have /tammy/ in the URL? That’s the p_url_mapping_pattern. If you go to the same URL but with /admin/ in the link and try to login as TAMMY/AABBcc123456#, you will get bad user/password.

Log into SQL Developer Web as your new user and password that you assigned to them.

![](media/adb-changeadmin-url-newuser.png)
<p align="center">Figure 3-6</p>



![](media/tammy-loggedin.png)
<p align="center">Figure 3-7</p>

[Back to Top](#table-of-contents)


## Module 4:  Stopping the Autonomous Database

1. Sign in to your Autonomous Database **Service Console** and browse to the
A**utonomous Database Details** page of your service. Select the Stop button.

![](media/adb-stop-db.png)
<p align="center">Figure 4-1</p>

The ADB service will go into stopping status. Notice the status of **STOPPING**.

![](media/adb-stoppingmsg.png)
<p align="center">Figure 4-2</p>

When the service is stopped, the status will change to **STOPPED**.

![](media/adb-stoppedmsg.png)
<p align="center">Figure 4-3</p>

[Back to Top](#table-of-contents)




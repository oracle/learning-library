# Migrate the Tomcat Application

## Introduction

In this lab, we will migrate the application to the Tomcat Cluster on Oracle Cloud Infrastructure.

Estimated Lab Time: 10min

### Objectives

In this lab, you will:
* Move the application over to the Tomcat cluster on OCI
* Configure the datasource used by the application to point to the Autonomous Database

### Prerequisites

For this lab, you need

* To have provisioned the Tomcat cluster on OCI

## **STEP 1**: Move the application WAR file to the Tomcat cluster on OCI

1. Gather the Tomcat servers IP addresses from the output of the terraform

2. Get into the Tomcat Docker container

    if you were previously inside the Oracle DB container, exit with 

    ```
    <copy>
    exit
    </copy>
    ```

    Then get in the Tomcat container with

    ```
    <copy>
    docker exec -it tomcat-to-oci_tomcat_1 /bin/bash
    </copy>
    ```

2. Copy the application WAR file over to each Tomcat server

    Set the PUBLIC IP of the Tomcat server

    ```bash
    export TOMCAT_IP=<Tomcat Public IP>
    ```

    Then run

    ```bash
    <copy>
    cd /usr/local/tomcat/webapps/
    scp SimpleDB.war opc@${TOMCAT_IP}:~/
    </copy>
    ```

3. SSH to the tomcat server

    ```bash
    <copy>
    ssh opc@${TOMCAT_IP}
    </copy>
    ```

4. Copy the file to the deployment folder

    ```bash
    <copy>
    sudo cp SimpleDB.war /var/lib/tomcat/webapps/
    </copy>
    ``` 

5. Check the deployment happened as expected

    ```bash
    <copy>
    cd /var/lib/tomcat/webapps/
    ls -lh
    </copy>
    ```

    If the war file was deployed, you should find a folder called `SimpleDB` in this folder.

    It may take several seconds to deploy, so if you don't see the folder at first, try the `ls -lh` command again

## **STEP 2:** Configure the datasource

1. Open the `server.xml` file in /etc/tomcat/ for editing

    ```bash
    <copy>
    sudo nano /etc/tomcat/server.xml
    </copy>
    ```

2. Add the following section within the existing `<GlobalNamingResources>` section

    ```xml
    <copy>
     <Resource name="jdbc/JDBCConnectionDS"
          global="jdbc/JDBCConnectionDS"
          auth="Container"
          type="javax.sql.DataSource"
          username="riders"
          password="Nge29v2rv#1YtSIS#"
          driverClassName="oracle.jdbc.OracleDriver"
          description="RIDERS's database"
          url="jdbc:oracle:thin:@atpdb_high?TNS_ADMIN=/etc/tomcat/wallet"
          maxActive="15"
          maxIdle="3"/>
    </copy>
    ```

    Make sure to replace the `atpdb` name with your info if you didn't use the name `atp_db`

    You should end up with something like:

    ```xml
    <GlobalNamingResources>
    <!-- Editable user database that can also be used by
         UserDatabaseRealm to authenticate users
    -->
        <Resource name="UserDatabase" auth="Container"
              type="org.apache.catalina.UserDatabase"
              description="User database that can be updated and saved"
              factory="org.apache.catalina.users.MemoryUserDatabaseFactory"
              pathname="conf/tomcat-users.xml" />
        <Resource name="jdbc/JDBCConnectionDS"
            global="jdbc/JDBCConnectionDS"
            auth="Container"
            type="javax.sql.DataSource"
            username="riders"
            password="Nge29v2rv#1YtSIS#"
            driverClassName="oracle.jdbc.OracleDriver"
            description="RIDERS's database"
            url="jdbc:oracle:thin:@atpdb_high?TNS_ADMIN=/etc/tomcat/wallet"
            maxActive="15"
            maxIdle="3"/>
  </GlobalNamingResources>
    ```

3. Save the file

    Type `CTRL+x`, then `y` to save

4. Open the `context.xml` file for editing

    ```bash
    <copy>
    sudo nano /etc/tomcat/context.xml
    </copy>
    ```

5. Add the following section inside the `<Context />` tag:

    ```xml
    <copy>
      <ResourceLink name="jdbc/JDBCConnectionDS"
        global="jdbc/JDBCConnectionDS"
        type="javax.sql.DataSource"/>
    </copy>
    ```

    You should end up with something like:

    ```xml
    <Context>
    <ResourceLink name="jdbc/JDBCConnectionDS"
        global="jdbc/JDBCConnectionDS"
        type="javax.sql.DataSource"/>
        <!-- Default set of monitored resources -->
        <WatchedResource>WEB-INF/web.xml</WatchedResource>
        <!-- Uncomment this to disable session persistence across Tomcat restarts -->
        <!--
        <Manager pathname="" />
        -->
        <!-- Uncomment this to enable Comet connection tacking (provides events
            on session expiration as well as webapp lifecycle) -->
        <!--
        <Valve className="org.apache.catalina.valves.CometConnectionManagerValve" />
        -->

    </Context>
    ```

6. Save the file

    Type `CTRL+x`, then `y` to save

7. Restart Tomcat

    ```bash
    <copy>
    sudo systemctl restart tomcat
    </copy>
    ```

8. You can check that the application is correctly deployed and served by the individual server at:

    http://`TOMCAT_IP`:8080/SimpleDB

    Note: The first time the application runs, the query may take up to 30sec as the indices and cache are primed.
    

## **STEP 3:** Repeat for each Tomcat server if you had more than 1

1. Repeat steps 2 to 6 for each server on the Tomcat cluster.

## **STEP 4:** Check the application served via the load balancer

1. Get the load balancer public IP from the Terraform output

2. Go to http://`LOAD_BALANCER_IP`/SimpleDB/

3. Check that you see the application being served.

    ![](./images/lb-simpledb-app.png)

You may proceed to the next lab.

## Acknowledgements
 - **Author** - Subash Singh, Emmanuel Leroy, October 2020
 - **Last Updated By/Date** - Emmanuel Leroy, October 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
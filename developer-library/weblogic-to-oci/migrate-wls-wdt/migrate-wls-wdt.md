# Migrating the WebLogic Domain

## Introduction

Migrating a WebLogic domain is equivalent to re-deploying the applications and resources to a new domain and infrastructure.

We'll use WebLogic Deploy Tooling to migrate the domain from on-premises and re-deploy it on OCI.

Estimated Completion Time: 15 minutes.

### About Product/Technologies

**WebLogic Deploy Tooling** is an open source tool found on Github at [https://github.com/oracle/weblogic-deploy-tooling](https://github.com/oracle/weblogic-deploy-tooling).

Migration with WebLogic Deploy Tooling (WDT) consists of 3 steps:

- Discover the source domain, and generate a **model** file of the topology, resources and applications, a **variable** file with required credentials, and an **archive** file with the application binaries.
- Edit the **model** file and **variable** file to target the new infrastructure on OCI.
- Copy the files to the target Admin Server, and **update** the clean domain on OCI with the applications and resources discovered on-premises.

### Objectives

- Install WebLogic Deploy Tooling on the source WebLogic domain.
- Discover the source domain.
- Edit the source domain model file.
- Edit the source domain property file.
- Update the target domain on OCI.
- Check migration was successful.

### Prerequisites

- Have set up the demo on-premises environment to use as the source domain to migrate.
- Have deployed a WebLogic on OCI domain using the marketplace.
- Have migrated the application database from the source environment to OCI.

## **STEP 1:** Installing WebLogic Deploy Tooling

### Using the docker on-premises environment:

1. If you were in the database container to perform the previous steps of database migration, exit the database container with:

    ```bash
    <copy>
    exit
    </copy>
    ```

    You should be back on your local computer shell prompt.

2. Get into the **WebLogic** docker container with the following command:

    ```bash
    <copy>
    docker exec -it weblogic-to-oci_wls_admin_1 /bin/bash
    </copy>
    ```

3. Run the `install_wdt.sh` script:

    ```bash
    <copy>
    cd ~/wdt
    ./install_wdt.sh
    </copy>
    ```

    This will install WebLogic Deploy Tooling locally in a folder `weblogic-deploy`.

### Using the demo workshop marketplace image


You should already be in the on-premises environment logged in as the `oracle` user.

1. Run the `install_wdt.sh` script:

    ```bash
    <copy>
    cd ~/wdt
    ./install_wdt.sh
    </copy>
    ```

    This will install WebLogic Deploy Tooling locally in a folder `weblogic-deploy`.


## **STEP 2:** Discover the On-Premises Domain

The `discover_domain.sh` script wraps the **WebLogic Deploy Tooling** `discoverDomain` script to generate 3 files:

- `source.yaml`: the model file.
- `source.properties`: the variables file.
- `source.zip`: the archive file.

It also takes care of the manual extraction of applications that may be present under the `ORACLE_HOME`.

Applications found under `ORACLE_HOME` will have a path that includes `@@ORACLE_HOME@@` and **will not be included in the archive file**. They need to be extracted manually. The script takes care of this and injects those applications in the `source.zip` file while replacing the path in the `source.yaml` file.

1. Run the `discover_domain.sh` script:

    ```bash
    <copy>
    ./discover_domain.sh
    </copy>
    ```

    [output of the discover_domain.sh script](https://raw.githubusercontent.com/oracle/learning-library/master/developer-library/weblogic-to-oci/workshops/weblogic-on-oci-mp/freetier/discover_domain.output.txt)

## **STEP 3:** Edit the `source.yaml` File

The extracted `source.yaml` file looks like the following:

```yaml
domainInfo:
    AdminUserName: '@@PROP:AdminUserName@@'
    AdminPassword: '@@PROP:AdminPassword@@'
topology:
    Name: base_domain
    ProductionModeEnabled: true
    NMProperties:
        CrashRecoveryEnabled: true
        LogLevel: FINEST
        JavaHome: /u01/jdk
        ListenAddress: 0.0.0.0
        PropertiesVersion: 12.2.1.4.0
        SecureListener: false
        weblogic.StartScriptName: startWebLogic.sh
    Cluster:
        cluster:
            MulticastPort: 5555
            MulticastAddress: 237.0.0.101
            WeblogicPluginEnabled: true
            ClusterMessagingMode: multicast
    Server:
        AdminServer:
            Machine: machine_0
            ListenAddress: 0.0.0.0
        server_0:
            ListenPort: 7003
            Machine: machine_0
            Cluster: cluster
            ListenAddress: 0.0.0.0
            JTAMigratableTarget:
                Cluster: cluster
                UserPreferredServer: server_0
        server_1:
            ListenPort: 7005
            Machine: machine_0
            Cluster: cluster
            ListenAddress: 0.0.0.0
            JTAMigratableTarget:
                Cluster: cluster
                UserPreferredServer: server_1
    MigratableTarget:
        server_0 (migratable):
            Cluster: cluster
            MigrationPolicy: manual
            UserPreferredServer: server_0
            Notes: This is a system generated default migratable target for a server. Do not delete manually.
        server_1 (migratable):
            Cluster: cluster
            MigrationPolicy: manual
            UserPreferredServer: server_1
            Notes: This is a system generated default migratable target for a server. Do not delete manually.
    UnixMachine:
        machine_0:
            NodeManager:
                DebugEnabled: true
                NMType: Plain
                ListenAddress: 0.0.0.0
    SecurityConfiguration:
        NodeManagerPasswordEncrypted: '@@PROP:SecurityConfig.NodeManagerPasswordEncrypted@@'
        CredentialEncrypted: '@@PROP:SecurityConfig.CredentialEncrypted@@'
        Realm:
            myrealm:
                Adjudicator:
                    DefaultAdjudicator:
                        DefaultAdjudicator:
                AuthenticationProvider:
                    DefaultAuthenticator:
                        DefaultAuthenticator:
                    DefaultIdentityAsserter:
                        DefaultIdentityAsserter:
                            ActiveType: [ AuthenticatedUser, 'weblogic-jwt-token' ]
                Authorizer:
                    XACMLAuthorizer:
                        XACMLAuthorizer:
                            PolicyDeploymentEnabled: true
                CertPathProvider:
                    WebLogicCertPathProvider:
                        WebLogicCertPathProvider:
                CredentialMapper:
                    DefaultCredentialMapper:
                        DefaultCredentialMapper:
                PasswordValidator:
                    SystemPasswordValidator:
                        SystemPasswordValidator:
                RoleMapper:
                    XACMLRoleMapper:
                        XACMLRoleMapper:
resources:
    JDBCSystemResource:
        JDBCConnection:
            Target: cluster
            JdbcResource:
                JDBCConnectionPoolParams:
                    InitialCapacity: 0
                    TestTableName: SQL SELECT 1 FROM DUAL
                JDBCDataSourceParams:
                    GlobalTransactionsProtocol: TwoPhaseCommit
                    JNDIName: jdbc.JDBCConnectionDS
                JDBCDriverParams:
                    URL: 'jdbc:oracle:thin:@//oracledb:1521/PDB.us.oracle.com'
                    PasswordEncrypted: '@@PROP:JDBC.JDBCConnection.PasswordEncrypted@@'
                    DriverName: oracle.jdbc.xa.client.OracleXADataSource
                    Properties:
                        user:
                            Value: riders
appDeployments:
    Application:
        SimpleDB:
            SourcePath: 'wlsdeploy/applications/SimpleDB.ear'
            ModuleType: ear
            StagingMode: stage
            Target: cluster
        SimpleHTML:
            SourcePath: 'wlsdeploy/applications/SimpleHTML.ear'
            ModuleType: ear
            StagingMode: stage
            Target: cluster

```

1. Edit the `source.yaml`:

    ```bash
    <copy>
    nano source.yaml
    </copy>
    ```

    The `domainInfo` includes basic domain information which we will not change.

    The `topology` section includes the definition of the managed servers, admin server, machines and clusters. The domain is already provisioned on OCI so this will not change.

2.  Remove the entire `domainInfo` section and the `topology` section.

    The content now looks like:

    ```yaml
    resources:
        JDBCSystemResource:
            JDBCConnection:
                Target: cluster
                JdbcResource:
                    JDBCConnectionPoolParams:
                        InitialCapacity: 0
                        TestTableName: SQL SELECT 1 FROM DUAL
                    JDBCDataSourceParams:
                        GlobalTransactionsProtocol: TwoPhaseCommit
                        JNDIName: jdbc.JDBCConnectionDS
                    JDBCDriverParams:
                        URL: 'jdbc:oracle:thin:@//oracledb:1521/PDB.us.oracle.com'
                        PasswordEncrypted: '@@PROP:JDBC.JDBCConnection.PasswordEncrypted@@'
                        DriverName: oracle.jdbc.xa.client.OracleXADataSource
                        Properties:
                            user:
                                Value: riders
    appDeployments:
        Application:
            SimpleDB:
                SourcePath: 'wlsdeploy/applications/SimpleDB.ear'
                ModuleType: ear
                StagingMode: stage
                Target: cluster
            SimpleHTML:
                SourcePath: 'wlsdeploy/applications/SimpleHTML.ear'
                ModuleType: ear
                StagingMode: stage
                Target: cluster

    ```

3. Edit each of the 3 `Target` names for `resources` and `appDeployments` from `cluster` (the name of the cluster on-premises) to `nonjrf_cluster` (the name of the cluster on the OCI domain):

    * `resources->JDBCSystemResource->JDBCConnection->Target`
    * `appDeployments->Application->SimpleDB->Target`
    * `appDeployments->Application->SimpleHTML->Target`

    The content should look like:

    ```yaml
    resources:
        JDBCSystemResource:
            JDBCConnection:
                Target: nonjrf_cluster # <---
                JdbcResource:
                    JDBCConnectionPoolParams:
                        InitialCapacity: 0
                        TestTableName: SQL SELECT 1 FROM DUAL
                    JDBCDataSourceParams:
                        GlobalTransactionsProtocol: TwoPhaseCommit
                        JNDIName: jdbc.JDBCConnectionDS
                    JDBCDriverParams:
                        URL: 'jdbc:oracle:thin:@//oracledb:1521/PDB.us.oracle.com'
                        PasswordEncrypted: '@@PROP:JDBC.JDBCConnection.PasswordEncrypted@@'
                        DriverName: oracle.jdbc.xa.client.OracleXADataSource
                        Properties:
                            user:
                                Value: riders
    appDeployments:
        Application:
            SimpleDB:
                SourcePath: 'wlsdeploy/applications/SimpleDB.ear'
                ModuleType: ear
                StagingMode: stage
                Target: nonjrf_cluster # <---
            SimpleHTML:
                SourcePath: 'wlsdeploy/applications/SimpleHTML.ear'
                ModuleType: ear
                StagingMode: stage
                Target: nonjrf_cluster # <---
    ```

  4. Finally, edit the `resources->JDBCSystemResource->JDBCConnection->JdbcResource->JDBCDriverParams->URL` to match the JDBC connection string of the database on OCI.

    The new JDBC connection string should be:

    ```
    <copy>
    jdbc:oracle:thin:@//db.nonjrfdbsubnet.nonjrfvcn.oraclevcn.com:1521/pdb.nonjrfdbsubnet.nonjrfvcn.oraclevcn.com
    </copy>
    ```

    This is the connection string gathered earlier but making sure the **service** name is changed to `pdb` (this is the name of the pdb where the `RIDERS.RIDERS` table resides, as needed by the **SimpleDB** application).

    The resulting `source.yaml` file should be like:

    ```yaml
    <copy>
    resources:
        JDBCSystemResource:
            JDBCConnection:
                Target: nonjrf_cluster
                JdbcResource:
                    JDBCConnectionPoolParams:
                        InitialCapacity: 0
                        TestTableName: SQL SELECT 1 FROM DUAL
                    JDBCDataSourceParams:
                        GlobalTransactionsProtocol: TwoPhaseCommit
                        JNDIName: jdbc.JDBCConnectionDS
                    JDBCDriverParams:
                        URL: 'jdbc:oracle:thin:@//db.nonjrfdbsubnet.nonjrfvcn.oraclevcn.com:1521/pdb.nonjrfdbsubnet.nonjrfvcn.oraclevcn.com'
                        PasswordEncrypted: '@@PROP:JDBC.JDBCConnection.PasswordEncrypted@@'
                        DriverName: oracle.jdbc.xa.client.OracleXADataSource
                        Properties:
                            user:
                                Value: riders
    appDeployments:
        Application:
            SimpleDB:
                SourcePath: 'wlsdeploy/applications/SimpleDB.ear'
                ModuleType: ear
                StagingMode: stage
                Target: nonjrf_cluster
            SimpleHTML:
                SourcePath: 'wlsdeploy/applications/SimpleHTML.ear'
                ModuleType: ear
                StagingMode: stage
                Target: nonjrf_cluster
    </copy>
    ```

  **Important Note**: If when migrating a different domain the `StagingMode: stage` key was not present in the `Application` section, **make sure to add it** as shown so the applications are distributed and started on all managed servers.

5. Save the `source.yaml` file by typing `CTRL+x` then `y`.

## **STEP 4:** Edit the `source.properties` File

  ```bash
  <copy>
  nano source.properties
  </copy>
  ```

  It looks like:

  ```yaml
  AdminPassword=
  AdminUserName=
  JDBC.JDBCConnection.PasswordEncrypted=
  SecurityConfig.CredentialEncrypted=
  SecurityConfig.NodeManagerPasswordEncrypted=
  ```

1. Delete all lines except for the `JDBC.JDBCConnection.PasswordEncrypted=` line, as these pertain to the `domainInfo` and `topology` sections we deleted from the `source.yaml`.

2. Enter the JDBC Connection password for the `RIDERS` user pdb: `Nge29v2rv#1YtSIS#`.

  Although the name is `PasswordEncrypted`, enter the plaintext password and WebLogic will encrypt it when updating the domain.

  The resulting file should look like:

    ```yaml
    JDBC.JDBCConnection.PasswordEncrypted=Nge29v2rv#1YtSIS#
    ```

3. Save the file with `CTRL+x` and `y`.

## **STEP 5:** Update the WebLogic Domain on OCI

The `update_domain.sh` script updates the target domain.

- It copies the `source.yaml` model file, `source.properties` variable file and the `source.zip` archive fileas well as the `install_wdt.sh` script and the `update_domain_as_oracle_user.sh` script to the target WebLogic Admin Server host.

- It makes sure the files are owned by the `oracle` user and moved to the `oracle` user home.

- It runs the `install_wdt.sh` script through SSH.

- And finally runs the `update_domain_as_oracle_user.sh` through SSH to update the WebLogic domain on OCI with the edited source files.

The `update_domain_as_oracle_user.sh` script runs the **WebLogic Deploy Tooling** script `updateDomain.sh` online, by providing the `-admin_url` flag.

**Note:** The url uses the `t3` protocol which is only accessible through the internal admin server port, which is `9071` on the latest WebLogic marketplace stack, for older provisioning of the stack, the port may be `7001`.

1. Edit the `update_domain.sh` script:

    ```bash
    <copy>
    nano update_domain.sh
    </copy>
    ```
2. Provide the `TARGET_WLS_ADMIN`.

    This is the **WebLogic Admin Server public IP** gather previously if you deployed in a **Public Subnet**
    or the **Admin Server Private IP** if you deployed in a **Private subnet**

3. If you deployed in a **Private Subnet**, you also need to provide a `BASTION_IP` which is the **public IP** of the Bastion Instance.

    Furthermore, you'll need to add a **NAT gateway** to the admin server subnet so it is possible to download the required software.

    - Go to **Core Infrastructure -> Networking -> Virtual Cloud Networks**.
    - Select the VCN for the WLS on OCI stack.
    - Click **NAT Gateways** on the left menu.
    - Click **Create NAT Gateway**.
    - Name it **NAT gw**.
    - Click **Create NAT Gateway**.
    - Go to **Subnets**.
    - Select the `nonjrf-wl-subnet`.
    - In the Subnet Information, click the **Route Table** (`nonjrf-routetable`).
    - Click **Add Route Rules**.
    - Select **NAT Gateway**.
    - Enter **0.0.0.0/0** for the CIDR range.
    - Select the **NAT gw** NAT Gateway created earlier.
    - Click **Add Route Rules**.


4. Save the file with `CTRL+x` and `y`.

5. Run the `update_domain.sh` script:

    ```bash
    <copy>
    ./update_domain.sh
    </copy>
    ```

  You will be prompted to provide the `weblogic admin password` which is `welcome1`.

  [View the output of the update_domain.sh script](https://raw.githubusercontent.com/oracle/learning-library/master/developer-library/weblogic-to-oci/workshops/weblogic-on-oci-mp/freetier/update_domain.output.txt)

## **STEP 6:** Check that the app deployed properly

1. Go to the WebLogic Admin console (at https://`ADMIN_SERVER_PUBLIC_IP`:7002/console if you deployed in a *Public Subnet*), or through the tunnel (at https://localhost:7002/console) as you did earlier.

    Note: If you're using Chrome, you might encounter Self-signed certificate issues. We recommend using Firefox to test.

2. In Firefox you will see the self-certificate warning as below:

    ![](./images/self-cert-warning.png " ")

    Click **Advanced...** and then **Accept the Risk and Continue**

3. Login with the Admin user `weblogic` and password: `welcome1`.

4. Go to `deployments`: you should see the 2 applications deployed, and in the **active** state.

  ![](./images/oci-deployments.png " ")

5. Go to the SimpleDB application URL, which is the Load Balancer IP gathered previously in the **Outputs** of the WebLogic provisioning, with the route `/SimpleDB/` like:
https://`LOAD_BALANCER_IP`/SimpleDB/

    Making sure you use `https` as scheme and the proper case for `/SimpleDB`.

  ![](./images/oci-simpledb-app.png " ")

## Acknowledgements

 - **Author** - Emmanuel Leroy, May 2020
 - **Last Updated By/Date** - Emmanuel Leroy, August 2020

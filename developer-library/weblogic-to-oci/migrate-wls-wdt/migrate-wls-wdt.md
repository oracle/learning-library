# Migrating the WebLogic domain

## Introduction: 

Migrating a WebLogic domain is equivalent to re-deploying the applications and resources to a new domain and infrastructure.

We'll use WebLogic Deploy Tooling to migrate the domain from on-premises and re-deploy it on OCI.

Estimated Lab Time: 15 min

### About Product/Technologies

**WebLogic Deploy Tooling** is an open source tool found on Github at [https://github.com/oracle/weblogic-deploy-tooling](https://github.com/oracle/weblogic-deploy-tooling)

Migration with WebLogic Deploy Tooling (WDT) consists in 3 steps:

- Discover the source domain, and generate a **model** file of the topology, resources and applications, a **variable** file with required credentials, and an **archive** file with the application binaries.

- Edit the the **model** file and **variable** file to target the new infrastructure on OCI.

- Copy the files to the target Admin Server, and **update** the clean domain on OCI with the applications and resources discovered on-premises.

### Objectives

In this lab, you will:

- Install WebLogic Deploy Tooling on the source WebLogic domain
- Discover the source domain
- Edit the source domain model file
- Edit the source domain property file
- Update the target domain on OCI
- Check migration was successful

### Prerequisites

To run this lab, you need to:

- Have setup the demo 'on-premises' environment to use as the source domain to migrate
- Have deployed a WebLogic on OCI domain using the marketplace
- Have migrated the Application database from the source environment to OCI

## **STEP 1:** Installing WebLogic Deploy Tooling

### Using the Docker 'on-premises' environment:

1. If you were in the Database container to perform the previous steps of database migration, exit the database container with 

    ```bash
    <copy>
    exit
    </copy>
    ```
    You should be back on your local computer shell prompt

2. Get into the **WebLogic** docker container with the following command:

    ```bash
    <copy>
    docker exec -it weblogic-to-oci_wls_admin_1 /bin/bash
    </copy>
    ```

3. run the `install_wdt.sh` script

    ```bash
    <copy>
    cd ~/wdt
    ./install_wdt.sh
    </copy>
    ```

    This will install WebLogic Deploy Tooling locally in a folder `weblogic-deploy`

### Using the demo Workshop Marketplace image


You should already be in the 'on-premises' environment logged in as the `oracle` user.

1. run the `install_wdt.sh` script

    ```bash
    <copy>
    cd ~/wdt
    ./install_wdt.sh
    </copy>
    ```

    This will install WebLogic Deploy Tooling locally in a folder `weblogic-deploy`

<details><summary>View the <code>install_wdt.sh</code> script</summary>

  ```bash
  WLSDT_VERSION=1.7.3
  # download the zip archive of the tool from Github
  curl -LO https://github.com/oracle/weblogic-deploy-tooling/releases/download/weblogic-deploy-tooling-${WLSDT_VERSION}/weblogic-deploy.zip 
  
  # unzip and cleanup
  unzip weblogic-deploy.zip
  rm weblogic-deploy.zip

  # make the scripts executable
  chmod +x weblogic-deploy/bin/*.sh
  ```
  </details>

## **STEP 2:** Discover the on-premises domain

<details><summary>View the <code>discover_domain.sh</code> script</summary>

```bash
# default to JRF domain which filters out JRF libraries and applications
# If the domain is not JRF, the content would not be present so filterign it out will not make a difference
DOMAIN_TYPE=JRF

# clean up before starting
rm source.* || echo "clean startup"

echo "Discovering the source domain..."
weblogic-deploy/bin/discoverDomain.sh \
    -oracle_home $MW_HOME \
    -domain_home $DOMAIN_HOME \
    -archive_file source.zip \
    -model_file source.yaml \
    -variable_file source.properties \
    -domain_type $DOMAIN_TYPE

# This part insures that applications that are under the ORACLE_HOME are also extracted.
# by default WDT does not extract applications under the ORACLE_HOME as it is not following current best practices. However in older versions of WLS, this was common.

if [[ "$(cat source.yaml | grep '@@ORACLE_HOME@@' | wc -l)" != "0" ]]; then
    echo "Some of the application files are located within the ORACLE_HOME and won't be extracted by WDT"
    echo "Extracting those files and updating paths in the model file..."
    rm -rf ./wlsdeploy/
    mkdir -p ./wlsdeploy/applications;
    cp $(cat source.yaml | grep '@@ORACLE_HOME@@' | sed "s|.*: '@@ORACLE_HOME@@\(.*\)'|${ORACLE_HOME}\1|") ./wlsdeploy/applications/;
    zip -r source.zip ./wlsdeploy;
    rm -rf ./wlsdeploy/
    sed -i "s|@@ORACLE_HOME@@|wlsdeploy\/applications|g;" source.yaml
fi
```

</details>

The `discover_domain.sh` script wraps the **WebLogic Deploy Tooling** `discoverDomain` script to generate 3 files:

- `source.yaml`: the model file
- `source.properties`: the variables file
- `source.zip`: the archive file

It also takes care of the manual extraction of applications that may be present under the `ORACLE_HOME`

Applications found under `ORACLE_HOME` will have a path that includes `@@ORACLE_HOME@@` and **will not be included in the archive file**. They need to be extracted manually. The script takes care of this and injects those applications in the `source.zip` file while replacing the path in the `source.yaml` file.

1. run the `discover_domain.sh` script

    ```bash
    <copy>
    ./discover_domain.sh
    </copy>
    ```

the output should look like:

<details><summary>output of the <code>discover_domain.sh</code> script</summary>

```bash
rm: cannot remove ‘source.*’: No such file or directory
clean startup
Discovering the source domain...
set JVM version to minor  8
JDK version is 1.8.0_241-b07
JAVA_HOME = /u01/jdk
WLST_EXT_CLASSPATH = /home/oracle/wdt/weblogic-deploy/lib/weblogic-deploy-core.jar
CLASSPATH = /home/oracle/wdt/weblogic-deploy/lib/weblogic-deploy-core.jar
WLST_PROPERTIES = -Djava.util.logging.config.class=oracle.weblogic.deploy.logging.WLSDeployCustomizeLoggingConfig -Dcom.oracle.cie.script.throwException=true 
/u01/oracle/oracle_common/common/bin/wlst.sh /home/oracle/wdt/weblogic-deploy/lib/python/discover.py -oracle_home /u01/oracle -domain_home /u01/oracle/user_projects/domains/base_domain -archive_file source.zip -model_file source.yaml -variable_file source.properties -domain_type JRF

Initializing WebLogic Scripting Tool (WLST) ...

Welcome to WebLogic Server Administration Scripting Shell

Type help() for help on available commands

####<May 28, 2020 6:00:28 PM> <INFO> <WebLogicDeployToolingVersion> <logVersionInfo> <WLSDPLY-01750> <The WebLogic Deploy Tooling discoverDomain version is 1.7.3:master.4f1ebfc:Apr 03, 2020 18:05 UTC>
####<May 28, 2020 6:00:28 PM> <INFO> <discover> <main> <WLSDPLY-06025> <Variable file was provided. Model password attributes will be replaced with tokens and corresponding values put into the variable file.>
####<May 28, 2020 6:00:33 PM> <INFO> <discover> <_get_domain_name> <WLSDPLY-06022> <Discover domain base_domain>
####<May 28, 2020 6:00:33 PM> <INFO> <TopologyDiscoverer> <discover> <WLSDPLY-06600> <Discovering domain model topology>
####<May 28, 2020 6:00:34 PM> <INFO> <TopologyDiscoverer> <_get_nm_properties> <WLSDPLY-06627> <Discovering NM Properties>
####<May 28, 2020 6:00:35 PM> <INFO> <Discoverer> <_get_additional_parameters> <WLSDPLY-06150> <Unable to determine if additional attributes are available for NMProperties at location /NMProperties : Unable to find a valid MBean Interface in the Class list array(java.lang.Class,[])  of the MBean instance com.oracle.cie.domain.nodemanager.NMPropertiesConfigProxyBase@4d96b968>
####<May 28, 2020 6:00:35 PM> <INFO> <TopologyDiscoverer> <get_clusters> <WLSDPLY-06601> <Discovering 1 clusters>
####<May 28, 2020 6:00:35 PM> <INFO> <TopologyDiscoverer> <get_clusters> <WLSDPLY-06602> <Adding Cluster cluster>
####<May 28, 2020 6:00:35 PM> <INFO> <TopologyDiscoverer> <get_servers> <WLSDPLY-06603> <Discovering 3 servers>
####<May 28, 2020 6:00:35 PM> <INFO> <TopologyDiscoverer> <get_servers> <WLSDPLY-06604> <Adding Server AdminServer>
####<May 28, 2020 6:00:37 PM> <INFO> <TopologyDiscoverer> <get_servers> <WLSDPLY-06604> <Adding Server server_0>
####<May 28, 2020 6:00:38 PM> <INFO> <TopologyDiscoverer> <get_servers> <WLSDPLY-06604> <Adding Server server_1>
####<May 28, 2020 6:00:38 PM> <INFO> <TopologyDiscoverer> <get_migratable_targets> <WLSDPLY-06607> <Discovering 2 Migratable Targets>
####<May 28, 2020 6:00:38 PM> <INFO> <TopologyDiscoverer> <get_migratable_targets> <WLSDPLY-06608> <Adding Migratable Target server_0 (migratable)>
####<May 28, 2020 6:00:39 PM> <INFO> <TopologyDiscoverer> <get_migratable_targets> <WLSDPLY-06608> <Adding Migratable Target server_1 (migratable)>
####<May 28, 2020 6:00:39 PM> <INFO> <TopologyDiscoverer> <get_unix_machines> <WLSDPLY-06609> <Discovering 1 Unix machines>
####<May 28, 2020 6:00:39 PM> <INFO> <TopologyDiscoverer> <get_unix_machines> <WLSDPLY-06610> <Adding Unix Machine machine_0>
####<May 28, 2020 6:00:39 PM> <INFO> <TopologyDiscoverer> <get_machines> <WLSDPLY-06611> <Discovering 0 machines>
####<May 28, 2020 6:00:39 PM> <INFO> <TopologyDiscoverer> <discover_security_configuration> <WLSDPLY-06622> <Adding Security Configuration>
####<May 28, 2020 6:00:39 PM> <INFO> <Discoverer> <_populate_model_parameters> <WLSDPLY-06153> <Attribute ProviderClassName for model folder at location /SecurityConfiguration/Realm/Adjudicator/DefaultAdjudicator is not in the lsa map and is not defined in the alias definitions>
####<May 28, 2020 6:00:40 PM> <INFO> <Discoverer> <_populate_model_parameters> <WLSDPLY-06153> <Attribute ProviderClassName for model folder at location /SecurityConfiguration/Realm/AuthenticationProvider/DefaultAuthenticator is not in the lsa map and is not defined in the alias definitions>
####<May 28, 2020 6:00:40 PM> <INFO> <Discoverer> <_populate_model_parameters> <WLSDPLY-06153> <Attribute ProviderClassName for model folder at location /SecurityConfiguration/Realm/AuthenticationProvider/DefaultIdentityAsserter is not in the lsa map and is not defined in the alias definitions>
####<May 28, 2020 6:00:40 PM> <INFO> <Discoverer> <_populate_model_parameters> <WLSDPLY-06153> <Attribute ProviderClassName for model folder at location /SecurityConfiguration/Realm/Authorizer/XACMLAuthorizer is not in the lsa map and is not defined in the alias definitions>
####<May 28, 2020 6:00:40 PM> <INFO> <Discoverer> <_populate_model_parameters> <WLSDPLY-06153> <Attribute ProviderClassName for model folder at location /SecurityConfiguration/Realm/CertPathProvider/WebLogicCertPathProvider is not in the lsa map and is not defined in the alias definitions>
####<May 28, 2020 6:00:40 PM> <INFO> <Discoverer> <_populate_model_parameters> <WLSDPLY-06153> <Attribute ProviderClassName for model folder at location /SecurityConfiguration/Realm/CredentialMapper/DefaultCredentialMapper is not in the lsa map and is not defined in the alias definitions>
####<May 28, 2020 6:00:40 PM> <INFO> <Discoverer> <_populate_model_parameters> <WLSDPLY-06153> <Attribute ProviderClassName for model folder at location /SecurityConfiguration/Realm/PasswordValidator/SystemPasswordValidator is not in the lsa map and is not defined in the alias definitions>
####<May 28, 2020 6:00:40 PM> <INFO> <Discoverer> <_populate_model_parameters> <WLSDPLY-06153> <Attribute ProviderClassName for model folder at location /SecurityConfiguration/Realm/RoleMapper/XACMLRoleMapper is not in the lsa map and is not defined in the alias definitions>
####<May 28, 2020 6:00:40 PM> <INFO> <TopologyDiscoverer> <get_embedded_ldap_configuration> <WLSDPLY-06639> <Skipping Embedded LDAP Server Configuration>
####<May 28, 2020 6:00:40 PM> <INFO> <ResourcesDiscoverer> <discover> <WLSDPLY-06300> <Discovering domain model resources>
####<May 28, 2020 6:00:40 PM> <INFO> <CommonResourcesDiscoverer> <get_datasources> <WLSDPLY-06340> <Discovering 1 JDBC System Resources>
####<May 28, 2020 6:00:40 PM> <INFO> <CommonResourcesDiscoverer> <get_datasources> <WLSDPLY-06341> <Adding JDBC System Resource JDBCConnection>
####<May 28, 2020 6:00:41 PM> <INFO> <DeploymentsDiscoverer> <discover> <WLSDPLY-06380> <Discovering domain model deployments>
####<May 28, 2020 6:00:41 PM> <INFO> <DeploymentsDiscoverer> <get_applications> <WLSDPLY-06391> <Discovering 2 Applications>
####<May 28, 2020 6:00:41 PM> <INFO> <DeploymentsDiscoverer> <get_applications> <WLSDPLY-06392> <Adding Application SimpleDB>
####<May 28, 2020 6:00:41 PM> <INFO> <DeploymentsDiscoverer> <add_application_to_archive> <WLSDPLY-06393> <Will not add application SimpleDB from Oracle installation directory to archive>
####<May 28, 2020 6:00:41 PM> <INFO> <DeploymentsDiscoverer> <get_applications> <WLSDPLY-06392> <Adding Application SimpleHTML>
####<May 28, 2020 6:00:41 PM> <INFO> <DeploymentsDiscoverer> <add_application_to_archive> <WLSDPLY-06393> <Will not add application SimpleHTML from Oracle installation directory to archive>
####<May 28, 2020 6:00:41 PM> <INFO> <MultiTenantDiscoverer> <discover> <WLSDPLY-06700> <Discover Multi-tenant>
####<May 28, 2020 6:00:41 PM> <INFO> <MultiTenantTopologyDiscoverer> <discover> <WLSDPLY-06709> <Discover Multi-tenant Topology>
####<May 28, 2020 6:00:41 PM> <INFO> <MultiTenantResourcesDiscoverer> <discover> <WLSDPLY-06707> <Discover Multi-tenant Resources>
####<May 28, 2020 6:00:42 PM> <INFO> <filter_helper> <apply_filters> <WLSDPLY-20017> <No filter configuration file /home/oracle/wdt/weblogic-deploy/lib/model_filters.json>
####<May 28, 2020 6:00:42 PM> <INFO> <variable_injector> <inject_variables_keyword_file> <WLSDPLY-19518> <Variables were inserted into the model and written to the variables file source.properties>
####<May 28, 2020 6:00:42 PM> <INFO> <Validator> <load_variables> <WLSDPLY-05004> <Performing variable validation on the source.properties variable file>
####<May 28, 2020 6:00:42 PM> <INFO> <Validator> <__validate_model_file> <WLSDPLY-05002> <Performing validation in TOOL mode for WebLogic Server version 12.2.1.4.0 and WLST OFFLINE mode>
####<May 28, 2020 6:00:42 PM> <INFO> <Validator> <__validate_model_file> <WLSDPLY-05003> <Performing model validation on the /home/oracle/wdt/source.yaml model file>
####<May 28, 2020 6:00:42 PM> <INFO> <Validator> <__validate_model_file> <WLSDPLY-05005> <Performing archive validation on the /home/oracle/wdt/source.zip archive file>
####<May 28, 2020 6:00:42 PM> <INFO> <Validator> <__validate_model_section> <WLSDPLY-05008> <Validating the domainInfo section of the model file>
####<May 28, 2020 6:00:42 PM> <INFO> <Validator> <__validate_model_section> <WLSDPLY-05008> <Validating the topology section of the model file>
####<May 28, 2020 6:00:43 PM> <INFO> <Validator> <__validate_model_section> <WLSDPLY-05008> <Validating the resources section of the model file>
####<May 28, 2020 6:00:43 PM> <INFO> <Validator> <__validate_model_section> <WLSDPLY-05008> <Validating the appDeployments section of the model file>
####<May 28, 2020 6:00:43 PM> <INFO> <Validator> <__validate_model_section> <WLSDPLY-05008> <Validating the kubernetes section of the model file>
####<May 28, 2020 6:00:43 PM> <INFO> <Validator> <__validate_model_section> <WLSDPLY-05009> <Model file /home/oracle/wdt/source.yaml does not contain a kubernetes section, validation of kubernetes was skipped.>

Issue Log for discoverDomain version 1.7.3 running WebLogic version 12.2.1.4.0 offline mode:

Total:       WARNING :     0    SEVERE :     0

discoverDomain.sh completed successfully (exit code = 0)
Some of the application files are located within the ORACLE_HOME and won't be extracted by WDT
Extracting those files and updating paths in the model file...
  adding: wlsdeploy/ (stored 0%)
  adding: wlsdeploy/applications/ (stored 0%)
  adding: wlsdeploy/applications/SimpleHTML.ear (deflated 72%)
  adding: wlsdeploy/applications/SimpleDB.ear (deflated 62%)
```

</details>

## **STEP 3:** Edit the `source.yaml` file

The extracted `source.yaml` file looks like the following

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

1. Edit the `source.yaml`

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

  3. finally, edit the `resources->JDBCSystemResource->JDBCConnection->JdbcResource->JDBCDriverParams->URL` to match the JDBC connection string of the database on OCI.

    The new JDBC connection string should be:
    
    ```
    <copy>
    jdbc:oracle:thin:@//db.nonjrfdbsubnet.nonjrfvcn.oraclevcn.com:1521/pdb.nonjrfdbsubnet.nonjrfvcn.oraclevcn.com
    </copy>
    ```

    Which is the connection string gathered earlier but making sure the **service** name is changed to `pdb`. (this is the name of the pdb where the `RIDERS.RIDERS` table resides, as needed by the **SimpleDB** application)

    The resulting `source.yaml` file should be like:

    ```yaml
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
    ```

  **Important Note**: if when migrating a different domain the `StagingMode: stage` key was not present in the `Application` section, **make sure to add it** as shown so the applications are distributed and started on all managed servers

4. Save the `source.yaml` file by typing `CTRL+x` then `y`

## **STEP 4:** Edit the `source.properties` file

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

1. Delete all lines except for the `JDBC.JDBCConnection.PasswordEncrypted=` line, as these pertain to the `domainInfo` and `topology` sections we deleted from the `source.yaml`

2. Enter the JDBC Connection password for the `RIDERS` user pdb (this is can be found in the `./weblogic-to-oci/weblogic/env` file under `DS_PASSWORD`).

  Although the name is `PasswordEncrypted`, enter the plaintext password and WebLogic will encrypt it when updating the domain.

  the resulting file should look like:

  ```yaml
  JDBC.JDBCConnection.PasswordEncrypted=Nge29v2rv#1YtSIS#
  ```

3. Save the file with `CTRL+x` and `y`

## **STEP 5:** Update the WebLogic domain on OCI

The `update_domain.sh` script updates the target domain.

- It copies the `source.yaml` model file, `source.properties` variable file and the `source.zip` archive fileas well as the `install_wdt.sh` script and the `update_domain_as_oracle_user.sh` script to the target WebLogic Admin Server host

- It makes sure the files are owned by the `oracle` user and moved to the `oracle` user home.

- It runs the `install_wdt.sh` script through SSH

- and finally runs the `update_domain_as_oracle_user.sh` through SSH to update the WebLogic domain on OCI with the edited source files.

`update_domain_as_oracle_user.sh` script:
```bash
weblogic-deploy/bin/updateDomain.sh \
-oracle_home $MW_HOME \
-domain_home $DOMAIN_HOME \
-model_file source.yaml \
-variable_file source.properties \
-archive_file source.zip \
-admin_user weblogic \
-admin_url t3://$(hostname -i):9071
```

The `update_domain_as_oracle_user.sh` script runs the **WebLogic Deploy Tooling** script `updateDomain.sh` online, by providing the `-admin_url` flag.

**Note:** the url uses the `t3` protocol which is only accessible through the internal admin server port, which is `9071` on the latest WebLogic Marketplace stack, for older provisioning of the stack, the port may be `7001`

1. Edit the `update_domain.sh` script 

  ```bash
  <copy>
  nano update_domain.sh
  </copy>
  ```
2. Provide the `TARGET_WLS_ADMIN` 
    This is the **WebLogic Admin Server public IP** gather previously.
  
3. Save the file with `CTRL+x` and `y`

4. Run the `update_domain.sh` script

    ```bash
    <copy>
    ./update_domain.sh
    </copy>
    ```

  You will be prompted to provide the `weblogic admin password` which is `welcome1`

<details><summary>View the output of the <code>update_domain.sh</code> script</summary>

```bash
Copying files over to the WLS admin server...
source.properties                                                           100%   56     0.7KB/s   00:00    
source.yaml                                                                 100% 1233    14.4KB/s   00:00    
source.zip                                                                  100% 8066    83.5KB/s   00:00    
install_wdt.sh                                                              100%  273     3.2KB/s   00:00    
update_domain_as_oracle_user.sh                                             100%  238     2.9KB/s   00:00    
Changing ownership of files to oracle user...
Installing WebLogic Deploy Tooling...
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   632  100   632    0     0   2283      0 --:--:-- --:--:-- --:--:--  2289
100 1034k  100 1034k    0     0  2547k      0 --:--:-- --:--:-- --:--:-- 2547k
Archive:  weblogic-deploy.zip
   creating: weblogic-deploy/
   creating: weblogic-deploy/etc/
   creating: weblogic-deploy/lib/
   creating: weblogic-deploy/lib/python/
   creating: weblogic-deploy/lib/python/wlsdeploy/
   creating: weblogic-deploy/lib/python/wlsdeploy/util/
   creating: weblogic-deploy/lib/python/wlsdeploy/json/
   creating: weblogic-deploy/lib/python/wlsdeploy/yaml/
   creating: weblogic-deploy/lib/python/wlsdeploy/aliases/
   creating: weblogic-deploy/lib/python/wlsdeploy/exception/
   creating: weblogic-deploy/lib/python/wlsdeploy/logging/
   creating: weblogic-deploy/lib/python/wlsdeploy/tool/
   creating: weblogic-deploy/lib/python/wlsdeploy/tool/validate/
   creating: weblogic-deploy/lib/python/wlsdeploy/tool/discover/
   creating: weblogic-deploy/lib/python/wlsdeploy/tool/util/
   creating: weblogic-deploy/lib/python/wlsdeploy/tool/deploy/
   creating: weblogic-deploy/lib/python/wlsdeploy/tool/extract/
   creating: weblogic-deploy/lib/python/wlsdeploy/tool/encrypt/
   creating: weblogic-deploy/lib/python/wlsdeploy/tool/create/
   creating: weblogic-deploy/lib/typedefs/
   creating: weblogic-deploy/bin/
   creating: weblogic-deploy/lib/injectors/
   creating: weblogic-deploy/samples/
  inflating: weblogic-deploy/etc/logging.properties  
  inflating: weblogic-deploy/lib/python/wlsdeploy/util/model_context.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/util/cla_utils.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/aliases/alias_entries.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/discover/multi_tenant_resources_discoverer.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/discover/custom_folder_helper.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/util/topology_helper.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/util/alias_helper.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/deploy/deployer.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/deploy/wldf_resources_deployer.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/create/wlsroles_helper.py  
  inflating: weblogic-deploy/lib/python/validate.py  
  inflating: weblogic-deploy/bin/injectVariables.cmd  
  inflating: weblogic-deploy/bin/deployApps.sh  
  inflating: weblogic-deploy/lib/injectors/target.json  
  inflating: weblogic-deploy/lib/weblogic-deploy-core.jar  
  inflating: weblogic-deploy/lib/python/encrypt.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/util/weblogic_roles_helper.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/yaml/__init__.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/aliases/__init__.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/aliases/alias_constants.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/discover/custom_discoverer.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/discover/deployments_discoverer.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/discover/resources_discoverer.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/util/attribute_setter.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/util/rcu_helper.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/util/library_helper.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/deploy/resources_deployer.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/deploy/model_deployer.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/encrypt/__init__.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/create/security_provider_creator.py  
  inflating: weblogic-deploy/lib/typedefs/RestrictedJRF.json  
  inflating: weblogic-deploy/bin/createDomain.cmd  
  inflating: weblogic-deploy/bin/encryptModel.cmd  
  inflating: weblogic-deploy/lib/injectors/port.json  
  inflating: weblogic-deploy/lib/injectors/credentials.json  
  inflating: weblogic-deploy/lib/python/update.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/util/getcreds.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/util/cla_helper.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/util/enum.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/util/path_utils.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/yaml/yaml_translator.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/aliases/alias_jvmargs.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/exception/__init__.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/logging/__init__.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/logging/log_collector.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/validate/validator.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/discover/topology_discoverer.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/util/archive_helper.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/deploy/jms_resources_deployer.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/deploy/__init__.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/deploy/log_helper.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/deploy/topology_updater.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/create/__init__.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/create/atp_helper.py  
  inflating: weblogic-deploy/bin/extractDomainResource.cmd  
  inflating: weblogic-deploy/bin/discoverDomain.sh  
  inflating: weblogic-deploy/lib/python/deploy.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/util/string_utils.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/util/model_translator.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/json/__init__.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/aliases/validation_codes.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/aliases/model_constants.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/exception/exception_helper.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/discover/coherence_resources_discoverer.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/discover/multi_tenant_topology_discoverer.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/discover/common_resources_discoverer.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/util/mbean_utils.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/util/variable_injector.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/deploy/applications_deployer.py  
  inflating: weblogic-deploy/lib/typedefs/JRF.json  
  inflating: weblogic-deploy/bin/shared.cmd  
  inflating: weblogic-deploy/bin/injectVariables.sh  
  inflating: weblogic-deploy/bin/updateDomain.sh  
  inflating: weblogic-deploy/lib/injectors/topology.json  
  inflating: weblogic-deploy/lib/python/create.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/util/__init__.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/util/model.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/util/weblogic_helper.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/__init__.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/aliases/location_context.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/exception/expection_types.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/validate/__init__.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/validate/validation_utils.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/discover/global_resources_discoverer.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/util/beaninfo_constants.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/util/model_context_helper.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/deploy/datasource_deployer.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/deploy/common_resources_deployer.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/__init__.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/encrypt/encryption_utils.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/create/custom_folder_helper.py  
  inflating: weblogic-deploy/lib/typedefs/WLS.json  
  inflating: weblogic-deploy/bin/validateModel.cmd  
  inflating: weblogic-deploy/bin/createDomain.sh  
  inflating: weblogic-deploy/lib/injectors/url.json  
  inflating: weblogic-deploy/lib/antlr4-runtime-4.7.1.jar  
  inflating: weblogic-deploy/lib/python/extract_resource.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/util/variables.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/util/tool_exit.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/yaml/dictionary_list.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/aliases/aliases.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/validate/usage_printer.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/discover/jms_resources_discoverer.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/util/targeting_types.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/util/filter_helper.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/deploy/deployer_utils.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/deploy/odl_deployer.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/extract/__init__.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/extract/domain_resource_extractor.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/create/domain_creator.py  
  inflating: weblogic-deploy/bin/extractDomainResource.sh  
  inflating: weblogic-deploy/bin/validateModel.sh  
  inflating: weblogic-deploy/samples/model_variable_injector.json  
  inflating: weblogic-deploy/lib/python/discover.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/util/dictionary_utils.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/aliases/wlst_modes.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/aliases/password_utils.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/logging/platform_logger.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/discover/__init__.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/discover/domain_info_discoverer.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/util/__init__.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/util/string_output_stream.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/util/wlst_helper.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/create/rcudbinfo_helper.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/create/creator.py  
  inflating: weblogic-deploy/bin/deployApps.cmd  
  inflating: weblogic-deploy/bin/updateDomain.cmd  
  inflating: weblogic-deploy/bin/encryptModel.sh  
  inflating: weblogic-deploy/samples/custom_injector.json  
  inflating: weblogic-deploy/lib/python/__init__.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/util/model_helper.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/json/json_translator.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/aliases/alias_utils.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/discover/multi_tenant_discoverer.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/discover/discoverer.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/util/target_helper.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/util/variable_injector_functions.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/deploy/multi_tenant_resources_deployer.py  
  inflating: weblogic-deploy/lib/python/wlsdeploy/tool/create/domain_typedef.py  
  inflating: weblogic-deploy/lib/python/variable_inject.py  
  inflating: weblogic-deploy/bin/discoverDomain.cmd  
  inflating: weblogic-deploy/bin/shared.sh  
  inflating: weblogic-deploy/lib/variable_keywords.json  
  inflating: weblogic-deploy/lib/injectors/host.json  
  inflating: weblogic-deploy/LICENSE.txt  
Updating the domain...
JDK version is 1.8.0_251-b08
JAVA_HOME = /u01/jdk
WLST_EXT_CLASSPATH = /home/oracle/weblogic-deploy/lib/weblogic-deploy-core.jar
CLASSPATH = /home/oracle/weblogic-deploy/lib/weblogic-deploy-core.jar
WLST_PROPERTIES = -Djava.util.logging.config.class=oracle.weblogic.deploy.logging.WLSDeployCustomizeLoggingConfig -Dcom.oracle.cie.script.throwException=true 
/u01/app/oracle/middleware/oracle_common/common/bin/wlst.sh /home/oracle/weblogic-deploy/lib/python/update.py -oracle_home /u01/app/oracle/middleware -domain_home /u01/data/domains/nonjrf_domain -model_file source.yaml -variable_file source.properties -archive_file source.zip -admin_user weblogic -admin_url t3://10.0.3.3:9071 -domain_type WLS

Initializing WebLogic Scripting Tool (WLST) ...

Welcome to WebLogic Server Administration Scripting Shell

Type help() for help on available commands

####<May 25, 2020 1:55:47 AM> <INFO> <WebLogicDeployToolingVersion> <logVersionInfo> <WLSDPLY-01750> <The WebLogic Deploy Tooling updateDomain version is 1.7.3:master.4f1ebfc:Apr 03, 2020 18:05 UTC>
Please enter the WebLogic administrator password: welcome1
####<May 25, 2020 1:56:04 AM> <INFO> <Validator> <__validate_model_file> <WLSDPLY-05002> <Performing validation in TOOL mode for WebLogic Server version 12.2.1.4.0 and WLST ONLINE mode>
####<May 25, 2020 1:56:04 AM> <INFO> <Validator> <__validate_model_file> <WLSDPLY-05003> <Performing model validation on the /home/oracle/source.yaml model file>
####<May 25, 2020 1:56:04 AM> <INFO> <Validator> <__validate_model_file> <WLSDPLY-05005> <Performing archive validation on the /home/oracle/source.zip archive file>
####<May 25, 2020 1:56:04 AM> <INFO> <Validator> <__validate_model_section> <WLSDPLY-05008> <Validating the domainInfo section of the model file>
####<May 25, 2020 1:56:04 AM> <INFO> <Validator> <__validate_model_section> <WLSDPLY-05009> <Model file /home/oracle/source.yaml does not contain a domainInfo section, validation of domainInfo was skipped.>
####<May 25, 2020 1:56:04 AM> <INFO> <Validator> <__validate_model_section> <WLSDPLY-05008> <Validating the topology section of the model file>
####<May 25, 2020 1:56:04 AM> <INFO> <Validator> <__validate_model_section> <WLSDPLY-05009> <Model file /home/oracle/source.yaml does not contain a topology section, validation of topology was skipped.>
####<May 25, 2020 1:56:04 AM> <INFO> <Validator> <__validate_model_section> <WLSDPLY-05008> <Validating the resources section of the model file>
####<May 25, 2020 1:56:04 AM> <INFO> <Validator> <__validate_model_section> <WLSDPLY-05008> <Validating the appDeployments section of the model file>
####<May 25, 2020 1:56:04 AM> <INFO> <Validator> <__validate_model_section> <WLSDPLY-05008> <Validating the kubernetes section of the model file>
####<May 25, 2020 1:56:04 AM> <INFO> <Validator> <__validate_model_section> <WLSDPLY-05009> <Model file /home/oracle/source.yaml does not contain a kubernetes section, validation of kubernetes was skipped.>
####<May 25, 2020 1:56:04 AM> <INFO> <filter_helper> <apply_filters> <WLSDPLY-20017> <No filter configuration file /home/oracle/weblogic-deploy/lib/model_filters.json>
####<May 25, 2020 1:56:04 AM> <INFO> <update> <__update_online> <WLSDPLY-09005> <Connecting to domain at t3://10.0.3.3:9071...>

####<May 25, 2020 1:56:06 AM> <INFO> <update> <__update_online> <WLSDPLY-09007> <Connected to domain at t3://10.0.3.3:9071>
####<May 25, 2020 1:56:07 AM> <INFO> <LibraryHelper> <install_domain_libraries> <WLSDPLY-12213> <The model did not specify any domain libraries to install>
####<May 25, 2020 1:56:07 AM> <INFO> <LibraryHelper> <extract_classpath_libraries> <WLSDPLY-12218> <The archive file /home/oracle/source.zip contains no classpath libraries to install>
####<May 25, 2020 1:56:07 AM> <INFO> <LibraryHelper> <install_domain_scripts> <WLSDPLY-12241> <The model did not specify any domain scripts to install>
####<May 25, 2020 1:56:07 AM> <INFO> <DatasourceDeployer> <_add_named_elements> <WLSDPLY-09608> <Updating JDBCSystemResource JDBCConnection>
####<May 25, 2020 1:56:07 AM> <INFO> <DatasourceDeployer> <_add_model_elements> <WLSDPLY-09604> <Updating JdbcResource for JDBCSystemResource JDBCConnection>
####<May 25, 2020 1:56:07 AM> <INFO> <DatasourceDeployer> <_add_model_elements> <WLSDPLY-09603> <Updating JDBCConnectionPoolParams for JdbcResource>
####<May 25, 2020 1:56:07 AM> <INFO> <DatasourceDeployer> <_add_model_elements> <WLSDPLY-09603> <Updating JDBCDataSourceParams for JdbcResource>
####<May 25, 2020 1:56:07 AM> <INFO> <DatasourceDeployer> <_add_model_elements> <WLSDPLY-09603> <Updating JDBCDriverParams for JdbcResource>
####<May 25, 2020 1:56:08 AM> <INFO> <DatasourceDeployer> <_add_named_elements> <WLSDPLY-09609> <Updating Properties user in JDBCDriverParams>
####<May 25, 2020 1:56:10 AM> <INFO> <ApplicationDeployer> <__deploy_app_online> <WLSDPLY-09316> <Deploying application SimpleDB>
####<May 25, 2020 1:56:14 AM> <INFO> <ApplicationDeployer> <__deploy_app_online> <WLSDPLY-09316> <Deploying application SimpleHTML>
####<May 25, 2020 1:56:17 AM> <INFO> <ApplicationDeployer> <__start_app> <WLSDPLY-09313> <Starting application SimpleDB>
####<May 25, 2020 1:56:21 AM> <INFO> <ApplicationDeployer> <__start_app> <WLSDPLY-09313> <Starting application SimpleHTML>

Issue Log for updateDomain version 1.7.3 running WebLogic version 12.2.1.4.0 online mode:

Total:       WARNING :     0    SEVERE :     0

updateDomain.sh completed successfully (exit code = 0)
```
</details>

### You're done!

## **STEP 6:** Check that the app deployed properly

1. Go to the WebLogic Admin console at https://`ADMIN_SERVER_PUBLIC_IP`:7002/console

    Note: If you're using Chrome, you might encounter Self-signed certificate issues. We recommend using Firefox to test.

2. In Firefox you will see the self-certificate warning as below:

    <img src="./images/self-cert-warning.png" width="100%">

    Click **Advanced...** and then **Accept the Risk and Continue**

3. Login with the Admin user `weblogic` and password: `welcome1`

4. Go to `deployments`: you should see the 2 applications deployed, and in the **active** state

  <img src="./images/oci-deployments.png" width="100%">

5. Go to the SimpleDB application URL, which is the Load Balancer IP gathered previously in the **Outputs** of the WebLogic provisioing, with the route `/SimpleDB/` like:
https://`LOAD_BALANCER_IP`/SimpleDB/

Making sure you use `https` as scheme and the proper case for `/SimpleDB` 

  <img src="./images/oci-simpledb-app.png" width="100%">


## Acknowledgements

 - **Author** - Emmanuel Leroy, May 2020
 - **Last Updated By/Date** - Emmanuel Leroy, August 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.

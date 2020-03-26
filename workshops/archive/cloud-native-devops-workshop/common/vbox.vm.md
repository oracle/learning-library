## On premise environment needed for some of the labs ##

There are two options how you can prepare that environment:

+ By importing distributed by Oracle Virtual Box image. Contact your local oracle representative or Maciej.Gruszka@oracle.com
+ By creation your own nevironment

#### How to create own environment ###
You need to install the following software:

Software | Expected path | Remarks
--- | --- | ---
JDK7 | /usr/java/jdk1.7.0_XX/ | We used JDK7u79 so the path in the VBox was /usr/java/jdk1.7.0_79/
JDK8 | /usr/java/jdk1.8.0_XX/ | We used JDK8u60 so the path in the VBox was /usr/java/jdk1.8.0_60/
Maven | /u01/wins/wls1221/oracle_common/modules/org.apache.maven_3.2.5 | Can be other location. Make sure it is added to PATH.
Local clone of remote repository| /u01/content/cloud-native-devops-workshop | 
Weblogic Server 10.3.6 | /u01/wins/wls1036/ | We used WLS 10.3.6.0.0
WebLogic Server 12.2.1 | /u01/wins/wls1221/ | We used WLS 12.2.1.0.0
Domain To Partition  Conversion Tool | /u01/dpct |
Oracle DataBase 12c | /u01/app/oracle/product/12.1.0/dbhome_1/ | The PDB name: **PDBORCL**

#### Modifying environment.properties file ###
To operate all scripts agains your own Oracle Public Cloud environment you need to set up file `environment.properties` in the `/u01/content/cloud-native-devops-workshop/cloud-utils` (YOUR_LOCAL_GIT_REPO_CLONE/cloud-utils) folder.
We have prepared two samples `environment.properties.us2` and `environment.properties.emea2` that you could customize and copy to `environment.properties` file.

The table below describes the meaning of variables stored in that file:

Property name|Property Value|Comment
--- | --- | ---
**Account properties**||
opc.base.url|jcs.emea.oraclecloud.com|For **EMEA** datacenter. For **US** use: jaas.oraclecloud.com
opc.identity.domain|YOUR IDENTITY DOMAIN|Identity domain.
opc.username|YOUR USERNAME|Cloud username
opc.password|YOUR PASSWORD|Cloud password
**Storage and container properties**||
opc.storage.generic.url|storage.oraclecloud.com|Generic storage URL to determine your storage REST endpoint
opc.storage.container|YOUR STORAGE CONTAINER NAME|Container name only.
**SSH key properties**||
ssh.user|opc|
ssh.public.key||Copy the content of your **publicKey** file generated during Database Cloud Service creation.
ssh.passphrase||The passphrase belongs to privateKey. Leave empty if there is no passphrase.
ssh.privatekey||The name of your file contains private key generated during Database Cloud Service creation. Make sure that the file is in the **YOUR_LOCAL_GIT_REPO_CLONE/cloud-utils** (in case provided VBox it is: /u01/content/cloud-native-devops-workshop/cloud-utils) folder. Most likely its name: **privateKey**
**Java Cloud Service properties**||
jcs.base.url|jaas.oraclecloud.com|
jcs.rest.url|/paas/service/jcs/api/v1.1/instances/|
jcs.instance.1|YOUR JCS INSTANCE NAME|Name of the Java Cloud Service instance.
jcs.instance.admin.user.1|USER NAME FOR WEBLOGIC ADMIN|Defined during JCS creation. Most likely **weblogic**
jcs.instance.admin.password.1|PASSWORD NAME FOR WEBLOGIC ADMIN|Defined during JCS creation.
**Database Cloud Service properties**||
dbcs.base.url|dbcs.emea.oraclecloud.com|For EMEA. For US datacenter: dbaas.oraclecloud.com
dbcs.rest.url|/paas/service/dbcs/api/v1.1/instances/|
dbcs.instance.1|YOUR DBCS INSTANCE NAME|Name of the Database Cloud Service instance.
dbcs.instance.sid.1|ORCL|
dbcs.instance.pdb1.1|PDB1|!If you have changed the default (**PDB1**) during Database Cloud Service creation change to that.
dbcs.dba.name|USER NAME FOR DBA|Defined during DBCS creation. Most likely it is **sys**.
dbcs.dba.password|PASSWORD FOR DBA|Defined during DBCS creation.

#### Creation of the Storage DBCS and JCS ###

If your OPC account is just fresh created account - no storage, no DBCS instance, no JCS instance - then modify in the `environment.properties` only three variables:
+ opc.identity.domain
+ opc.username
+ opc.password

and first execute the following scripts:

    $ [oracle@localhost Desktop]$ cd /u01/content/cloud-native-devops-workshop/cloud.utils
    $ [oracle@localhost cloud.utils]$ mvn install -Dgoal=generate-ssh-keypair
      (...) 
    $ [oracle@localhost cloud.utils]$ mvn install -Dgoal=jcs-create-auto
      (...)

It would create for you all needed instances on Java Cloud and Database Cloud Service. Please note the private key (required to access to the service's VM) generated in the `YOUR_LOCAL_GIT_REPO_CLONE/cloud-utils` folder and named `pk.openssh` by default. The generated public key pair can be found in your `environment.properties` file at the `ssh.public.key` property.



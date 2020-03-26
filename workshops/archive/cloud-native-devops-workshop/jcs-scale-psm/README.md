![](../common/images/customer.logo.png)
---
# ORACLE Cloud-Native DevOps workshop #
----
## Using the Command Line Interface ##

### About this tutorial ###
Oracle offers a PaaS Service Manager (PSM) Command Line Interface (CLI) that enables users of Oracle Application Container Cloud Service, Oracle Database Cloud Service, and Oracle Java Cloud Service to create, monitor and manage their service instances from a command shell or script.

For more information about PSM see the [documentation](https://docs.oracle.com/cloud/latest/jcs_gs/jcs_cli.htm).

### Prerequisites ###

- [Running Java Cloud Service,](../jcs-deploy/README.md)
- which has 2 nodes cluster or [scaled out Java Cloud Service](../jcs-scale-ui/README.md)
- [cURL command-line tool](http://curl.haxx.se/download.html). Usually cURL is already included in most of the Linux distributions and easy to install to Windows. You can use other tool to invoke REST API to download the latest version of the tool. (To install cURL is not scope of this documentation.)
- Python 3.3 or later. (To install Pyhton is not scope of this documentation.)

### Steps ###
#### Download the latest version of command line tool ####
First identify your REST API server name. If you log in to your Oracle cloud account with a US data center, use **psm.us.oraclecloud.com** otherwise, use **psm.europe.oraclecloud.com**.

Use cURL to send a request. The format is:

	curl -X GET -u username:password -H X-ID-TENANT-NAME:<identitydomain> https://<rest-server>/paas/core/api/v1.1/cli/<identitydomain>/client -o /u01/psmcli.zip

This will write the response to a file named `psmcli.zip`.

Open a terminal and execute the cURL command above with your credentials, identity domain identifier and REST API server name. REST 

	[oracle@localhost Desktop]$ curl -X GET -u john.i.smith@xxxxx.com:password -H X-ID-TENANT-NAME:hujohni https://psm.europe.oraclecloud.com/paas/core/api/v1.1/cli/hujohni/client -o /u01/psmcli.zip
	% Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                   Dload  Upload   Total   Spent    Left  Speed
	100 45968  100 45968    0     0  10993      0  0:00:04  0:00:04 --:--:-- 10999
	[oracle@localhost Desktop]$

Change to directory `/u01` and list directory to check the downloaded psmcli.zip file.

	[oracle@localhost Desktop]$ cd /u01
	[oracle@localhost u01]$ ls
	app  content  dpct  oepe-12.2.1.4.201608161938  psmcli.zip  python  wins

#### Installing the Command Line Interface

Install the PaaS CLI as a Python package.

Open a terminal, change to directory or make sure you are in directory `/u01` and use the PIP tool to install the CLI Python package.
	
	[oracle@localhost Desktop]$ cd /u01
	[oracle@localhost Desktop]$ sudo -H /u01/python/bin/pip3 install -U psmcli.zip
	Processing ./psmcli.zip
	Collecting requests<=2.8.1,>=2.7.0 (from psmcli==1.1.7)
	  Downloading requests-2.8.1-py2.py3-none-any.whl (497kB)
    	100% |████████████████████████████████| 501kB 469kB/s 
	Collecting keyring<=5.6,>=5.4 (from psmcli==1.1.7)
	  Downloading keyring-5.6.tar.gz (69kB)
    	100% |████████████████████████████████| 71kB 1.0MB/s 
	Collecting colorama==0.3.3 (from psmcli==1.1.7)
	  Downloading colorama-0.3.3.tar.gz
	Collecting PyYAML==3.11 (from psmcli==1.1.7)
	  Downloading PyYAML-3.11.zip (371kB)
    	100% |████████████████████████████████| 378kB 725kB/s 
	Installing collected packages: requests, keyring, colorama, PyYAML, psmcli
	  Running setup.py install for keyring ... done
      Running setup.py install for colorama ... done
      Running setup.py install for PyYAML ... done
      Running setup.py install for psmcli ... done
	Successfully installed PyYAML-3.11 colorama-0.3.3 keyring-5.6 psmcli-1.1.7 requests-2.8.1
	You are using pip version 8.1.1, however version 8.1.2 is available.
	You should consider upgrading via the 'pip install --upgrade pip' command.
	[oracle@localhost u01]$

####Configuring the Command Line Interface####
Prior to running CLI commands, configure your connection to the Oracle cloud.

Open a terminal and run the `setup` command. When prompted, enter your cloud user name, password, and identity domain. For example:

	[oracle@localhost u01]$ psm setup
	Username: john.i.smith@xxxxx.com
	Password: 
	Retype Password: 
	Identity domain: hujohni
	Region [us]: emea
	Output format [json]: 
	----------------------------------------------------
	'psm setup' was successful. Available services are:
	  o MySQLCS : Oracle Oracle MySQL Cloud Service
      o accs : Oracle Application Container Cloud Service
      o dbcs : Oracle Database Cloud Service
	  o ggcs : Oracle GoldenGate Cloud Service
      o jcs : Oracle Java Cloud Service
      o stack : Cloud Stack Manager
	----------------------------------------------------
	[oracle@localhost u01]$

The CLI provides help text for each available command. Use the help (or h) parameter to:

View the available services in your configured cloud account. For example:

	[oracle@localhost u01]$ psm help

	DESCRIPTION
  		A command line tool to interact with Oracle Cloud Platform Services (PaaS)

	SYNOPSIS
  		psm <service> <command> [parameters]

	AVAILABLE SERVICES
	  o MySQLCS
	       Oracle Oracle MySQL Cloud Service
	  o accs
	       Oracle Application Container Cloud Service
	  o dbcs
	       Oracle Database Cloud Service
	  o ggcs
	       Oracle GoldenGate Cloud Service
	  o jcs
	       Oracle Java Cloud Service
	  o stack
	       Cloud Stack Manager
	  o setup
	       Configure psm client options
	  o update
	       Update psm client to latest version
	  o log
	       View or update psm client log level
	  o help
	       Show help

	AVAILABLE PARAMETERS
	  -v, --version  
	       Show current version of psm client

	[oracle@localhost u01]$ 

View the available commands for a service:

	[oracle@localhost u01]$ psm jcs help

	DESCRIPTION
	  Oracle Java Cloud Service
	
	SYNOPSIS
	  psm jcs <command> [parameters]
	
	AVAILABLE COMMANDS
	  o services
	       List all Oracle Java Cloud Service instances
	  o service
	       List an Oracle Java Cloud Service instance
	  o create-service
	       Create an Oracle Java Cloud Service instance
	  o import
	       Migrate an OnPremise WLS Domain to the Oracle Java Cloud Service instance
	  o delete-service
	       Delete an Oracle Java Cloud Service instance
	  o stop
	       Stop an Oracle Java Cloud Service instance, Managed Server or load balancer...
	  o start
	       Start an Oracle Java Cloud Service instance, Managed Server or load...
	  o restart
	       Restart an Oracle Java Cloud Service instance, Administration Server,...
	  o scale-out
	       Add a new Managed Server to the specified cluster to scale-out the Oracle...
	  o scale-in
	       Remove a Managed Server to scale-in the Oracle Java Cloud Service instance...
	  o scale-up
	       Scale the specified Administration Server or Managed Server node on an...
	  o scale-down
	       Scale the specified Administration Server or Managed Server node on an...
	  o view-backup-config
	       List backup configuration of an Oracle Java Cloud Service instance
	  o update-backup-config
	       Update backup configuration of an Oracle Java Cloud Service instance
	  o view-backups
	       List all backups of an Oracle Java Cloud Service instance
	  o view-backup
	       List a backup of an Oracle Java Cloud Service instance
	  o backup
	       Initiate an on-demand backup for an Oracle Java Cloud Service instance
	  o delete-backup
	       Delete a backup of an Oracle Java Cloud Service instance
	  o view-restores
	       List all restore operations for an Oracle Java Cloud Service instance
	  o view-restore
	       List a specified restore operation for an Oracle Java Cloud Service instance.
	  o restore
	       Restore an Oracle Java Cloud Service instance from the specified backup....
	  o available-patches
	       List all available patches for an Oracle Java Cloud Service instance
	  o applied-patches
	       List all applied patches for an Oracle Java Cloud Service instance
	  o precheck-patch
	       Precheck to identify potential issues that might prevent the specified...
	  o patch
	       Apply a patch to an Oracle Java Cloud Service instance
	  o rollback
	       Roll back a patch for an Oracle Java Cloud Service instance
	  o operation-status
	       View status of an Oracle Java Cloud Service instance operation
	  o access-rules
	       List access rules for Oracle Java Cloud Service instance
	  o create-access-rule
	       Create an access rule for Oracle Java Cloud Service instance
	  o delete-access-rule
	       Delete an access rule for Oracle Java Cloud Service instance
	  o enable-access-rule
	       Enable an access rule for Oracle Java Cloud Service instance
	  o disable-access-rule
	       Disable an access rule for Oracle Java Cloud Service instance
	  o help
	       Show help

	[oracle@localhost u01]$ 

View the available parameters for a specific command along with examples.
	
	[oracle@localhost Desktop]$ psm jcs create-service help
	
	DESCRIPTION
	  Create an Oracle Java Cloud Service instance
	
	SYNOPSIS
	  psm jcs create-service [parameters]
	       -c, --config-payload <value>
	       [-of, --output-format <value>]
	
	AVAILABLE PARAMETERS
	  -c, --config-payload    (file)
	       Path to JSON file containing Oracle Java Cloud Service provisioning
	       configuration parameters
	
	  -of, --output-format    (string)
	       Desired output format. Valid values are [json, html]
	
	EXAMPLES
	  psm jcs create-service -c /home/templates/create-jcs-service.json
	
	[oracle@localhost Desktop]$ 

####Use the Command Line Interface####
First list the Java Cloud Services in the configured identity domain:

	[oracle@localhost Desktop]$ psm jcs services
	{
	    "uri":"https://psm.europe.oraclecloud.com/paas/service/jcs/api/v1.1/instances/hujohni",
	    "service_type":"jaas",
	    "implementation_version":"1.0",
	    "services":[
	        {
	            "service_name":"techco",
	            "version":"12cRelease2",
	            "wlsVersion":"12.2.1.0.160419",
	            "status":"Running",
	            "error_status_desc":"",
	            "compliance_status":"",
	            "compliance_status_desc":"",
	            "auto_update":"true",
	            "description":"TechCo sample app runtime environment",
	            "identity_domain":"hujohni",
	            "creation_time":"Sat Aug 20 10:3:45 UTC 2016",
	            "last_modified_time":"Sat Aug 20 10:3:43 UTC 2016",
	            "created_by":"john.i.smith@xxxxx.com",
	            "service_uri":"https://psm.europe.oraclecloud.com/paas/service/jcs/api/v1.1/instances/hujohni/techco"
	        }
	    ]
	}

To get more details about specific service use psm service -s servicename command:

	[oracle@localhost Desktop]$ psm jcs service -s techco
	{
	    "service_name":"techco",
	    "version":"12cRelease2",
	    "wlsVersion":"12.2.1.0.160419",
	    "status":"Running",
	    "error_status_desc":"",
	    "compliance_status":"",
	    "compliance_status_desc":"",
	    "auto_update":"true",
	    "description":"TechCo sample app runtime environment",
	    "identity_domain":"hujohni",
	    "creation_time":"Sat Aug 20 10:3:45 UTC 2016",
	    "last_modified_time":"Sat Aug 20 10:3:43 UTC 2016",
	    "created_by":"john.i.smith@xxxxx.com",
	    "service_uri":"https://psm.europe.oraclecloud.com/paas/service/jcs/api/v1.1/instances/hujohni/techco",
	    "domain_name":"techco_domain",
	    "domain_mode":"PRODUCTION",
	    "cluster_name":"techco_cluster",
	    "num_nodes":2,
	    "level":"PAAS",
	    "subscription_type":"MONTHLY",
	    "edition":"EE",
	    "shape":"oc3",
	    "otd_provisioned":"no",
	    "service_components":[
	        {
	            "type":"JDK",
	            "version":"1.8.0_91"
	        },
	        {
	            "type":"OTD",
	            "version":"12.2.1.0.0"
	        },
	        {
	            "type":"WLS",
	            "version":"12.2.1.0.160419"
	        },
	        {
	            "type":"OTD_JDK",
	            "version":"1.8.0_91"
	        }
	    ],
	    "creation_job_id":"1825892",
	    "deletion_job_id":0,
	    "db_info":"techcoDB:1521/PDB1.hujohni.oraclecloud.internal",
	    "db_service_name":"techcoDB",
	    "useStackTag":"false",
	    "num_ip_reservations":2,
	    "wls_admin_url":"https://xxx.86.6.145:7002/console",
	    "fmw_control_url":"https://xxx.86.6.145:7002/em",
	    "sample_app_url":"https://xxx.86.6.145/sample-app/",
	    "content_url":"http://xxx.86.6.145",
	    "secure_content_url":"https://xxx.86.6.145",
	    "wls_deployment_channel_port":xxxx,
	    "psm_plugin_version":"16.3.3-137",
	    "compute_site_name":"EM002_Z14",
	    "db_associations":[
	        {
	            "db_service_name":"techcoDB",
	            "db_infra":true,
	            "db_connect_string":"techcoDB:1521/PDB1.hujohni.oraclecloud.internal",
	            "pdb_service_name":"PDB1",
	            "db_version":"12.1.0.2"
	        }
	    ]
	}
	[oracle@localhost Desktop]$ 

Leave this terminal open.

####Scale-In a Java Cloud Service instance####

First we need to check that the previously submitted Scale-Out request has been finished.[Sign in](../common/sign.in.to.oracle.cloud.md) to [https://cloud.oracle.com/sign-in](https://cloud.oracle.com/sign-in). On the dashboard open the Java Cloud Service Console.

![](images/00.png)

Click the name of the service instance to which the application is deployed.

![](images/01.png)

Check the Managed Server name on the second node.

![](images/02.png)

Go back to the terminal where psm was used and get the help of the scale-in command.

	[oracle@localhost Desktop]$ psm jcs scale-in help
	
	DESCRIPTION
	  Remove a Managed Server to scale-in the Oracle Java Cloud Service instance by
	  one node.
	
	SYNOPSIS
	  psm jcs scale-in [parameters]
	       -s, --service-name <value>
	       -n, --name <value>
	       [-f, --force <value>]
	       [-of, --output-format <value>]
	
	AVAILABLE PARAMETERS
	  -s, --service-name    (string)
	       Name of the Oracle Java Cloud Service instance
	
	  -n, --name    (string)
	       Name of the Managed Server to remove
	
	  -f, --force    (boolean)
	       Flag that specifies whether you want to force the removal of the Managed
	       Server, regardless of whether there are processes running. This value defaults
	       to false.
	
	  -of, --output-format    (string)
	       Desired output format. Valid values are [json, html]
	
	EXAMPLES
	  psm jcs scale-in -s ExampleInstance -n ExampleI_server_4
	
	[oracle@localhost Desktop]$ 

According to the help give the necessary parameters to scale in the **techco** service.

	[oracle@localhost Desktop]$ psm jcs scale-in -s techco -n techco_d_server_2
	{
	    "status":"New",
	    "details":{
	        "message":"JAAS-SCALING-044: Scaling in Job (ID: 1833472) server name [techco_d_server_2] submitted for service [techco]",
	        "jobId":"1833472"
	    }
	}
	Job ID : 1833472
	[oracle@localhost Desktop]$ 

The response shows the Scaling in Job has been submitted. You can get further information about the job using the provided jobId in the answer. Obviously if you have different service and/or managed server name then replace the parameters to reflect your environment properties.

Go back to the browser where the service detail page is still opened and click on refresh or on Topology tile. Now you can see the service has changed to maintenance mode (exclamation mark) and Topology tile shows *Scaling...* is in progress.

![](images/03.png)
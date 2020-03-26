![](../common/images/customer.logo.png)
---
# ORACLE Cloud-Native DevOps workshop #
----
## Delete Application Cloud Container Service using PaaS Service Manager (PSM) Command Line Interface (CLI) ##

### About this tutorial ###

This tutorial demonstrates how to delete Application Container Cloud Service PaaS Service Manager (PSM) Command Line Interface (CLI).
	
### Prerequisites ###

+ [Deploy Tomcat sample application to Oracle Application Container Cloud](../accs-tomcat/README.md)
+ [Install and configure PaaS Service Manager (PSM) Command Line Interface (CLI)](../jcs-scale-psm/README.md)

### Steps ###

#### Delete Application Cloud Container Service using psm CLI tool ####

Open a terminal and list your application(s) deployed on Application Container Cloud Service. Execute the `psm accs apps` command to list the applications.

	[oracle@localhost cloud.demos]$ psm accs apps
	{
	    "applications":[
	        {
	            "identityDomain":"hujohni",
	            "appId":"7c0ab2ad-a1c3-482c-8542-add237657212",
	            "name":"tomcat",
	            "status":"RUNNING",
	            "createdBy":"john.i.smith@freemail.hu",
	            "creationTime":"2016-08-28T08:02:46.503+0000",
	            "lastModifiedTime":"2016-08-28T08:02:46.458+0000",
	            "subscriptionType":"MONTHLY",
	            "instances":[
	                {
	                    "name":"web.1",
	                    "status":"RUNNING",
	                    "memory":"2G",
	                    "instanceURL":"https://psm.europe.oraclecloud.com/paas/service/apaas/api/v1.1/apps/hujohni/tomcat/instances/web.1"
	                }
	            ],
	            "runningDeployment":{
	                "deploymentId":"5075e814-3430-45b2-9b02-61ec88f4b8ea",
	                "deploymentStatus":"READY",
	                "deploymentURL":"https://psm.europe.oraclecloud.com/paas/service/apaas/api/v1.1/apps/hujohni/tomcat/deployments/5075e814-3430-45b2-9b02-61ec88f4b8ea"
	            },
	            "lastestDeployment":{
	                "deploymentId":"5075e814-3430-45b2-9b02-61ec88f4b8ea",
	                "deploymentStatus":"READY",
	                "deploymentURL":"https://psm.europe.oraclecloud.com/paas/service/apaas/api/v1.1/apps/hujohni/tomcat/deployments/5075e814-3430-45b2-9b02-61ec88f4b8ea"
	            },
	            "appURL":"https://psm.europe.oraclecloud.com/paas/service/apaas/api/v1.1/apps/hujohni/tomcat",
	            "webURL":"https://tomcat-hujohni.apaas.em2.oraclecloud.com"
	        }
	    ]
	}
	[oracle@localhost cloud.demos]$ 

You should have one application called **tomcat**. Now you need the command which deletes Application Container Cloud Service. Execute the help to get this command:

	[oracle@localhost cloud.demos]$ psm accs help

	DESCRIPTION
	  Oracle Application Container Cloud Service
	
	SYNOPSIS
	  psm accs <command> [parameters]
	
	AVAILABLE COMMANDS
	  o apps
	       List all Oracle Application Container Cloud applications
	  o app
	       List an Oracle Application Container Cloud application
	  o push
	       Create or Update an Oracle Application Container Cloud application
	  o scale
	       Scale an Oracle Application Container Cloud Service instance for a...
	  o delete
	       Delete an Oracle Application Container Cloud application
	  o stop
	       Stop an Oracle Application Container Cloud application
	  o start
	       Start an Oracle Application Container Cloud application
	  o restart
	       Restart an Oracle Application Container Cloud application
	  o logs
	       List log details of all the instances of an Oracle Application Container...
	  o log
	       View log details of an instance of an Oracle Application Container Cloud...
	  o get-logs
	       Request for log details of an instance of an Oracle Application Container...
	  o recordings
	       View recording details of all the instances of an Oracle Application...
	  o recording
	       List recording details of an instance of an Oracle Application Container...
	  o get-recordings
	       Request for recording details of an instance of an Oracle Application...
	  o operation-status
	       View status of an Oracle Application Container Cloud application operation
	  o help
	       Show help
	
	[oracle@localhost Desktop]$ 

The command is `delete`. Check the syntax of this command using help again:

	[oracle@localhost Desktop]$ psm accs delete help
	
	DESCRIPTION
	  Delete an Oracle Application Container Cloud application
	
	SYNOPSIS
	  psm accs delete [parameters]
	       -n, --app-name <value>
	       [-of, --output-format <value>]
	
	AVAILABLE PARAMETERS
	  -n, --app-name    (string)
	       Name of the application
	
	  -of, --output-format    (string)
	       Desired output format. Valid values are [json, html]
	
	EXAMPLES
	  psm accs delete -n ExampleApp
	
	[oracle@localhost Desktop]$ 

It requires -obviously- the name of the application. You have the correct syntax and the application name so delete the application.

	[oracle@localhost Desktop]$ psm accs delete -n tomcat
	{
	    "identityDomain":"hujohni",
	    "appId":"7c0ab2ad-a1c3-482c-8542-add237657212",
	    "name":"tomcat",
	    "status":"RUNNING",
	    "createdBy":"john.i.smith@freemail.hu",
	    "creationTime":"2016-08-28T08:02:46.503+0000",
	    "lastModifiedTime":"2016-08-28T08:02:46.458+0000",
	    "subscriptionType":"MONTHLY",
	    "instances":[
	        {
	            "name":"web.1",
	            "status":"RUNNING",
	            "memory":"1G",
	            "instanceURL":"https://psm.europe.oraclecloud.com/paas/service/apaas/api/v1.1/apps/hujohni/tomcat/instances/web.1"
	        }
	    ],
	    "runningDeployment":{
	        "deploymentId":"5075e814-3430-45b2-9b02-61ec88f4b8ea",
	        "deploymentStatus":"READY",
	        "deploymentURL":"https://psm.europe.oraclecloud.com/paas/service/apaas/api/v1.1/apps/hujohni/tomcat/deployments/5075e814-3430-45b2-9b02-61ec88f4b8ea"
	    },
	    "lastestDeployment":{
	        "deploymentId":"5075e814-3430-45b2-9b02-61ec88f4b8ea",
	        "deploymentStatus":"READY",
	        "deploymentURL":"https://psm.europe.oraclecloud.com/paas/service/apaas/api/v1.1/apps/hujohni/tomcat/deployments/5075e814-3430-45b2-9b02-61ec88f4b8ea"
	    },
	    "currentOngoingActivity":"Deleting Application",
	    "appURL":"https://psm.europe.oraclecloud.com/paas/service/apaas/api/v1.1/apps/hujohni/tomcat",
	    "webURL":"https://tomcat-hujohni.apaas.em2.oraclecloud.com",
	    "message":[]
	}
	Job ID : 1929334
	[oracle@localhost Desktop]$ 

The delete job has been submitted successfully. The Application Cloud Service termination and clean up takes few minutes. You can check the resullt using the Application Container Cloud user interface or list the applications periodically using `psm accs apps`. 
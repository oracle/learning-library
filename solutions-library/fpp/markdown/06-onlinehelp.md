# A Quick Example of FPP’s Online Help

[//]: # (Author: David LaPoint david.lapoint@oracle.com)

[Return to FPP Introduction](IntroPage.md)

## Requirements:

1.	An Installed GI home capable of executing `$GI_Home/bin` commands, specifically `$GI_Home/bin/rhpctl`.

## Overview:

1.	FPP uses the command line interface of rhpctl.  It has a build in CLI help interface which can aid in the building and clarification of command syntax.
2.	RHPCTL uses the command format of “`rhpctl command object [parameters]`”
3.	You can use -h with almost any segment of the command to gain more details and possible options.

## Example:
rhpctl with only `-h` 

	$ rhpctl -h
	Performs Rapid Home Provisioning operations and manages Rapid Home Provisioning Servers and Clients.
	
	Usage:
	         rhpctl add                   Adds a resource, type or other entity.
	         rhpctl addnode               Adds nodes or instances of specific resources.
	<snip>
	         rhpctl zdtupgrade            Performs zero downtime upgrade of a database.
	
	For detailed help on each command use:
	        rhpctl <command> -help

And to see the options for the verb 'add'.

	$ rhpctl add -h
	Adds a resource, type or other entity.
	
	Usage:
	         rhpctl add client              Adds a Rapid Home Provisioning Client to the Rapid Home Provisioning Server configuration.
	         rhpctl add credentials         Adds credentials to the OCR.
	         rhpctl add database            Creates a database using the specified working copy.
	         rhpctl add image               Creates a new image from an existing working copy.
	         rhpctl add imagetype           Configures a new image type of the specified name and its associated user actions.
	         rhpctl add role                Adds a new role to list of existing roles on the Rapid Home Provisioning Server configuration.
	         rhpctl add series              Adds a series.
	         rhpctl add useraction          Configures a new user action of the specified name with its associated script and action file.
	         rhpctl add workingcopy         Adds a working copy.
	
	For detailed help on each command and object and its options use:
	  rhpctl <command> <object> -help


And to drill down to using add for a specific object, in this can an image

	$ rhpctl add image -h
	
	Creates a new image from an existing working copy.
	
	Usage: rhpctl add image -image <image_name> -workingcopy <workingcopy_name>
	        [-imagetype <image_type>]
	        [-series <series_name>]
	        [-state
	                {TESTABLE|
	                RESTRICTED|
	                PUBLISHED}]
	
	    -image <image_name>                       Name of the image
	    -workingcopy <workingcopy_name>           Name of the working copy
	    -imagetype <image_type>                   The software type. ('ORACLEDBSOFTWARE' (default) for Oracle database software, 'ORACLEGISOFTWARE' for Oracle Grid Infrastructure software, ORACLEGGSOFTWARE for Oracle GoldenGate software, 'LINUXOS' for linux Opearting System ISO, and 'SOFTWARE' for all other software. For a custom image type, use the image type name.)
	    -series <series_name>                     Name of the series
	    -state {TESTABLE|RESTRICTED|PUBLISHED}    State name

#### Additional Information:
Please consult the FPP Concepts and Command Reference in the Oracle Clusterware Administration and Deployment Guide.
https://docs.oracle.com/en/database/oracle/oracle-database/index.html  


[//]: # (Author:David LaPoint david.lapoint@oracle.com)



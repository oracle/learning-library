# How to Create (Add) Your First Working Copy (Grid Infrastructure Home)

[//]: # (Author: David LaPoint david.lapoint@oracle.com)

[Return to FPP Introduction](IntroPage.md)

## Requirements:

1.	An FPP GI image of the desired version and patch level

## Overview:

1.	Add the workingcopy of the GI image
2. Query new workingcopy

### Step 1 – Add GI Workingcopy
	$ rhpctl add workingcopy -image GI195_191015 -path /opt/oracrs/gridsw/grid195.191015 -softwareonly -workingcopy GI195_191015_WC_fpps

Please note the use of -softwareonly parameter.  This creates the GI home but does not move the existing GI process to use it automatically, which is the default.

### Step 2 – Query Your Workingcopy

Confirm ‘Complete: TRUE’

	$ rhpctl query workingcopy - workingcopy GI195_191015_WC_fpps

## Example output:

This example adds a 19.5 GI workingcopy to a 4 node Exadata FPP server.  Some output snipped for brevity.  Please also note that the usual installation directives for running root.sh are still echoed to the screen, however FPP is managing all those requirements.

	$ rhpctl add workingcopy -image GI195_191015 -path /opt/oracrs/gridsw/grid195.191015 -softwareonly -workingcopy GI195_191015_WC_fpps
	fpp-server-n03: Audit ID: 28
	fpp-server-n03: Storing metadata in repository for working copy "GI195_191015_WC_fpps" ...
	fpp-server-n03: Changing the home ownership to user exagrid:...
	fpp-server-n03: Changing the home ownership to user exagrid:...
	fpp-server-n03: Changing the home ownership to user exagrid:...
	fpp-server-n03: Changing the home ownership to user exagrid:...
	fpp-server-n03: Starting transfer for remote copy ...
	fpp-server-n03: Copying home contents...
	fpp-server-n03: Changing the home ownership to user exagrid...
	fpp-server-n03: Provisioning Oracle home...
	fpp-server-n03: Starting clone operation...
	<snip>
	fpp-server-n03: You can find the log of this install session at:
	 /opt/orainv/inv/logs/cloneActions2020-04-24_11-33-57PM.log
	fpp-server-n03: You can find the log of this install session at:
	 /opt/orainv/inv/logs/cloneActions2020-04-24_11-33-57PM.log
	fpp-server-n03: You can find the log of this install session at:
	 /opt/orainv/inv/logs/cloneActions2020-04-24_11-33-57PM.log
	fpp-server-n03: You can find the log of this install session at:
	 /opt/orainv/inv/logs/cloneActions2020-04-24_11-33-57PM.log
	fpp-server-n03: ..................................................   5% Done.
	..................................................   10% Done.
	<snip>
	..................................................   80% Done.
	fpp-server-n03: ..................................................   85% Done.
	fpp-server-n03: ..................................................   5% Done.
	..................................................   10% Done.
	<snip>
	..................................................   80% Done.
	fpp-server-n03: ..................................................   85% Done.
	fpp-server-n03: ..................................................   5% Done.
	..................................................   10% Done.
	<snip>
	..................................................   80% Done.
	fpp-server-n03: ..................................................   85% Done.
	fpp-server-n03: ..........
	Copy files in progress.
	fpp-server-n03: ..................................................   5% Done.
	..................................................   10% Done.
	<snip>
	..................................................   80% Done.
	fpp-server-n03: ..................................................   85% Done.
	fpp-server-n03: ..........
	Copy files in progress.
	fpp-server-n03: ..........
	Copy files in progress.
	fpp-server-n03: Copy files successful.
	
	Link binaries in progress.
	fpp-server-n03: ..........
	Copy files in progress.
	fpp-server-n03: Copy files successful.
	
	Link binaries in progress.
	fpp-server-n03: Copy files successful.
	
	Link binaries in progress.
	fpp-server-n03: Copy files successful.
	
	Link binaries in progress.
	fpp-server-n03: ..........
	Link binaries successful.
	
	Setup files in progress.
	fpp-server-n03: ..........
	Link binaries successful.
	
	Setup files in progress.
	..........
	Setup files successful.
	
	Setup Inventory in progress.
	fpp-server-n03: ..........
	Setup files successful.
	
	Setup Inventory in progress.
	fpp-server-n03: ..........
	Link binaries successful.
	
	Setup files in progress.
	fpp-server-n03: Setup Inventory successful.
	..........
	Finish Setup successful.
	The cloning of GI195_191015_WC_fpps was successful.
	Please check '/opt/orainv/inv/logs/cloneActions2020-04-24_11-33-57PM.log' for more details.
	
	Setup Oracle Base in progress.
	fpp-server-n03: Setup Inventory successful.
	..........
	Finish Setup successful.
	The cloning of GI195_191015_WC_fpps was successful.
	Please check '/opt/orainv/inv/logs/cloneActions2020-04-24_11-33-57PM.log' for more details.
	
	Setup Oracle Base in progress.
	fpp-server-n03: ..........
	Setup files successful.
	
	Setup Inventory in progress.
	fpp-server-n03: Setup Oracle Base successful.
	..................................................   95% Done.
	
	As a root user, execute the following script(s):
		1. /opt/oracrs/gridsw/grid195.191015/root.sh
	
	Execute /opt/oracrs/gridsw/grid195.191015/root.sh on the following nodes:
	[fpp-server-n01]
	
	
	..................................................   100% Done.
	fpp-server-n03: Setup Oracle Base successful.
	..................................................   95% Done.
	
	As a root user, execute the following script(s):
		1. /opt/oracrs/gridsw/grid195.191015/root.sh
	
	Execute /opt/oracrs/gridsw/grid195.191015/root.sh on the following nodes:
	[fpp-server-n04]
	
	
	..................................................   100% Done.
	fpp-server-n03: Setup Inventory successful.
	fpp-server-n03: ..........
	Finish Setup successful.
	The cloning of GI195_191015_WC_fpps was successful.
	Please check '/opt/orainv/inv/logs/cloneActions2020-04-24_11-33-57PM.log' for more details.
	
	Setup Oracle Base in progress.
	
	Setup Oracle Base successful.
	..................................................   95% Done.
	
	As a root user, execute the following script(s):
		1. /opt/oracrs/gridsw/grid195.191015/root.sh
	
	Execute /opt/oracrs/gridsw/grid195.191015/root.sh on the following nodes:
	[fpp-server-n02]
	
	..................................................   100% Done.
	fpp-server-n03: ..........
	Link binaries successful.
	
	Setup files in progress.
	..........
	Setup files successful.
	
	Setup Inventory in progress.
	fpp-server-n03: Setup Inventory successful.
	..........
	Finish Setup successful.
	The cloning of GI195_191015_WC_fpps was successful.
	Please check '/opt/orainv/inv/logs/cloneActions2020-04-24_11-33-57PM.log' for more details.
	
	Setup Oracle Base in progress.
	
	Setup Oracle Base successful.
	..................................................   95% Done.
	
	As a root user, execute the following script(s):
		1. /opt/oracrs/gridsw/grid195.191015/root.sh
	
	Execute /opt/oracrs/gridsw/grid195.191015/root.sh on the following nodes:
	[fpp-server-n03]
	
	..................................................   100% Done.
	fpp-server-n03: Successfully executed clone operation.
	fpp-server-n03: Executing root script on nodes [fpp-server-n01, fpp-server-n02, fpp-server-n03, fpp-server-n04].
	fpp-server-n03: Successfully executed root script on nodes [fpp-server-n01, fpp-server-n02, fpp-server-n03, fpp-server-n04].
	fpp-server-n03: Oracle home provisioned.
	fpp-server-n03: Working copy creation completed.

The new workingcopy is complete, now confirm that it's visisable via FPP (rhpctl) and that *'Complete'* shows as 'TRUE'.  You can also tell that the new GI home is not active by the entry *'Software only:'* showing 'true'.  When the new GI home is active, it will show as 'false'.
	
	$ rhpctl query workingcopy
	fpp-server-n03: Audit ID: 29
	Working copy name: GI193tmp
	Working copy name: GI195_191015_WC_fpps
	
	
	$ rhpctl query workingcopy -workingcopy GI195_191015_WC_fpps
	fpp-server-n03: Audit ID: 30
	Working copy name: GI195_191015_WC_fpps
	Image name: GI195_191015
	Groups configured in the working copy: OSDBA=exaosdb,OSOPER=exaosope,OSASM=exaosasm
	Owner: exagrid@fpp-server-cluster
	Site: fpp-server-cluster
	Access control: USER:exagrid@fpp-server-cluster
	Access control: ROLE:GH_WC_ADMIN
	Software home path: /opt/oracrs/gridsw/grid195.191015
	Storage type: LOCAL
	Image Type: ORACLEGISOFTWARE
	Software only: true
	Gold image path:
	Work path:
	Cluster Name: fpp-server-cluster
	Cluster Type:
	Cluster Mode:
	Cluster Class:
	Cluster Nodes: fpp-server-n01,fpp-server-n02,fpp-server-n03,fpp-server-n04
	All patches available in this home: 30368482,30363621,30585645,30312546,30125133,30122149,29401763
	Additional patches compared to the image:
	Additional bug fixes that are not in the image:
	Complete: TRUE 



[//]: # (Author:David LaPoint david.lapoint@oracle.com)



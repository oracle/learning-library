# How To Create Your First FPP Server

[//]: # (Author: David LaPoint david.lapoint@oracle.com)

[Return to FPP Introduction](IntroPage.md)

## Requirements:
1. Node or Cluster running Oracle Grid Infrastructure 12.2 or later
1. 200 GB free disk space in an ASM disk group – either existing or new DG
1. Available IP address on the same subnet as the Net1 public network
1. MGMTDB aka Management DB
1. Root access to a few commands


## Overview:
1. If needed, remove local mode only version of FPP server
1. Determine desired disk group for storing images
1. Create ACFS file system mount point for images
1. Create Grid Naming Service (GNS)
1. Create multi-cluster FPP server
1. Start FPP server
1. Check status of FPP server

### Step 1 – Remove local mode only version of FPP server
Confirm if rhpserver is present.

	# srvctl status rhpserver
	Rapid Home Provisioning Server is enabled
	Rapid Home Provisioning Server is not running

	# srvctl stop rhpserver
Ignore any message similar to "Fleet Patching and Provisioning Server is not running".

	# srvctl remove rhpserver -f

Clean up local RHP directories on each node ($ORACLE_BASE/rhp\_images/chkbase)

	# rm -Rf $ORACLE_BASE/rhp_images

###Step 2 - Determine desired disk group for storing images

	$ ASMCMD> lsdg

###Step 3 – Create ACFS file system mount point for images
	# mkdir -p /rhp

###Step 4 - Create GNS

	# srvctl add gns -vip 10.31.226.237

###Step 5 - Create multi-cluster FPP server

	# srvctl add rhpserver -storage /rhp -diskgroup data

###Step 6 – Start FPP server

	$ srvctl start rhpserver

###Step 7 – Status of FPP server

	$ srvctl status rhpserver

##Example output
	$ srvctl status rhpserver
	
	Rapid Home Provisioning Server is enabled
	Rapid Home Provisioning Server is running on node fpp-server-n04 
	

[//]: # (Author: David LaPoint david.lapoint@oracle.com)


# How to Create (Import) a Grid Infrastructure (Gold) Image

[//]: # (Author:David LaPoint david.lapoint@oracle.com)

[Return to FPP Introduction](IntroPage.md)

## Requirements:
1. An Installed GI home of desired configuration

## Overview:
1. Import new image
2. Query new image

### Step 1 – Import Your Image

	$ rhpctl import image -image GI183_180717 -path /u01/app/18.1.0.0/grid -imagetype ORACLEGISOFTWARE

### Step 2 – Query Your Image

Confirm status of ‘Complete: TRUE’

	$ rhpctl query image -image GI183_180717

## Example output

	[grid@fpp-server-n01 bin]$ rhpctl import image -image GI183_180717 -path /u01/app/18.3.0.0/grid -imagetype ORACLEGISOFTWARE
	
	fpp-server-n01: Audit ID: 21
	fpp-server-n01: Creating a new ACFS file system for image "GI183_180717" ...
	fpp-server-n01: Copying files...
	fpp-server-n01: Copying home contents...
	fpp-server-n01: Changing the home ownership to user grid...
	fpp-server-n01: Changing the home ownership to user grid...

Query the image with rhpctl to confirm that *'Complete:'* shows as 'TRUE'.
	
	[grid@fpp-server-n01 bin]$ rhpctl query image -image GI183_180717
	
	fpp-server-n04: Audit ID: 812
	Image name: GI183_180717
	Owner: grid@ct03vm07f-006
	Site: ct03vm07f-006
	Access control: USER:grid@ct03vm07f-006
	Access control: ROLE:OTHER
	Access control: ROLE:GH_IMG_PUBLISH
	Access control: ROLE:GH_IMG_ADMIN
	Access control: ROLE:GH_IMG_VISIBILITY
	Parent Image:
	Software home path: /rhp/images/images/iGI183_180717157464/.ACFS/snaps/iGI183_180717/swhome
	Image state: PUBLISHED
	Image size: 10472 Megabytes
	Image Type: ORACLEGISOFTWARE
	Image Version: 18.0.0.0.0:18.3.0.0.0
	Groups configured in the image: OSDBA=asmdba,OSASM=asmadmin,OSBACKUP=asmadmin,OSDG=asmadmin,OSKM=asmadmin,OSRAC=asmadmin
	Image platform: Linux_AMD64
	Interim patches installed: 28256701,28090564,28090557,28090553,28090523
	Contains a non-rolling patch: FALSE
	Complete: TRUE



[//]: # (Author: David LaPoint david.lapoint@oracle.com)


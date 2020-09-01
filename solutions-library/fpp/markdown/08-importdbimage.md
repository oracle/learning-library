# How to Create (Import) a RDBMS Gold Image

[//]: # (Author:David LaPoint david.lapoint@oracle.com)

[Return to FPP Introduction](IntroPage.md)

## Requirements:

1.	An already installed RDBMS home of desired configuration

## Overview:

1.	Import new image
2.	Query new image

### Step 1 – Import Your Image

	$ rhpctl import image -image DB11204_190115 -client fpp-client2-cluster -path /u01/app/oracle/product/11.2.0.4/dbhome_1 -imagetype ORACLEDBSOFTWARE

Please note here the usage of `-client`.  Remote operations against FPP clients generally use the same command as against the FPP server.  Only `-client` is needed to denote the remote target.  Please also note the image type is different from what is used for the GI import image command.

### Step 2 – Query Your Image

Confirm status of ‘*Complete:* TRUE’

	$ rhpctl query image -image DB11204_190115

## Example output:

Import the remote RDBMS home to make a new RDBMS image.

	$ rhpctl import image -image DB11204_190115 -client fpp-client2-cluster -path /u01/app/oracle/product/11.2.0.4/dbhome_1 -imagetype ORACLEDBSOFTWARE
	fpp-server-n01: Adding storage for image ...
	fpp-server-n01: Creating a new ACFS file system for image "DB11204_190115" ...
	fpp-client2-n01: Copying files...
	fpp-client2-n01: Copying home contents...
	fpp-server-n01: Changing the home ownership to user exagrid...
	fpp-server-n01: Audit ID: 52

Check the results with `query image`.

	$ rhpctl query image -image DB11204_190115
	fpp-server-n01: Audit ID: 53
	Image name: DB11204_190115
	Owner: exagrid@fpp-server-cluster
	Site: fpp-server-cluster
	Access control: USER:exagrid@fpp-server-cluster
	Access control: ROLE:OTHER
	Access control: ROLE:GH_IMG_PUBLISH
	Access control: ROLE:GH_IMG_ADMIN
	Access control: ROLE:GH_IMG_VISIBILITY
	Parent Image:
	Software home path: /rhp/images/iDB11204_190115518182/.ACFS/snaps/iDB11204_190115/swhome
	Image state: PUBLISHED
	Image size: 6527 Megabytes
	Image Type: ORACLEDBSOFTWARE
	Image Version: 11.2.0.4.0
	Groups configured in the image: OSDBA=dba,OSOPER=racoper
	Image platform: Linux_AMD64
	Interim patches installed: 28732021,21139548,19332396,22674697,22502549
	Contains a non-rolling patch: TRUE
	Complete: TRUE


[//]: # (Author: David LaPoint david.lapoint@oracle.com)


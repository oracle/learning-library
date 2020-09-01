# How to Add an FPP Client

[//]: # (Author:David LaPoint david.lapoint@oracle.com)

[Return to FPP Introduction](IntroPage.md)

## Requirements:
1. Root access for a few commands
2. A target cluster (or single node) running 12.2 GI or later.

##Overview:
1. Confirm new client cluster’s name
1. Export FPP client datafile from FPP server and transfer to new FPP client
1. Create FPP client using datafile on FPP client 
	+ *Remove local standalone FPP server if required* (`srvctl delete rhpserver -f`)
1. Start new client
1. Check client status
1. Query new client

###Step 1 – Confirm client cluster name
	$ olsnodes -c

###Step 2 – Export FPP client datafile 
This requires that the client’s actual cluster name be used, the value shown in the last command, case sensitive.

	$ rhpctl add client -client fpp-client3-cluster -toclientdata /tmp

###Step 3 – Create FPP client using client datafile
**As root:**

	# srvctl add rhpclient -clientdata /tmp/fpp-client3-cluster.xml

###Step 4 – Start client
	$ srvctl start rhpclient

###Step 5 – Check new FPP client status
	$ srvctl status rhpclient

###Step 6 – Check new FPP client status
	$ rhpctl query client -client fpp-client3-cluster

##Example output

Confirm the name of the new FPP client cluster.

	[grid@fpp-client3-n01 ~]$ olsnodes -c
	fpp-client3-cluster

Create the client creditials file on the FPP server.

	[grid@fppserver ~]$ rhpctl add client -client fpp-client3-cluster -toclientdata /tmp
	fpp-server-n04: Audit ID: 833
	fpp-server-n04: Creating client data ...
	fpp-server-n04: Client data created for client "fpp-client3-cluster".
	
	
	[grid@fppserver ~]$ ll /tmp/fpp*
	-rw-r--r-- 1 grid oinstall 3667 Aug  8 21:23 /tmp/fpp-client3-cluster.xml

After transferring the file to the target client cluster, use srvctl as root to add the client.
	
	[root@fpp-client3-n01 ~]# srvctl add rhpclient -clientdata /tmp/fpp-client3-cluster.xml
	
Check the status of rhpclient and start it if needed.
	
	[root@fpp-client3-n01 ~]# srvctl status rhpclient
	Rapid Home Provisioning Client is enabled
	Rapid Home Provisioning Client is running on node fpp-client3-n01

And back on the FPP server, query the client to confirm status.

	[grid@fppserver ~]$ rhpctl query client -client fpp-client3-cluster
	fpp-server-n04: Audit ID: 834
	Site: fpp-client3-cluster
	Rapid Home Provisioning Client Version: 18.0.0.0.0
	Enabled: true
	Host from which RHPC last registered: fpp-client3-n01.yourcorp.com
	Port number last registered by RHPC: 23795
	RHP Enabled: true
	Standalone: false
	Managed: true
	OSConfig Enabled: false



[//]: # (Author: David LaPoint david.lapoint@oracle.com)


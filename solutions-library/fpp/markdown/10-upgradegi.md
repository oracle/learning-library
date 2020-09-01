# How to Upgrade GI (upgrade gihome)

[//]: # (Author: David LaPoint david.lapoint@oracle.com)

[Return to FPP Introduction](IntroPage.md)

## Requirements:

1.	An already installed GI workingcopy of the desired configuration

## Overview:

1.	Test GI Upgrade with rhpctl -eval
2.	Move from old GI home to new GI workingcopy
3.	Validate upgrade

### Step 1 – Evaluate GI Move
	[exagrid@fpp-server-n04 ~]$ rhpctl upgrade gihome -sourcehome /opt/oracrs/gridsw/grid1860.190416 -destwc GI195_191015_WC_fpps -batches "(fpp-server-n01),(fpp-server-n02,fpp-server-n03),(fpp-server-n04)" -eval

Please note both the use of `-eval` to test or evaluate the GI home upgrade and how similar the upgrade syntax is to the GI patching (move).  The difference is in the verb `–upgrade` vs `-move`.  Most RHPCTL commands can be tested or evaluated by appending `-eval` to the command expected to be used.  

Another note is the use of `-sourcehome` in this case.  `-soucehome` is used when moving from a what is termed an “unmanagged” home, in other words a non-FPP workingcopy home.  With a managed home or workingcopy, `-sourcewc` would be used.  

This version of the command also demonstrates the ability of RHPCTL to manage the node order of the upgrade with the `-batches` option.

### Step 2 – Move GI to New Version Release Home / Workingcopy

	[exagrid@fpp-server-n04 ~]$ rhpctl upgrade gihome -sourcehome /opt/oracrs/gridsw/grid1860.190416 -destwc GI195_191015_WC_fpps -batches "(fpp-server-n01),(fpp-server-n02,fpp-server-n03),(fpp-server-n04)" -ignoreprereq 

Here it is important to note the use of an additional parameter `-ignoreprereq`.  Here it is used to demonstrate those use cases when some cluster verification prerequisite may need to be overridden.  During the `-eval` phase FPP executes both its own set of readiness checks and also the cluster verification utility (CVU) checks.  In some cases, it may discover prerequisites which are not met, but may upon judgement be overridden.  

### Step 3 – Validate GI Move

	rhpctl query workingcopy -workingcopy GI195_191015_WC_fpps 

Query the destination workingcopy to confirm that the move is complete and the workingcopy is no longer an inactive GI home.  Confirm *“Software only:* false”. Incomplete moves or inactive GI workingcopies will show the workingcopy as *“Software only:* true”.

## Example output:

For brevity, the output from the `-eval` executions are omitted. 

	[exagrid@fpp-server-n04 ~]$ rhpctl upgrade gihome -sourcehome /opt/oracrs/gridsw/grid1860.190416 -destwc GI195_191015_WC_fpps -batches "(fpp-server-n01),(fpp-server-n02,fpp-server-n03),(fpp-server-n04)" -eval 

	[exagrid@fpp-server-n04 ~]$ rhpctl upgrade gihome -sourcehome /opt/oracrs/gridsw/grid1860.190416 -destwc GI195_191015_WC_fpps -batches "(fpp-server-n01),(fpp-server-n02,fpp-server-n03),(fpp-server-n04)" -ignoreprereq -eval

Please note that with the use of the `-batches` option, after each batch completes FPP will stop and wait for `-continue` to be used to move to the next batch.  In this case three batches are used for four nodes – N1, N2&N3, and finally N4.  Any number of batches up to the number of nodes can be used.

	[exagrid@fpp-server-n04 ~]$ rhpctl upgrade gihome -sourcehome /opt/oracrs/gridsw/grid1860.190416 -destwc GI195_191015_WC_fpps -batches "(fpp-server-n01),(fpp-server-n02,fpp-server-n03),(fpp-server-n04)" -ignoreprereq
	fpp-server-n04: Audit ID: 51
	fpp-server-n04: verifying versions of Oracle homes ...
	fpp-server-n04: verifying owners of Oracle homes ...
	fpp-server-n04: verifying groups of Oracle homes ...
	fpp-server-n04: starting to upgrade the Oracle Grid Infrastructure home from home location "/opt/oracrs/gridsw/grid1860.190416" to "/opt/oracrs/gridsw/grid195.191015" on server cluster "fpp-server-cluster"
	fpp-server-n04: upgrading nodes: "[fpp-server-n01]".
	fpp-server-n04: Executing configuration script on nodes [fpp-server-n01]
	fpp-server-n04: Successfully executed configuration script on nodes [fpp-server-n01]
	fpp-server-n04: Executing root script on nodes [fpp-server-n01].
	Check /opt/oracrs/gridsw/grid195.191015/install/root_fpp-server-n01.yourcorp.com_2020-04-30_12-17-15-975518870.log for the output of root script
	fpp-server-n04: Successfully executed root script on nodes [fpp-server-n01].
	fpp-server-n04: Continue by running 'rhpctl upgrade gihome -destwc <workingcopy_name> -continue [-root | -sudouser <sudo_username> -sudopath <path_to_sudo_binary>]'.

Note here when the batch completes, it will give you the command you need to run in order to continue with the next batch.  The next section will have the continue. 

	[exagrid@fpp-server-n04 ~]$ rhpctl upgrade gihome -destwc GI195_191015_WC_fpps -continue
	fpp-server-n04: Audit ID: 52
	fpp-server-n04: upgrading nodes: "[fpp-server-n02, fpp-server-n03]".
	fpp-server-n04: Executing root script on nodes [fpp-server-n02, fpp-server-n03].
	Check /opt/oracrs/gridsw/grid195.191015/install/root_fpp-server-n03.yourcorp.com_2020-04-30_21-48-00-789601762.log for the output of root script
	Check /opt/oracrs/gridsw/grid195.191015/install/root_fpp-server-n02.yourcorp.com_2020-04-30_21-48-00-767486533.log for the output of root script
	fpp-server-n04: Successfully executed root script on nodes [fpp-server-n02, fpp-server-n03].
	fpp-server-n04: Continue by running 'rhpctl upgrade gihome -destwc <workingcopy_name> -continue [-root | -sudouser <sudo_username> -sudopath <path_to_sudo_binary>]'.

And now the final -continue and completion of the upgrade.  This shows how you can direct FPP to control the order of the nodes to be patched and if needed, give opportunities for a pause between batches. 

	[exagrid@fpp-server-n04 ~]$ rhpctl upgrade gihome -destwc GI195_191015_WC_fpps -continue
	fpp-server-n04: Audit ID: 53
	fpp-server-n04: upgrading nodes: "[fpp-server-n04]".
	Check /opt/oracrs/gridsw/grid195.191015/install/root_fpp-server-n04.yourcorp.com_2020-04-30_21-49-26-818985851.log for the output of root script
	Launching Oracle Grid Infrastructure Setup Wizard...
	
	You can find the logs of this session at:
	/opt/orainv/inv/logs/GridSetupActions2020-04-30_10-01-52PM
	
	You can find the log of this install session at:
	 /opt/orainv/inv/logs/UpdateNodeList2020-04-30_10-01-52PM.log
	You can find the log of this install session at:
	 /opt/orainv/inv/logs/UpdateNodeList2020-04-30_10-01-52PM.log
	Successfully Configured Software.
	fpp-server-n01: upgrading nodes: "[fpp-server-n01]".
	fpp-server-n01: Completed the 'upgrade gihome' operation on cluster fpp-server-cluster.

Confirm status of the new GI home/workingcopy and confirm that it is an 'active' GI home by reviewing *Software only:* is 'FALSE'.  New homes, incomplete or unvalidated moves to the new home will not change the active status of the new home and thus *Software only:* will remain 'TRUE'

	[exagrid@fpp-server-n01 ~]$ rhpctl query workingcopy -workingcopy GI195_191015_WC_fppc4
	fpp-server-n01: Audit ID: 54
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
	Software only: false
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


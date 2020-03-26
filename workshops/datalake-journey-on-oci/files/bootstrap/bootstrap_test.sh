Running bootstrap for Big Data User Journeys
Command being run: /u01/app/oracle/tools/bdce/bdcsce/impl-20/vm-scripts/bdcsce_bootstrap.sh
This is being run automatically.
setting up sudoers for zeppelin
last 10 lines of /etc/sudoers
## Allows members of the users group to shutdown this system
# %users  localhost=/sbin/shutdown -h now

## Read drop-in files from /etc/sudoers.d (the # here does not mean a comment)
#includedir /etc/sudoers.d
oracle ALL=(ALL) NOPASSWD: /usr/bin/nsenter -t 1 -n -m su - oracle *

opc    ALL=(ALL)   NOPASSWD: ALL
otools    ALL=(ALL)   NOPASSWD: ALL
zeppelin  ALL=(ALL)  NOPASSWD: ALL
running singleton Zeppelin section
Deleting 2 sample notebooks as we provide newer ones
OK
OK
importing lab notebooks
Archive:  Notes.zip
  inflating: Big Data User Journeys - START HERE.json  
  inflating: Extras_Cloudberry with Object Store.json  
  inflating: Extras_Connecting DV Desktop3.0 and Hive.json  
  inflating: Extras_Connecting DV Desktop3.0 and Spark.json  
  inflating: Extras_Connecting DV Desktop4.0 and BDCS-CE.json  
  inflating: Extras_Connecting to Ambari.json  
  inflating: Extras_Connecting via SSH.json  
  inflating: Extras_Downloading DV Desktop.json  
  inflating: Extras_Monitoring YARN.json  
  inflating: Extras_Notebook Backup Script.json  
  inflating: Extras_Understanding Python with BDC.json  
  inflating: Extras_Working with ADWC.json  
  inflating: Extras_Working with BDFS Alluxio.json  
  inflating: Extras_Working With OEHCS Connectors.json  
  inflating: Extras_Working with OLH and C2H.json  
  inflating: Extras_Working with Oracle Database.json  
  inflating: Journeys_DataSci_Tutorial 1 Setup for R SparkR RStudio.json  
  inflating: Journeys_DataSci_Tutorial 2 Using R with Zeppelin.json  
  inflating: Journeys_New Data Lake_Demo_Presidential Speeches with Spark and Spark SQL.json  
  inflating: Journeys_New Data Lake_Streaming_Advanced_Querying Temporary View via JDBC.json  
  inflating: Journeys_New Data Lake_Streaming_Demo_Citi Bike Live Map with Spark Streaming.json  
  inflating: Journeys_New Data Lake_Streaming_Tutorial 1 Working with OEHCS and Spark Streaming.json  
  inflating: Journeys_New Data Lake_Tutorial 1 Notebook Basics.json  
  inflating: Journeys_New Data Lake_Tutorial 2 Citi Bike New York Introduction and Setup.json  
  inflating: Journeys_New Data Lake_Tutorial 3 Working with Hive.json  
  inflating: Journeys_New Data Lake_Tutorial 4 Working with the Spark Interpreter.json  
  inflating: Journeys_New Data Lake_Tutorial 4b Adding more datasets.json  
  inflating: Journeys_New Data Lake_Tutorial 4c Getting Started with DV Desktop.json  
  inflating: Journeys_New Data Lake_Tutorial 5 Working with Spark and Maps.json  
  inflating: Journeys_SelfServeAnalytics_Exploring CitiBike Data with DVD.json  
/tmp/notebooks/Big Data User Journeys - START HERE.json
{"status":"CREATED","message":"","body":"2DN2KV13V"}/tmp/notebooks/Extras_Cloudberry with Object Store.json
{"status":"CREATED","message":"","body":"2DPZGQZFB"}/tmp/notebooks/Extras_Connecting DV Desktop3.0 and Hive.json
{"status":"CREATED","message":"","body":"2DQ7E667B"}/tmp/notebooks/Extras_Connecting DV Desktop3.0 and Spark.json
{"status":"CREATED","message":"","body":"2DMCHE37E"}/tmp/notebooks/Extras_Connecting DV Desktop4.0 and BDCS-CE.json
{"status":"CREATED","message":"","body":"2DKTK4DSC"}/tmp/notebooks/Extras_Connecting to Ambari.json
{"status":"CREATED","message":"","body":"2DP915359"}/tmp/notebooks/Extras_Connecting via SSH.json
{"status":"CREATED","message":"","body":"2DPT92B14"}/tmp/notebooks/Extras_Downloading DV Desktop.json
{"status":"CREATED","message":"","body":"2DN2J7MH9"}/tmp/notebooks/Extras_Monitoring YARN.json
{"status":"CREATED","message":"","body":"2DN3J724D"}/tmp/notebooks/Extras_Notebook Backup Script.json
{"status":"CREATED","message":"","body":"2DP3XJ75V"}/tmp/notebooks/Extras_Understanding Python with BDC.json
{"status":"CREATED","message":"","body":"2DPUJECXM"}/tmp/notebooks/Extras_Working with ADWC.json
{"status":"CREATED","message":"","body":"2DPNJYNKR"}/tmp/notebooks/Extras_Working with BDFS Alluxio.json
{"status":"CREATED","message":"","body":"2DNRREQKA"}/tmp/notebooks/Extras_Working With OEHCS Connectors.json
{"status":"CREATED","message":"","body":"2DKSB2UC9"}/tmp/notebooks/Extras_Working with OLH and C2H.json
{"status":"CREATED","message":"","body":"2DKN39GJ6"}/tmp/notebooks/Extras_Working with Oracle Database.json
{"status":"CREATED","message":"","body":"2DNADXDXY"}/tmp/notebooks/Journeys_DataSci_Tutorial 1 Setup for R SparkR RStudio.json
{"status":"CREATED","message":"","body":"2DMCMFHBW"}/tmp/notebooks/Journeys_DataSci_Tutorial 2 Using R with Zeppelin.json
{"status":"CREATED","message":"","body":"2DMNTRATX"}/tmp/notebooks/Journeys_New Data Lake_Demo_Presidential Speeches with Spark and Spark SQL.json
{"status":"CREATED","message":"","body":"2DPP794B5"}/tmp/notebooks/Journeys_New Data Lake_Streaming_Advanced_Querying Temporary View via JDBC.json
{"status":"CREATED","message":"","body":"2DQ81RDAP"}/tmp/notebooks/Journeys_New Data Lake_Streaming_Demo_Citi Bike Live Map with Spark Streaming.json
{"status":"CREATED","message":"","body":"2DKQFK1CN"}/tmp/notebooks/Journeys_New Data Lake_Streaming_Tutorial 1 Working with OEHCS and Spark Streaming.json
{"status":"CREATED","message":"","body":"2DPMDU5XR"}/tmp/notebooks/Journeys_New Data Lake_Tutorial 1 Notebook Basics.json
{"status":"CREATED","message":"","body":"2DMQK26QX"}/tmp/notebooks/Journeys_New Data Lake_Tutorial 2 Citi Bike New York Introduction and Setup.json
{"status":"CREATED","message":"","body":"2DMK6WT6Q"}/tmp/notebooks/Journeys_New Data Lake_Tutorial 3 Working with Hive.json
{"status":"CREATED","message":"","body":"2DND1NN5E"}/tmp/notebooks/Journeys_New Data Lake_Tutorial 4b Adding more datasets.json
{"status":"CREATED","message":"","body":"2DQ3EGSXC"}/tmp/notebooks/Journeys_New Data Lake_Tutorial 4c Getting Started with DV Desktop.json
{"status":"CREATED","message":"","body":"2DM6AKH6Y"}/tmp/notebooks/Journeys_New Data Lake_Tutorial 4 Working with the Spark Interpreter.json
{"status":"CREATED","message":"","body":"2DNHYTCXF"}/tmp/notebooks/Journeys_New Data Lake_Tutorial 5 Working with Spark and Maps.json
{"status":"CREATED","message":"","body":"2DMVDRYVX"}/tmp/notebooks/Journeys_SelfServeAnalytics_Exploring CitiBike Data with DVD.json
{"status":"CREATED","message":"","body":"2DPB3XHPP"}fixing sh interpreter timeout
OK
cleaning up yum metadata just in case
Loaded plugins: security, ulninfo
Cleaning repos: ksplice-uptrack ol6_UEKR4 ol6_UEK_latest ol6_addons
              : ol6_developer ol6_latest ol6_software_collections
              : public_ol6_openstack_10
0 metadata files removed
0 sqlite files removed
0 metadata files removed
installing mlocate
Loaded plugins: security, ulninfo
Setting up Install Process
Package mlocate-0.22.2-6.el6.x86_64 already installed and latest version
Nothing to do
done with bootstrap for Big Data User Journeys

# Lab - 9
 
In this step you will run script to create a uni-directional replication from *ATLANTA to SANFRAN deployments via pre- configured script.

On the desktop, right-click and select “Open Terminal”.

 

From the terminal screen change to the OGG181_WHKSHP/Lab9 directory and execute ./build_all_bi_di.sh. This will reset the database and create uni-directional replication as in Lab 900.

[oracle@OGG181DB183 ~]$ cd OGG181_WHKSHP/Lab9 [oracle@OGG181DB183 Lab9]$ ./build_all_bi_di.sh
 
NOTE : Please wait as this will take 5 mins. You should see the following message in the terminal :
 

STEP 2: Run the Swingbench transactions.
You can check to see if these processes are up and running. Open up a browser window in your client VM environment in Ravello or on your laptop using a browser (like Chrome or Firefox) and enter the following URL and port: http://localhost:16000  .

If you're using the browser on your laptop, change localhost to the Ravello URL or IP Address your instructor gave out at the beginning of the workshop same one you used for the VNC Session.
You should get a sign on page. Sign in using the username: "oggadmin" and password "Welcome1".
 

 

After logging in, find and open the Administration Server of the Source/Target deployments i.e. Atlanta & SANFRAN. Verify the extract(EXT1) and replicat(REP1) are running.

 
 

 

 

To test the replication environment, you will use Swingbench. Swingbench has already been installed in the Script directory and you will use the command line to execute the Swingbench workload.

From the Lab9 directory, run the following script:

[oracle@OGG181DB183 Lab9]$ cd ~/OGG181_WHKSHP/Lab9 [oracle@OGG181DB183 Lab9]$ ./start_swingbench.sh


For the final task we will view both Deployment’s Performance Metric Service to view transactions metrics within the Oracle GoldenGate  configuration.

Click on the link to the Performance Metric Service for the Atlanta deployment from the ServiceManager page, or connect directly via the browser to http://:16004, then click on the EXT1 Extract process, and view the details about it.
 

 

Explore the different tables for information on replication and database Statistics.

 
 

 

Now click on the link to the Performance Metric Service for the SANFRAN deployment from the ServiceManager page, or connect directly via the browser to http://:17004, then click on the IREP Replicat process, and view the details about it.

 
 

 

# How to get connected to the lab environment  

## Connecting from Windows ##

1.	Launch Putty and enter the IP address you were supplied with.
2.	Enter a memorable name for this connection into the Saved Sessions field
3.	In the left pane of the Putty Window, navigate to Connection -> SSH -> Auth. 
4.	Click on the Browse button in the right pane of the Putty window
5.	Locate the private key file (ppk) you downloaded to your workstation, select the filename and click Open
6.	In the left pane of the Putty Window, click Tunnels
7.	In the Source Port field, enter “5902”
8.	In the Destination field, enter “localhost:5902”
9.	Click the Add button
10.	In the left pane of the Putty window, scroll back to the top and click on Session.
11.	In the right pane of the Putty window, click the Save button.
12.	Now click the Open button at the bottom of the Putty window
13.	The first time you connect to a host you will receive a Putty Security Alert like this. This message is expected. Click Yes to add the remote hosts key fingerprint to the known-hosts file on your workstation
14.	When the Putty terminal window opens asking for a username, enter “opc” as the username and press Enter on your keyboard.
15.	Once you have the command prompt, you are connected to the lab machine.
16.	Transition to the Oracle user by entering the following command “sudo su – oracle”
17.	Open VNC Viewer
18.	Enter “localhost:5902” into the address bar and press Enter on your keyboard or click Connect
19.	Acknowledge the warning regarding Unencrypted connection
20.	Enter the VNC password “Oracle123”
21.	Click OK
22.	You should now be able to access the desktop of the Lab Workstation

## Connecting from Mac/Linux ##

1.	Download the id_rsa file for the workshop to your workstation
2.	Before you use the file you will need to change the permissions of the file. Execute the command “chmod 0600 <path-to-file>”
3.	Now execute the command “ssh -i <path-to-id-rsa-file> opc@<ip-of-test-host> -L 5902:localhost:5902”
4.	You will get prompted to accept the key fingerprint of the remote host, type “Yes” and press Enter
5.	Once you are connected, open VNC viewer and enter “localhost:5902” into the address bar and press Enter or click connect
6.	Enter the VNC password “Oracle123”
7.	You should now be connected to the Test host for the Workshop lab. Retrieve the ip address as instructed in the email and send it to the meeting host

# Deploying Redis in Master-Slave mode
  
## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Recommended Learning Assets](#recommended-learning-assets)

[Practice 1: Sign in to OCI Console and create VCN](#practice-1-sign-in-to-oci-console-and-create-vcn)

[Practice 2: Create ssh keys compute instances and install Redis](#practice-2-create-ssh-keys-compute-instances-and-install-redis)

[Practice 3: Configure Redis Master Slave mode](#practice-3-configure-redis-master-slave-mode)

[Practice 4: Configure Security Rules and verify deployment](#practice-4-configure-security-rules-and-verify-deployment)

[Practice 5: Security Best Practices](#practice-5-security-best-practices)

[Practice 6: Delete the resources](#practice-6-delete-the-resources)


## Overview

Redis (REmote DIctionary Server) is a popular open-source, in-memory data store that supports a wide array of data
structures in addition to simple key-value pairs. It is a key-value database where values can contain more complex
data types, such as strings, hashes, lists, sets, sorted sets, bitmaps, and hyperloglogs, with atomic operations
defined on those data types. Redis combines in-memory caching with built-in replication, persistence, sharding, and
the master-slave architecture of a traditional database. Given the rich features offered by Redis out of the box, a
wide variety of deployment options are available.
In this lab we will deploy Redis in Master-Slave mode (similar to below) though we will not deploy a NAT instance
(Bastion host).

![]( img/Redis_014.PNG)

## Pre-Requisites

- Oracle Cloud Infrastructure account credentials (User, Password, Tenant, and Compartment)  

## Recommended Learning Assets
1. OCI Training : https://cloud.oracle.com/en_US/iaas/training

2. Familiarity with OCI console: https://docs.us-phoenix-1.oraclecloud.com/Content/GSG/Concepts/console.htm

3. Overview of Networking: https://docs.us-phoenix-1.oraclecloud.com/Content/Network/Concepts/overview.htm

4. Familiarity with Compartment: https://docs.us-phoenix-1.oraclecloud.com/Content/GSG/Concepts/concepts.htm

5. Connecting to a compute instance: https://docs.us-phoenix-1.oraclecloud.com/Content/Compute/Tasks/accessinginstance.htm


## Practice-1: Sign in to OCI Console and create VCN


**Note:** OCI UI is being updated thus some screenshots in the instructions might be different than actual UI

**Before You Begin**

- We recommend using Chrome or Edge as the broswer. Also set your browser zoom to 80%

1. Sign in using your tenant name, user name and password.

2. Once signed in select the compartment assigned to you from drop down menu on left part of the screen

3. From the OCI Services menu,click **Virtual Cloud Network** under Networking and click **Create Virtual Cloud Network**

**NOTE:** Ensure the correct Compartment is selected under COMPARTMENT list

![]( img/RESERVEDIP_HOL001.PNG)
![]( img/RESERVEDIP_HOL002.PNG)

4. Fill out the dialog box:

- **Create in Compartment:** Has the correct compartment

- **Name:** Enter easy to re¬member name

- **Create Virtual Cloud Network Plus Related Resources:** Select this option.

- Click **Create Virtual Cloud Network**

- Click **Close**

![]( img/RESERVEDIP_HOL003.PNG)
![]( img/RESERVEDIP_HOL004.PNG)


              
## Practice 2: Create ssh keys compute instances and install Redis

1. Click the Apps icon in the toolbar and select  Git-Bash to open a terminal window.

![]( img/RESERVEDIP_HOL006.PNG)

2. Enter command 
```
ssh-keygen
```
**HINT:** You can swap between OCI window, 
git-bash sessions and any other application (Notepad, etc.) by clicking the Switch Window icon 

![]( img/RESERVEDIP_HOL007.PNG)

3. Press Enter When asked for ‘Enter File in which to save the key’, ‘Created Directory, ‘Enter passphrase’, and ‘Enter Passphrase again.

![]( img/RESERVEDIP_HOL008.PNG)

4. You should now have the Public and Private keys:

/C/Users/ PhotonUser/.ssh/id_rsa (Private Key)

/C/Users/PhotonUser/.ssh/id_rsa.pub (Public Key)

**NOTE:** id_rsa.pub will be used to create 
Compute instance and id_rsa to connect via SSH into compute instance.

**HINT:** Enter command 
```
cd /C/Users/PhotonUser/.ssh (No Spaces) 
```
and then 
```
ls 
```
to verify the two files exist. 

5. In git-bash Enter command  
```
cat /C/Users/PhotonUser/.ssh/id_rsa.pub
```
 , highlight the key and copy 

![]( img/RESERVEDIP_HOL009.PNG)

6. Click the apps icon, launch notepad and paste the key in Notepad (as backup)

![]( img/RESERVEDIP_HOL0010.PNG)

7. Switch to the OCI console. From OCI servies menu, Click **Instances** under **Compute** 

8. Click Create Instance. Fill out the dialog box:

- **Name:** Enter a name 

- **Availability Domain:** Select availability domain

- **Image Operating System:** For the image, we recommend using the Latest Oracle Linux available.

- **Choose Instance Type:** Select Virtual Machine

- **Choose Instance Shape:** Select VM shape

- **Configure Boot Volume:** Leave the default

- **Add SSH Keys:** Choose ‘Paste SSH Keys’ and paste the Public Key saved earlier.

- **Virtual Cloud Network Compartment:** Choose your compartment

- **Virtual Cloud Network:** Select the VCN you created in the previous section. 

- **Subnet Compartment:** Choose your compartment. 

- **Subnet:** Choose the first Subnet

9. Click **Create**

**NOTE:** If 'Service limit' error is displayed choose a different shape such as VM.Standard.E2.2 OR VM.Standard2.2 OR choose a different AD
![]( img/RESERVEDIP_HOL0011.PNG)

10. Once the Instance is running, note down both public and private IP address of the instance from instance detail page (by Clicking Instance name)

11. Wait for Instance to be in **Running** state. In git-bash Enter Command:
```
 cd /C/Users/PhotonUser/.ssh
```
12. Enter **ls** and verify id_rsa file exists

13. Enter command 
```
ssh –i id_rsa opc@<PUBLIC_IP_OF_COMPUTE_INSTANCE>
```
**NOTE:** User name is opc

**HINT:** If ‘Permission denied error’ is seen, ensure you are using ‘-i’ in the ssh command

14. Enter ‘Yes’ when prompted for security message

![]( img/RESERVEDIP_HOL0014.PNG)
 
15. Verify opc@<COMPUTE_INSTANCE_NAME> appears on the prompt

16. Repeat the steps to create second Compute Instance. This compute instance should be created in a different AD then the first instance. **Ensure to choose a different AD then the first compute instance**

**NOTE:** This instance will be the Slave node

17. Once the Instance is running, note down both public and private IP address of the instance from instance detail page (by Clicking Instance name)

**We now have a VCN and two compute instance (Master and Slave). Next we will ssh into these compute instance, install and configure Redis.**

18. Switch to git bash with ssh session into first compute intance and install Redis. Enter Command:
```
sudo yum install redis -y
```
Wait for installation to complete
![]( img/Redis_001.PNG)

19. Start Redis. Enter command:
```
sudo systemctl start redis.service
```
20. Enable Redis to start on reboot. Enter command:
```
sudo systemctl enable redis
```

21. Check status of redis server. Enter command:
```
sudo systemctl status redis.service
```
Verify service is active and is using loop back  interface (127.0.0.1) on port 6379

![]( img/Redis_002.PNG)

22. Test the set-up. Enter command:
```
redis-cli ping
```
Verify PONG is received as the response

23. Launch a second git-bash window and ssh into second compute instance (redis-slave) using steps above. Once logged in repeat the steps above to install and verify redis.

**We now have redis installed on two compute instances. Next we will configure the two instances in Master-Slave mode and verify the configuration**


## Practice 3: Configure Redis Master Slave mode

**In this section we will configure first compute instance as Master and second compute instance as Slave.Once configured we will verify it.**

1. Switch to git-bash window with ssh to first compute node (redis-master)

2. To secure the redis instance we will bind the service to the Private IP (saved earlier) of the compute instance. Edit the file /etc/redis.conf using vi or nano. Enter command:
```
sudo vi /etc/redis.conf
```
**NOTE:** You can use another editor like nano as well.

3. Search for string 'bind 127.0.0.1'. Replace 127.0.0.1 with the private ip of the compute instance (redis-master) saved earlier.
**NOTE:** Below example is showing 10.0.0.6 as the private IP
![]( img/Redis_003.PNG)
![]( img/Redis_004.PNG)

4. In redis.conf file search for string 'requirepass'. Un-comment the line and note down the password. 

**NOTE:** We will use this default password for this lab. In the last section where we cover additional security methods we will go over the process of how to change this password to a more complex and secure password
![]( img/Redis_005.PNG)

5. Save and exit out of the editor and restart redis service. Enter command:
```
sudo systemctl restart redis.service
```
6. Check status of redis server. Enter command:
```
sudo systemctl status redis.service
```
Verify service is active and is using Private IP of the compute instance on port 6379
![]( img/Redis_006.PNG)

7. Redis Master node has been configued. We will now configure Redis Slave node. Bring up the git-bash window with ssh session to second compute node(redis-slave).

8. Install and start redis service following above steps and verify Redis service started on loop back(127.0.0.1) interface. 

9. Edit /etc/redis.conf file as above. Change the bind address to the private IP of the second compute instance. Do not exit out of the file.

10. Search for string 'slaveof'. Un-comment the line and change the IP address to the private IP address of the master node(10.0.0.6 in this example). Keep the port number as 6379. Do not exit out of the file.
![]( img/Redis_007.PNG)

11. Search for string 'masterauth' and change the password noted down from master node config file (foobared in this example)
![]( img/Redis_008.PNG)

12. Save and exit out of the file. Restart Redis service and verify status to make sure Redis service is using the private IP of the second compute node
(redis-slave).

**We have installed and configued Redis in Master-Slave mode using two compute instance in different Availability domains. Next we will update security list rules to ensure the two instances can communicate with each other Ensure both your ssh sessions are open**


## Practice 4: Configure Security Rules and verify deployment

**Redis is listening on port 6379, thus we need to allow access to the Redis Master node from slave node by adding security list rule on the VCN. We will then need to set firewall rules on the redis instance itself to allow access from Redis slave node.**

1. Switch to OCI console window.
2. From OCI services menus Navigate to your VCN created earlier and click your VCN name, Click **Security List** and then **Default Security list for<YOUR_VCN_NAME>**

![]( img/Customer_Lab_001.PNG)

3. In Security list details page, Click **Edit All Rules** and Click **+Another Ingress Rule** under 
Allow Rules for Ingress and add below rule:
- Make sure STATELESS Flag in un-checked
- SOURCE TYPE: CIDR
- SOURCE CIDR: Specify Private IP network of the second compute instance (redis-slave).(In below example its 10.0.1.0/24)
- IP PROTOCOL: TCP
- SOURCE PORT RANGE: ALL
- DESTINATION PORT RANGE: 6379
![]( img/Redis_009.PNG)

4. Click **Save Security List Rules** at the bottom

5. Switch to git-bash window with ssh session to first compute (redis-master) and enter below command to set firewall rules:            
```
sudo firewall-cmd --permanent --new-zone=redis
```
```
sudo firewall-cmd --permanent --zone=redis --add-port=6379/tcp
```
```
sudo firewall-cmd --permanent --zone=redis --add-source=<redis_slave_private_IP>
```

**NOTE:** The IP here will be second compute node (redis-slave IP address)
```
sudo firewall-cmd --reload
```
6. Restart Redis service. Enter command:
```
sudo systemctl restart redis.service
```
![]( img/Redis_010.PNG)

7. Initiate redis cli mode on Redis Master node and verify Replication status. Enter Commands:
```
redis-cli -h <PRIVATE_IP_OF_REDIS_MASTER> -p 6379
```             
**NOTE:** This will start CLI mode. Provide below inputs

- **auth <Password_From_redis.conf>**
This will authenticate the user per the password in redis.conf file. In this lab this password is 'foobared'

- **info replication**
This will provide us replication information. This command will also confirm that this redis node is master and there is a slave instance.
![]( img/Redis_011.PNG)

8. If the slave information is not available, it could be due to keep alive timer expiration. Switch to git-bash window with ssh connection to second compute instance and restart redis service:
``` 
sudo systemctl restart redis.service
```

9. You can verify the second compute instance  
(redis-slave) in connected to the master node by first invoking the redi-cli and then by Entering command:
```
info replication
```
![]( img/Redis_012.PNG)

10. To exit out of cli prompt Enter command exit

**We have successfully configured Redis in Master-Slave mode on two compute nodes in different Availability domains. Next we will go over some of the security best practices**

**NOTE:** We will not be implementing this best practices in this lab.

## Practice 5: Security Best Practices

In this section we will review some of the security best practices recommendations.

**Recommendation #1.** Configure a NAT Instance. 
Create a VCN with two subnets to house a bastion 
server and Redis server. Ensure that the VCN CIDR 
is big enough to accommodate more subnets if you 
plan to expand your deployment in the future by
introducing Redis clustering and adding application 
servers or database servers.
Build the bastion server in a public subnet and the 
Redis server in a private subnet. By doing this, 
you're restricting the public access of the Redis 
instance and allowing access only via the bastion 
server The deployment will look similar to:

![]( img/Redis_013.PNG)

**Recommendation #2.** Using Strong Password. In 
this lab we used the default password (foobared) 
that was created in redis.conf file.
Use a tool like apg or pwgen to generate one. If 
you don't want to install an application just to 
generate a password then use below command on a 
linux system (change the string in "" to generate a 
new password every time. 
```
echo "OCI" | sha256sum
```
Replace the default password in redis.conf under 
requirepass. Restart redis services.

**Recommendation #3.** Restrict access to Redis 
Master node. In this lab when we configued the 
security list and firewall rules, we restricted 
access with a /24 subnet mast to Redis slave node's
subnet. This can be further restricted by using a 
/32 mask and specifting Redis Slave node's IP 
address

**These are some basic security recommendations. Next we will delete the resources created.**

## Practice 6: Delete the resources

1. Switch to  OCI console window

2. If your Compute instance is not displayed, From OCI services menu Click Instances under Compute

3. Locate first compute instance, Click Action icon and then **Terminat** 

![]( img/RESERVEDIP_HOL0016.PNG)

4. Make sure Permanently delete the attached Boot Volume is checked, Click Terminate Instance. Wait for instance to fully Terminate

![]( img/RESERVEDIP_HOL0017.PNG)

5. From OCI services menu Click **Virtual Cloud Networks** under Networking, list of all VCNs will 
appear.

6. Locate your VCN , Click Action icon and then **Terminate**. Click **Delete All** in the Confirmation window. Click **Close** once VCN is deleted

![]( img/RESERVEDIP_HOL0018.PNG)

7. From OCI services menu Click **Networking**, then **Public IPs**,locate the Reserved Public IP you created. Click Action icon and then **Terminate**

![]( img/RESERVEDIP_HOL0019.PNG)

**Congratulations! You have successfully completed the lab.**


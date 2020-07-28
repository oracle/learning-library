# Deploying Redis in Master-Slave mode

## Introduction

Redis (REmote DIctionary Server) is a popular open-source, in-memory data store that supports a wide array of data
structures in addition to simple key-value pairs. It is a key-value database where values can contain more complex
data types, such as strings, hashes, lists, sets, sorted sets, bitmaps, and hyperloglogs, with atomic operations
defined on those data types. Redis combines in-memory caching with built-in replication, persistence, sharding, and
the master-slave architecture of a traditional database. Given the rich features offered by Redis out of the box, a
wide variety of deployment options are available.
In this lab we will deploy Redis in Master-Slave mode (similar to below) though we will not deploy a NAT instance
(Bastion host).

**Some Key points:**

*We recommend using Chrome or Edge as the broswer. Also set your browser zoom to 80%.*

- All screen shots are examples ONLY. Screen shots can be enlarged by Clicking on them

- Login credentials are provided later in the guide (scroll down). Every User MUST keep these credentials handy.

- Do NOT use compartment name and other data from screen shots.Only use  data(including compartment name) provided in the content section of the lab

- Mac OS Users should use ctrl+C / ctrl+V to copy and paste inside the OCI Console

- Login credentials are provided later in the guide (scroll down). Every User MUST keep these credentials handy.

    **Cloud Tenant Name**

    **User Name**

    **Password**

    **Compartment Name (Provided Later)**

    **Note:** OCI UI is being updated thus some screenshots in the instructions might be different than actual UI.

### Pre-Requisites

1. Oracle Cloud Infrastructure account credentials (User, Password, Tenant, and Compartment).
   
2. [OCI Training](https://cloud.oracle.com/en_US/iaas/training)

3. [Familiarity with OCI console](https://docs.us-phoenix-1.oraclecloud.com/Content/GSG/Concepts/console.htm)

4. [Overview of Networking](https://docs.us-phoenix-1.oraclecloud.com/Content/Network/Concepts/overview.htm)

5. [Familiarity with Compartment](https://docs.us-phoenix-1.oraclecloud.com/Content/GSG/Concepts/concepts.htm)

6. [Connecting to a compute instance](https://docs.us-phoenix-1.oraclecloud.com/Content/Compute/Tasks/accessinginstance.htm)


## Step 1: Sign in to OCI Console and create VCN

* **Tenant Name:** {{Cloud Tenant}}
* **User Name:** {{User Name}}
* **Password:** {{Password}}
* **Compartment:**{{Compartment}}

1. Sign in using your tenant name, user name and password. Use the login option under **Oracle Cloud Infrastructure**.
    ![](./../grafana/images/Grafana_015.PNG " ")

2. From the OCI Services menu,Click **Virtual Cloud Networks** under Networking. Select the compartment assigned to you from drop down menu on left part of the screen under Networking and Click **Start VCN Wizard**.

    **NOTE:** Ensure the correct Compartment is selected under COMPARTMENT list

3. Click **VCN with Internet Connectivity** and click **Start Workflow**.

4. Fill out the dialog box:

      - **VCN NAME**: Provide a name
      - **COMPARTMENT**: Ensure your compartment is selected
      - **VCN CIDR BLOCK**: Provide a CIDR block (10.0.0.0/16)
      - **PUBLIC SUBNET CIDR BLOCK**: Provide a CIDR block (10.0.1.0/24)
      - **PRIVATE SUBNET CIDR BLOCK**: Provide a CIDR block (10.0.2.0/24)
      - Click **Next**

5. Verify all the information and  Click **Create**.

6. This will create a VCN with followig components.

    *VCN, Public subnet, Private subnet, Internet gateway (IG), NAT gateway (NAT), Service gateway (SG)*

7. Click **View Virtual Cloud Network** to display your VCN details.
                    
## Step 2: Create ssh keys, two compute instances and install Redis

1. Click the Apps icon in the toolbar and select  Git-Bash to open a terminal window.

     ![](./../oci-quick-start/images/RESERVEDIP_HOL006.PNG " ")

2. Enter command 
   
    ```
    <copy>
    ssh-keygen
    </copy>
    ```
    **HINT:** You can swap between OCI window, git-bash sessions and any other application (Notepad, etc.) by Clicking the Switch Window icon. 

    ![](./../oci-quick-start/images/RESERVEDIP_HOL007.PNG " ")

3. Press Enter When asked for 'Enter File in which to save the key', 'Created Directory, 'Enter passphrase', and 'Enter Passphrase again.
    ![](./../oci-quick-start/images/RESERVEDIP_HOL008.PNG " ")

4. You should now have the Public and Private keys:

    /C/Users/ PhotonUser/.ssh/id\_rsa (Private Key)

    /C/Users/PhotonUser/.ssh/id\_rsa.pub (Public Key)

    **NOTE:** id\_rsa.pub will be used to create 
    Compute instance and id\_rsa to connect via SSH into compute instance.

    **HINT:** Enter command 
    ```
    <copy>
    cd /C/Users/PhotonUser/.ssh (No Spaces) 
    </copy>
    ```
    and then 
    ```
    <copy>
    ls 
    </copy>
    ```
    to verify the two files exist. 

5. In git-bash Enter command  
    ```
    <copy>
    cat /C/Users/PhotonUser/.ssh/id_rsa.pub
    </copy>
    ```
    , highlight the key and copy 

    ![](./../oci-quick-start/images/RESERVEDIP_HOL009.PNG " ")

6. Click the apps icon, launch notepad and paste the key in Notepad (as backup).
    ![](./../oci-quick-start/images/RESERVEDIP_HOL0010.PNG " ")


7. Switch to the OCI console. From OCI servies menu, Click **Instances** under **Compute**. 

8. Click Create Instance. Fill out the dialog box:

      - **Name your instance**: Enter a name 
      - **Choose an operating system or image source**: For the image, we recommend using the Latest Oracle Linux available.
      - **Availability Domain**: Select availability domain
      - **Instance Type**: Select Virtual Machine 
      - **Instance Shape**: Select VM shape 

      **Under Configure Networking**
      - **Virtual cloud network compartment**: Select your compartment
      - **Virtual cloud network**: Choose the VCN 
      - **Subnet Compartment:** Choose your compartment. 
      - **Subnet:** Choose the Public Subnet under **Public Subnets** 
      - **Use network security groups to control traffic** : Leave un-checked
      - **Assign a public IP address**: Check this option

    ![](./../oci-quick-start/images/RESERVEDIP_HOL0011.PNG " ")

      - **Boot Volume:** Leave the default
      - **Add SSH Keys:** Choose 'Paste SSH Keys' and paste the Public Key saved earlier.

9. Click **Create**.

    **NOTE:** If 'Service limit' error is displayed choose a different shape from VM.Standard2.1, VM.Standard.E2.1, VM.Standard1.1, VM.Standard.B1.1  OR choose a different AD

    ![](./../oci-quick-start/images/RESERVEDIP_HOL0011.PNG " ")

10. Repeat the steps to create second Compute Instance. This compute instance should be created in a different AD then the first instance. **Ensure to choose a different AD then the first compute instance**.

    **NOTE:** This instance will be the Slave node.

11. Wait for Instances to be in **Running** state. Note down both Public and Private IP addresse of both compute instance.
Next we will ssh into the **first compute instance**. In git-bash Enter Command:

    ```
    <copy>
    cd /C/Users/PhotonUser/.ssh
    </copy>
    ```
12. Enter **ls** and verify id\_rsa file exists.

13. Enter command: (**Ensure to use Public IP of the first compute instnace)
    ```
    <copy>
    bash
    ssh -i id_rsa opc@PUBLIC_IP_OF_COMPUTE
    </copy>
    ```
    **HINT:** If 'Permission denied error' is seen, ensure you are using '-i' in the ssh command. You MUST type the command, do NOT copy and paste ssh command.

14. Enter 'Yes' when prompted for security message.
    ![](./../oci-quick-start/images/RESERVEDIP_HOL0014.PNG " ")
 
15. Verify opc@`<COMPUTE_INSTANCE_NAME>` appears on the prompt.

    **We now have a VCN and two compute instance (Master and Slave). Next we will  install and configure Redis.**

16. In ssh session to first compute instance, Enter Command:

    ```
    <copy>
    sudo yum install redis -y
    </copy>
    ```
    Wait for installation to complete.

17. Start Redis. Enter command:
    
    ```
    <copy>
    sudo systemctl start redis.service
    </copy>
    ```
18. Enable Redis to start on reboot. Enter command:

    ```
    <copy>
    sudo systemctl enable redis
    </copy>
    ```

19. Check status of redis server. Enter command:

    ```
    <copy>
    sudo systemctl status redis.service
    </copy>
    ```
    Verify service is active and is using loop back  interface (127.0.0.1) on port 6379.

    ![](./../deploy-redis/images/Redis_002.PNG " ")

20. Test the set-up. Enter command:
   
    ```
    <copy>
    redis-cli ping
    </copy>
    ```
    Verify PONG is received as the response.

21. Launch a second git-bash window and ssh into second compute instance (redis-slave). Once logged in repeat the steps  to install and verify redis.

**We now have redis installed on two compute instances. Next we will configure the two instances in Master-Slave mode and verify the configuration**

## Step 3: Configure Redis Master Slave mode

In this section we will configure first compute instance as Master and second compute instance as Slave.Once configured we will verify it.

1. Switch to git-bash window with ssh to first compute node (redis-master).

2. To secure the redis instance we will bind the service to the Private IP (saved earlier) of the compute instance. Edit the file /etc/redis.conf using vi or nano. Enter command:
  
    ```
    <copy>
    sudo vi /etc/redis.conf
    </copy>
    ```
    **NOTE:** You can use another editor like nano as well.

3. Search for string 'bind 127.0.0.1'. Replace 127.0.0.1 with the private ip of the compute instance (redis-master) saved earlier.
    
    **NOTE:** Below example is showing 10.0.0.6 as the private IP.

    ![](./../deploy-redis/images/Redis_003.PNG " ")
    ![](./../deploy-redis/images/Redis_004.PNG " ")

4. In redis.conf file search for string 'requirepass'. Un-comment the line and note down the password. 

    **NOTE:** We will use this default password for this lab. In the last section where we cover additional security methods we will go over the process of how to change this password to a more complex and secure password

    ![](./../deploy-redis/images/Redis_005.PNG " ")

5. Save and exit out of the editor and restart redis service. Enter command:
    
    ```
    <copy>
    sudo systemctl restart redis.service
    </copy>
    ```
6. Check status of redis server. Enter command:
   
    ```
    <copy>
    sudo systemctl status redis.service
    </copy>
    ```
    Verify service is active and is using Private IP of the compute instance on port 6379.
    ![](./../deploy-redis/images/Redis_006.PNG " ")

7. Redis Master node has been configued. We will now configure Redis Slave node. Bring up the git-bash window with ssh session to second compute node(redis-slave).
 
8. Edit /etc/redis.conf file as above. Change the bind address to the private IP of the second compute instance. Do not exit out of the file.

9. Search for string 'slaveof'. Un-comment the line and change the IP address to the private IP address of the master node(10.0.0.6 in this example). Keep the port number as 6379. Do not exit out of the file.
    ![](./../deploy-redis/images/Redis_007.PNG " ")

10. Search for string 'masterauth' and change the password noted down from master node config file (foobared in this example) and uuncomment the line by removing #.
    ![](./../deploy-redis/images/Redis_008.PNG " ")

11. Save and exit out of the file. Restart Redis service and verify status to make sure Redis service is using the private IP of the second compute node
(redis-slave).

**We have installed and configued Redis in Master-Slave mode using two compute instance in different Availability domains. Next we will update security list rules to ensure the two instances can communicate with each other Ensure both your ssh sessions are open**


## Step 4: Configure Security Rules and verify deployment

Redis is listening on port 6379, thus we need to allow access to the Redis Master node from slave node by adding security list rule on the VCN. We will then need to set firewall rules on the redis instance itself to allow access from Redis slave node.

1. Switch to OCI console window.

2. From OCI services menus Navigate to your VCN created earlier and Click your VCN name, Click **Security List** and then **Default Security list for`<YOUR_VCN_NAME>`.**
    ![](./../deploy-redis/images/Customer_Lab_001.PNG " ")

3. In Security list details page, Click **Add Ingress Rule** and enter the following ingress rule; Ensure to leave STATELESS flag un-checked.

    - Source Type: CIDR 
    - Source CIDR: Specify Private IP network of the second compute instance (redis-slave).(In below example its 10.0.1.0/24)
    - IP Protocol: Select TCP.
    - Source Port Range: All.
    - Destination Port Range: 6379

4. Click **Add Ingress Rule**. 

5. Switch to git-bash window with ssh session to first compute (redis-master) and enter below command to set firewall rules:            
   
    ```
    <copy>
    sudo firewall-cmd --permanent --new-zone=redis
    </copy>
    ```

    ```
    <copy>
    sudo firewall-cmd --permanent --zone=redis --add-port=6379/tcp
    </copy>
    ```

    ```
    <copy>
    sudo firewall-cmd --permanent --zone=redis --add-source=<redis_slave_private_IP>
    </copy>
    ```

    **NOTE:** The IP here will be second compute node (redis-slave IP address)

    ```
    <copy>
    sudo firewall-cmd --reload
    </copy>
    ```
6. Restart Redis service. Enter command:

    ```
    <copy>
    sudo systemctl restart redis.service
    </copy>
    ```

    ![](./../deploy-redis/images/Redis_010.PNG " ")

7. Initiate redis cli mode on Redis Master node and verify Replication status. Enter Commands:

    ```
    <copy>
    redis-cli -h <PRIVATE_IP_OF_REDIS_MASTER> -p 6379
    </copy>
    ```
                 
    **NOTE:** This will start CLI mode. Provide below inputs.

    - **auth `<Password_From_redis.conf>`**
    This will authenticate the user per the password in redis.conf file. In this lab this password is 'foobared'

    - **info replication**
    This will provide us replication information. This command will also confirm that this redis node is master and there is a slave instance.

    ![](./../deploy-redis/images/Redis_011.PNG " ")

8. If the slave information is not available, it could be due to keep alive timer expiration. Switch to git-bash window with ssh connection to second compute instance and restart redis service:

    ``` 
    <copy>
    sudo systemctl restart redis.service
    </copy>
    ```

9. You can verify the second compute instance  
(redis-slave) in connected to the master node by first invoking the redi-cli and then by Entering command:

    ```
    <copy>
    info replication
    </copy>
    ```

    ![](./../deploy-redis/images/Redis_012.PNG " ")

10. To exit out of cli prompt Enter command exit.

**We have successfully configured Redis in Master-Slave mode on two compute nodes in different Availability domains. Next we will go over some of the security best practices**

**NOTE:** We will not be implementing this best practices in this lab.

## Step 5: Security Best Practices

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

![](./../deploy-redis/images/Redis_013.PNG " ")

**Recommendation #2.** Using Strong Password. In 
this lab we used the default password (foobared) 
that was created in redis.conf file.
Use a tool like apg or pwgen to generate one. If 
you don't want to install an application just to 
generate a password then use below command on a 
linux system (change the string in "" to generate a 
new password every time. 

```
<copy>
echo "OCI" | sha256sum
</copy>
```

Replace the default password in redis.conf under 
requirepass. Restart redis services.

**Recommendation #3.** Restrict access to Redis 
Master node. In this lab when we configued the 
security list and firewall rules, we restricted 
access with a /24 subnet mast to Redis slave node's
subnet. This can be further restricted by using a 
/32 mask and specifting Redis Slave node's IP 
address.

**These are some basic security recommendations. Next we will delete the resources created.**

## Step 6: Delete the resources

1. Switch to  OCI console window.

2. If your Compute instance is not displayed, From OCI services menu Click Instances under Compute.

3. Locate first compute instance, Click Action icon and then **Terminat**.

    ![](./../oci-quick-start/images/RESERVEDIP_HOL0016.PNG " ")

4. Make sure Permanently delete the attached Boot Volume is checked, Click Terminate Instance. Wait for instance to fully Terminate.

    ![](./../oci-quick-start/images/RESERVEDIP_HOL0017.PNG " ")

5. Repeat the steps to delete second compute instance.

6. From OCI services menu Click **Virtual Cloud Networks** under Networking, list of all VCNs will appear.

7. Locate your VCN , Click Action icon and then **Terminate**. Click **Delete All** in the Confirmation window. Click **Close** once VCN is deleted.

    ![](./../oci-quick-start/images/RESERVEDIP_HOL0018.PNG " ")


## Acknowledgements
*Congratulations! You have successfully completed the lab.*

- **Author** - Flavio Pereira, Larry Beausoleil
- **Adapted by** -  Yaisah Granillo, Cloud Solution Engineer
- **Last Updated By/Date** - Yaisah Granillo, June 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section. 


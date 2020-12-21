# Create a Compute Service

## Introduction

Oracle Cloud Infrastructure Compute lets you provision and manage compute hosts, known as instances. You can launch instances as needed to meet your compute and application requirements. After you launch an instance, you can access it securely from your computer, restart it, attach and detach volumes, and terminate it when you're done with it. Any changes made to the instance's local drives are lost when you terminate it. Any saved changes to volumes attached to the instance are retained.

Be sure to review [Best Practices for Your Compute Instance](https://docs.cloud.oracle.com/iaas/Content/Compute/References/bestpracticescompute.htm) for important information about working with your Oracle Cloud Infrastructure Compute instance.

### Prerequisites

- Oracle Cloud Infrastructure account credentials (User, Password, and Tenant)
- To sign in to the Console, you need the following:
  - Tenant, User name and Password
  - Oracle Cloud Infrastructure supports the latest versions of Google Chrome, Firefox and Internet Explorer 11

## **STEP 1**: Creating <if type="freetier">a Web Server on </if>a Compute Instance

Oracle Cloud Infrastructure  offers both Bare Metal and Virtual Machine instances:

- **Bare Metal**  - A bare metal compute instance gives you dedicated physical server access for highest performance and strong isolation.
- **Virtual Machine**  - A Virtual Machine (VM) is an independent computing environment that runs on top of physical bare metal hardware. The virtualization makes it possible to run multiple VMs that are isolated from each other. VMs are ideal for running applications that do not require the performance and resources (CPU, memory, network bandwidth, storage) of an entire physical machine.

An Oracle Cloud Infrastructure VM compute instance runs on the same hardware as a Bare Metal instance, leveraging the same cloud-optimized hardware, firmware, software stack, and networking infrastructure.

1. Navigate to the **Compute** tab and select **Instances**.

<if type="livelabs">
2. Select the Compartment that you were assigned when the reservation was created.

  ![](images/create-compute-livelabs-1.png)
</if>

2. Then click **Create Instance**. We will launch a VM instance for this lab.

3. The Create Compute Instance wizard will launch.
    <if type="freetier">Enter *Web-Server* as the name of the server. Click on the *Show Shape, Networking, Storage Options* link to expand that area of the page.</if>
    <if type="livelabs">Enter your username + *-Instance* as the name of the server.</if>

    <if type="freetier">
    ![Create step 1](images/Create1.png " ")
    </if>
    <if type="livelabs">
    ![](images/create-compute-livelabs-2.png)
    </if>

<if type="livelabs">
4. Click *Change Shape* to choose a VM shape.

    ![](images/create-compute-livelabs-3.png)

5. Select *Intel Skylake*, then select **VM.Standard.2.1** as the shape, and click **Select Shape**.

    ![](images/create-compute-livelabs-4.png)</if>

3. In the Networks section, most of the defaults are perfect for our purposes. However, you will need to scroll down to the Configure Networking area of the page and select the *Assign a public IP address* option.

    <if type="freetier">
    ![Create step 2](images/Create2.png " ")</if>

    <if type="livelabs">
    ![](images/create-compute-livelabs-4b.png)</if>

    ***NOTE:*** *You need a public IP address so that you can SSH into the running instance later in this lab.*

4. Scroll down to the SSH area of the page. Choose SSH key that you created earlier in ***Generate SSH Keys*** Lab. Press the **Create** button to create your instance.

    ![](images/create-compute-livelabs-5.png)

    Launching an instance is simple and intuitive with few options to select. The provisioning of the compute instance will complete in less than a minute and the instance state will change from provisioning to running.

5. Once the instance state changes to Running, you can SSH to the Public IP address of the instance. The Public IP address is noted under *Instance Access*.

    <if type="freetier">
    ![Create step 3](images/Create3.png " ")</if>

    <if type="livelabs">
    ![](images/compute-livelabs-running/png)</if>

## **STEP 2**: Connect to the instance <if type="freetier">and install Apache HTTP Server</if>

1. To connect to the instance, use Cloud Shell and enter the following command:

    **Note:** For Oracle Linux VMs, the default username is **opc**

    ```
    <copy>ssh -i <private_ssh_key> opc@<public_ip_address></copy>
    ```

<if type="freetier">    
2. For this lab, we are going to install an Apache HTTP Webserver and try to connect to it over the public Internet. SSH into the Linux instance and run following commands:

    *Note: Apache HTTP Server is an open-source web server developed by the Apache Software Foundation. The Apache server hosts web content, and responds to requests for this content from web browsers such as Chrome or Firefox.*

    - Install Apache http

      ```
      <copy>sudo yum install httpd -y</copy>
      ```

    - Start the apache server and configure it to start after system reboots

      ```
      <copy>sudo apachectl start
      sudo systemctl enable httpd</copy>
      ```

    - Run a quick check on apache configurations

      ```
      <copy>sudo apachectl configtest</copy>
      ```

    - Create firewall rules to allow access to the ports on which the HTTP server listens.

      ```
      <copy>sudo firewall-cmd --permanent --zone=public --add-service=http
      sudo firewall-cmd --reload</copy>
      ```

    - Create an index file for your webserver

      ```
      <copy>sudo bash -c 'echo This is my Web-Server running on Oracle Cloud Infrastructure >> /var/www/html/index.html'</copy>
      ```

3. Open your browser and navigate to `http://Public-IPAddress` (the IP address of the Linux VM)

    **NOTE:** Your browser will not return anything because port 80 was not opened into the Security Lists

4. Using the menu, click on **Virtual Cloud Network** and then the VCN you created for this practice.

    ![Click on the VCN](images/vcn1.png " ")

5. Now click on **Security Lists** on the left navigation bar for the VCN.
    ![Click on Security Lists](images/vcn2.png " ")

6. Click on the **Default Security List**.

7. Here you need to open port 80. Click on **+ Another Ingress Rule** and add the following values as shown below:

    - **Source Type:** CIDR
    - **Source CIDR**: 0.0.0.0/0
    - **IP Protocol:** TCP
    - **Source Port Range:** All
    - **Destination Port Range:** 80
    - Click on **Add Ingress Rules** at the bottom.

    ![Add Ingress Rule](images/addIngress1.png " ")

8. Navigate to `http://<public_ip_address>` (the IP address of the Linux VM) in your browser. And now you should see the index page of the webserver we created above.

    ![Open you browser to the public IP address](images/image13.png " ")

## Troubleshooting

If you are unable to see the webserver on your browser, possible scenarios include:

- VCN Security Lists is blocking traffic, Check VCN Security List for ingress rule for port 80
- Firewall on the linux instance is blocking traffic

  - `# sudo firewall-cmd --zone=public --list-services` (this should show http service as part of the public zone)
  - `# sudo netstat -tulnp | grep httpd` (an httpd service should be listening on the port 80, if it’s a different port, open up that port on your VCN SL)

- Your company VPN is blocking traffic
</if>

*You have completed this lab, you may proceed to the next one.*

## Acknowledgements

- **Author** - Flavio Pereira, Larry Beausoleil
- **Adapted by** -  Tom McGinn, Database Product Management
- **Contributors** - Oracle LiveLabs QA Team (Kamryn Vinson, QA Intern, Arabella Yao, Product Manager Intern, DB Product Management)
- **Last Updated By/Date** - Tom McGinn, October 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/oracle-cloud-infrastructure-fundamentals). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
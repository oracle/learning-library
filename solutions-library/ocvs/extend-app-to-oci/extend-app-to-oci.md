# Extending your Application deployed in OCVS with OCI Services

## Introduction

In this lab, we will extend the application that we deployed in the VMWare SDDC in Lab 3 by integrating it with OCI services like the File Storage Service and Load Balancer.

## Objectives
1. Setup a load balancer in front of your oscommerce application.
2. Provide network file system capabilities by using the File Storage Service through a file storage mount point.
<!-- Enable REST end points for your application data using Oracle Integration Cloud -->

## Prerequsites
1. Required IAM permissions to create a File Storage Service instance, a Load Balancer and an Integration Cloud instance.

## Use Case 1: Set up Load Balancer in front of osCommerce Application

1. Create Load Balancer

    1. Navigate to the menu. Under **Networking**, select the **Load Balancer**. On the next page, hit the **Create Load Balancer** button.

        ![](./images/400_22.png " ")

        ![](./images/400_23.png " ")

    2. In the details page, provide a name to your Load Balancer and set the **Visibility Type** to Public. Let the **Maximum Total Bandwidth** be Small. The VCN should be the same, as our VMWare solution. The subnet should be a regional subnet in the same VCN. Once, all of this done, click on **Next**. 

        ![](./images/400_24.png " ")

    3. Now, let **Load Balancer policy** be set to the default, **Weighted Round Robin**. **Health check Policy** will also be the default. We will add the backend sets, later. So, simply click on **Next**.

        ![](./images/400_25.png " ")

        ![](./images/400_26.png " ")

    4. On the next screen, provide a name for your listener. The traffic will be **HTTP** and the port will be 80. Now, click on **Submit**.

        ![](./images/400_80.png " ")

    5. The load balancer should be up and running, shortly.
    
        ![](./images/400_30.png " ")

        ![](./images/400_79.png " ")

    6. We will now add our oscommerce application as the backend to this load balancer. Click on **Backend Sets** on the panel to the left.
     
        ![](./images/400_81.png " ")

    7. Select your backend set from the list.

        ![](./images/400_82.png " ")

    8. Click on **Add Backends**. 

        ![](./images/400_83.png " ")
    
    9. Navigate to your SDDC vSpehere and copy the IP address of the oscommerce VM that you created in the previous lab.
     
        ![](./images/400_85_1.png " ")
    
    10. Select IP addresses option and fill out the details as shown in the image below. Then, click on **Add**.

        ![](./images/400_85_2.png " ")

    11. Your oscommerce application has been added as a backend to the load balancer.
      
     ![](./images/400_86.png " ")

    13. We will now add a rule in the security list of the subnet with our load balancer to accept requests from the internet. Return to your VCN and select the public subnet that you created. 
        ![](./images/400_0.png " ")

        ![](./images/400_1.png " ")

        ![](./images/400_36_0.png " ")
    
    14. Click on the **Security List** for the public subnet and go to **Ingress Rules**. Hit the **Add Ingress Rules** button and allow TCP traffic from 0.0.0.0/0 on port 80.

        ![](./images/400_36.png " ")

    15. Next, we will configure the Network Security Groups to allow traffic from the load balancer.

    16. In the **Resources** panel on the left side of the screen, click on **Network Security Groups**.

        ![](./images/400_10.png " ")

    17. Choose the **NSG for NSX Edge Uplink**.

        ![](./images/400_32.png " ")

    18. Click on the **Add Rule** button. Once we add all the rules, your list would look similar to what we have below.

        ![](./images/400_33.png " ")

    19. Add the first rule, as shown in the screenshot below. The source CIDR is the CIDR range of your public subnet. Once you click on **Add**, you will see a rule in the list.

        ![](./images/400_34.png " ")

        ![](./images/400_35.png " ")

2. Your Load Balancer is now working on top of your application. You can use the public IP of the Load Balancer to access Apache2's default homepage for Ubuntu. You can access the oscommcerce application by typing the \<public IP>/catalog URL.

## Use Case 2: Create a File Storage Network accessible inside the SDDC and in OCI

1. Create a file system.

    1. Click on the navigation menu. Under **Core Infrastructure**, click on **File Storage** and then **File Systems**.

        ![](./images/400_38.png " ")
    
    2. Click on the **Create File Systems** button.

        ![](./images/400_40.png " ")
    
    3. Click on the **Edit Details** option to the right of **File System Information**.

        ![](./images/400_42.png " ")

    4. Provide a name and select an **Availability Domain**. Let the **Encryption** be set to the default value. 

        ![](./images/400_43.png " ")

    5. Now, **Edit Details** for the **Mount Target**.

        ![](./images/400_44.png " ")

    6. Select the **Create New Mount Point Target** radio button. Give the mount point target a name. Choose the same VCN, as your SDDC and select the **Private Regional** subnet and click on the **Create** button.

        ![](./images/400_45.png " ")
    
    7. You should be able to see a screen, similar to the one below.

        ![](./images/400_50.png " ")
    
    8. Click on the 3 vertical dots in front of the **Export** and select **Mount Commands** from the menu that pops up.

        ![](./images/400_51.png " ")

    9. Change the **Image** to **Ubuntu**.

        ![](./images/400_66.png " ")

    10. We need to open the ports mentioned in the image above in the private subnet, containing the SDDC, to the subnet containing your Linux machine that will be mounting this file system viz VMWare workload network and the public subnet.
    
        ![](./images/400_57_0.png " ")

    11. Please note that you might not have to open the egress rules, if you already have traffic open to 0.0.0.0/0 on all ports. As shown previously, add the following ingress rules. The source CIDR range for first set of rules will be the public subnet that you have created.
    
        ![](./images/400_57_1.png " ")

        ![](./images/400_57_2.png " ")

    12. Now, add the second set of ingress rules where the source CIDR range is the SDDC workload CIDR.
    
        ![](./images/400_57_3.png " ")

        ![](./images/400_57_4.png " ")

    13. Now, access your SDDC, as shown in Lab 1 and launch your Ubuntu Instance.

        ![](./images/400_64.png " ")

        ![](./images/400_65.png " ")

    14. After you login to the machine, run the three commands, as shown below:

        sudo apt-get install nfs-common

        sudo mkdir -p /mnt/<replace with correct FSS name>

        sudo mount <replace with correct IP>:<replace with correct FSS name> /mnt/<replace with correct FSS name>

        ![](./images/400_68.png " ")

    15. After mounting the file system. Switch your directory to the file system and create a file. Use the ls command to confirm its presence.

        cd /mnt/<replace with correct FSS name>

        sudo touch lab.txt

        ls

        ![](./images/400_69.png " ")

    16. Open the file for editing and enter a custom message. 

        ![](./images/400_73.png " ")

        ![](./images/400_72.png " ")

    We have successfully mounted the File system to an instance in the VMware environment. As an extension we can also create a linux machine in the private subnet and can mount the same file system to that instance, as well. 

    18. After you spin up an Oracle linux machine go back to the file system export and fetch the commands for Oracle Linux.

        ![](./images/400_53.png " ")

    19. Follow a similar process to login to your Oracle Linux machine and to mount the file system using the aforementioned commands. You can now access the file system and should be able to access the same file, there as well.

        ![](./images/400_77.png " ")

    After all this hardwork, you have a hybrid environment for your application, with some servers running on VMware virtualization and the rest running in an OCI VCN.

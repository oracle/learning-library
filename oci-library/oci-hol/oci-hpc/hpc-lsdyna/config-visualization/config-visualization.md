# Configure Visualization

## Introduction

HPC workloads often require visualization tools for scheduling, monitoring or analyzing the output of the simulations. In these scenarios, it is often desired to create a GPU visualization node for optimal resolution and post processing. A GUI is not installed by default on OCI instances; however, one can be configured easily using VNC or X11 remote display protocol. The subsections below will walk through how to create a GPU visualization node in the public subnet using TurboVNC and OpenGL.

Estimated Lab Time: 25 minutes

## **STEP 1**: Setting up a VNC on your Bastion

By default, the only access to the Oracle Linux machine is through SSH in a console mode. If you want to see the graphical interface, you will need to set up a VNC connection. The following script will work for the default user opc. The password for the vnc session is set as "HPC_oci1" but it can be edited in the next set of commands. If you are not currently connected to the headnode via SSH, please do so as these commands need to be run on the headnode.
```
    sudo yum -y groupinstall "Server with GUI"
    sudo yum -y install tigervnc-server mesa-libGL
    sudo systemctl set-default graphical.target
    sudo cp /usr/lib/systemd/system/vncserver@.service /etc/systemd/system/vncserver@:1.service
    sudo sed -i 's/<USER>/opc/g' /etc/systemd/system/vncserver@:1.service
    sudo sed -ie '/^ExecStart=/a PIDFile=/home/opc/.vnc/%H%i.pid' /etc/systemd/system/vncserver@:1.service
    sudo mkdir /home/opc/.vnc/
    sudo chown opc:opc /home/opc/.vnc
    echo "password" | vncpasswd -f > /home/opc/.vnc/passwd
    chown opc:opc /home/opc/.vnc/passwd
    chmod 600 /home/opc/.vnc/passwd
    sudo systemctl start vncserver@:1.service
    sudo systemctl enable vncserver@:1.service
```

## **STEP 2**: Add a GPU Instance

The below steps are taken Using OpenGL to Enhance GPU Use cases on OCI - refer to the blog for more details.

1. Within the Console, navigate to Compute then Instances.
2. Create a Compute Instance for the Visualization Node: 
    * Select the desired AD 
    * Select the desired GPU shape (either VM or BM) 
    * Specify a GPU-compatible Oracle Linux image The latest Oracle Linux Image will automatically be GPU enabled. 
    * Select the Cluster Network VCN and Public Subnet 
    * Copy-paste your public ssh key 
    * Click Create.
3. Wait for the instance to provision then log into the instance via:
    
    ```
    ssh opc@<public ip> -i <private key> 
    ```
4. Install X Window System, a display manager (GNOME/GDM), and a desktop environment (MATE):
     
     ```
    sudo yum groupinstall "X Window System"
    sudo yum install gdm
    sudo yum groupinstall "MATE Desktop"    
    ```
5. Install VNC server and VirtualGL. Note that VirtualGL is an open source toolkit that lets any Linux or Unix console run OpenGL applications with full hardware acceleration.
   
     ```
    sudo yum install https://downloads.sourceforge.net/project/virtualgl/2.6.3/VirtualGL-2.6.3.x86_64.rpm
    sudo yum install https://downloads.sourceforge.net/project/turbovnc/2.2.4/turbovnc-2.2.4.x86_64.rpm    
    ```
6. Configure the X server to enable GPU sharing for virtual sessions. Run the following commands:
    
     ```
    sudo nvidia-xconfig --use-display-device=none --busid="PCI:4:0:0"
    ```
7. Configure the X server to enable GPU sharing for virtual sessions. Run the following commands:
    
    ```
    sudo vglserver_config -config -s -f -t
    ```
8. To avoid being locked out when the screen saver launches, set the local user password to something you can use later:
    
    ```
    sudo passwd opc
    ```
9. Change your VNC password to something you can use for logging on:
    
    ```
    vncpasswd
    ```
10. Restart the X Server:
    
    ```
    kill $(pgrep Xvnc)
    vncserver
    ```
11. Enable and Start GDM:
    
    ```
    systemctl enable gdm --now
    ```
12. Launch the VNC server:
    
    ```
    /opt/TurboVNC/bin/vncserver -wm mate-session
    ```
13. If you want to access the VNC server directly without SSH forwarding, ensure that your security list allows connections on port 5901/tcp.
    * In the Console, navigate to Networking then Virtual Cloud Networks.
    * Select Subnets and then the public subnet.
    * In the default security list, add an Ingress Rule with the following details:
        * Stateless: No
        * Source Type: CIDR
        * Source CIDR: 0.0.0.0/0
        * IP Protocol: TCP
        * Source Port Range: All
        * Destination Port Range: 5901
Note: The standard VNC port is 5900 plus a display number (for example, 5901 for :1, 5902 for :2)


14. Allow access in local firewall settings, as follows:
   
   ```
    sudo firewall-cmd --zone=public --permanent --add-port=5901/tcp
    sudo firewall-cmd --reload
    ```
15. Open TurboVNC or TigerVNC client. Enter the IP address connection as :1


## Acknowledgements
* **Author** - High Performance Compute Team
* **Contributors** -  Chris Iwicki, Harrison Dvoor, Gloria Lee, Selene Song, Bre Mendonca, Samrat Khosla
* **Last Updated By/Date** - Samrat Khosla, October 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/high-performance-computing-hpc). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
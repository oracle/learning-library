# Access your VNC

## Introduction
In this lab, you will access your VNC.

Estimated Lab Time: 10 minutes

## **STEP**: Access your VNC

1. We will connect through an SSH tunnel to the instance. On your machine, connect using ssh PORT below will be the number that results from 5900 + N. N is the display number, if the output for N was 1, PORT is 5901, if the output was 9, PORT is 5909 public_ip is the public IP address of the headnode, which is running the VNC server. If you used the previous instructions, port will be 5901
    ```
        ssh -L 5901:127.0.0.1:5901 opc@public_ip
    ```

2. You can now connect using any VNC viewer using localhost:N as VNC server and the password you set during the vnc installation. You can chose a VNC client that you prefer or use this guide to install on your local machine:
* [Windows-TigerVNC](https://github.com/TigerVNC/tigervnc/wiki/Setup-TigerVNC-server-%28Windows%29)
* [MacOS/Windows - RealVNC](https://www.realvnc.com/en/connect/download/vnc/)

## Acknowledgements
* **Author** - High Performance Compute Team
* **Contributors** -  Chris Iwicki, Harrison Dvoor, Gloria Lee, Selene Song, Bre Mendonca, Samrat Khosla
* **Last Updated By/Date** - Samrat Khosla, October 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/high-performance-computing-hpc). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
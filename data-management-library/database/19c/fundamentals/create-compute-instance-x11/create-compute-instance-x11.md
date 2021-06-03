# Appendix A: Create a Compute Instance with X11 Forwarding

## Introduction

In this lab, you create a compute instance in Oracle Cloud Infrastructure (OCI) and configure X11 forwarding. Using X11 forwarding in an SSH session on your local personal computer is one way that you can securely run graphical applications (X clients). The advantages of using X11 over an SSH tunnel to run individual applications is that little setup is required and you don’t need to have a desktop environment running in the background on your compute instance. You can just start and stop applications as needed.

For X11 forwarding in SSH to work, your local computer must be running an X server program. The X server program manages the interaction between the remote application (the X client, such as the Oracle Database 19c installer) and your computer's hardware.

This lab shows you how to set up X11 forwarding on Windows 10 and macOS. The Windows 10 example uses PuTTY with VcXsrv (X Server). Some of the steps for Windows involve Cloud Shell. Cloud Shell is a small virtual machine running a Bash shell, which you can access through the OCI console. The macOS example uses XQuartz.


Estimated Lab Time: 30 minutes

### Objectives

In this lab, you learn how to do the following:

- Create SSH keys
- Create a compute instance in Oracle Cloud Infrastructure
- Connect to your compute instance
- Configure X11 forwarding on your compute instance
- Install an X Server on your local computer
- Connect to your compute instance from your local machine
- Test X11 forwarding
- Configure X11 forwarding for an `oracle` user



### Prerequisites

- You have an Oracle account. You can obtain a free account by using Oracle Free Tier or you can use a paid account provided to you by your own organization.
- You have a compartment in Oracle Cloud Infrastructure.
- (Windows) You have PuTTY and PuTTYgen installed on your local computer.

### Assumptions

- You are signed in to Oracle Cloud Infrastructure.

## **STEP 1**: Create SSH keys

The SSH (Secure Shell) protocol is a method for secure remote login from one computer to another. SSH enables secure system administration and file transfers over insecure networks using encryption to secure the connections between endpoints. SSH keys are an important part of securely accessing Oracle Cloud Infrastructure compute instances in the cloud.

1. Open a terminal window.

  - Windows: On the OCI toolbar, click the **Cloud Shell** icon.
  - MacOS: From the **Go** menu, select **Utilities**, and then double-click **Terminal**.

2. Create a `.ssh` directory.

    ```nohighlighting
    $ <copy>mkdir ~/.ssh</copy>
    ```

3. Change to the `.ssh` directory.

    ```nohighlighting
    $ <copy>cd ~/.ssh</copy>
    ```

4. Generate an SSH key pair by using the `ssh-keygen` command. The following command creates a private key named `cloudshellkey` and a public key named `cloudshellkey.pub`. When prompted to enter a passphrase, click **Enter** twice to not enter a passphrase.

    ```nohighlighting
    $ <copy>ssh-keygen -b 2048 -t rsa -f cloudshellkey</copy>

    Generating public/private rsa key pair.
    Enter passphrase (empty for no passphrase):
    Enter same passphrase again:
    Your identification has been saved in cloudshellkey.
    Your public key has been saved in cloudshellkey.pub.
    The key fingerprint is:
    SHA256:EJBYzyxwwHi9y4jc+pqWVjSvFtiv2xmj+K9C4IovcSY jody_glove@2ff9ae3459e2
    The key's randomart image is:
    +---[RSA 2048]----+
    | oo=+o.          |
    |. +oo+ .         |
    | .  ..=          |
    |.  o.. .         |
    |+.=oo.  S        |
    |E=+=o.           |
    |+=+ +o           |
    |+*ooo.+          |
    |o*BB=+           |
    +----[SHA256]-----+
    ```

5. Confirm the private key and public key files exist in the `.ssh` directory.

    ```nohighlighting
    $ <copy>ls</copy>

    cloudshellkey  cloudshellkey.pub
    ```

6. Set the file permissions so that only you can read the file.

    ```nohighlighting
    chmod 400 cloudshellkey
    ```

7. Show the contents of the public key. In the next step when you create a compute instance, you copy this key to the clipboard and paste it into the SSH keys box.

    ```nohighlighting
    $ <copy>cat cloudshellkey.pub</copy>

    ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDqs9uly7HqmiJlaSQmgJ8gmJ65avZt5KBGN+kgcgxKDbLdmVqaN0Ois3vnrMeHYN+gHFp2qRM4RV7bAwbrHaTo6PqAhqMqmF/k5o5c23/+WlL+HUOS00UXBBYLVz2v2kz3dq10E7zwX68DKqaBRo5iPSoLGssh2lWq8yTMFnD04nma5DSzV5LpIa9bWTaUU4jVGVhvAdX+832yOfzflkEWdaaX6rh17t6IuY5aiOWgDJmdNQouXsmqDHFS98tJFqmNDzrx7qL5tP0q0HzcQ7BNkdWamy1znwJBiRferLGzlLvOEEDpjgTzmgRKzeoLieFACQh+iXbTJ4jfyTrP9va1 jody_glove@da779ce27a8a
    ```

7. Leave the terminal window open.


## **STEP 2**: Create a compute instance in Oracle Cloud Infrastructure

1. On the **Home** page in Oracle Cloud Infrastructure, under **Quick Actions**, click **Create a VM instance**.

  The **Create Compute Instance** page is displayed.

2. For **Name**, enter **workshop**.

3. For **Create in compartment**, select the compartment that you created or was provided to you.

4. For **Placement**, select an availability domain.

5. For **Image and shape**, do the following:

  a) Click **Edit**.

  b) Leave **Oracle Linux 7.9** selected as the image build. This option installs Linux Kernel version 5.4.17-2036.104.5.el7uek.x86_64.

  c) Click **Change Shape**. In the **Browse All Shapes** window, scroll down and select **VM.Standard.E2.4**. Click **Select Shape**. This shape has enough memory to run the database 19c binaries.

6. For **Networking**, select **Create new virtual cloud network** and **Create new public subnet**. These options create a VCN and subnet, and assigns your compute instance a public IPv4 address so that you can access the compute instance from the internet.

7. For **Add SSH keys**, do the following:

  a) Select **Paste public keys**.

  b) In the **SSH keys** box, paste the public key that you copied from the terminal window. Be careful not to include any carriage returns.

8. For **Boot** volume, do not select any of the options.

9. Click **Create**.

  Oracle Cloud Infrastructure provisions your compute instance in less than a minute. During provisioning, your compute instance's page is displayed and shows you general information, instance details, shape configuration, instance access details (your public IP address and username), primary VNIC information, and launch options.

10. Wait for the status of the compute instance to turn to **RUNNING**.


## **STEP 3**: Connect to your compute instance


1. On the **Instance Information** tab for your compute instance, find the public IP address and copy it to the clipboard. Also, jot down the public IP address so that you can refer to it later.

2. In the terminal window, enter the following `ssh` command to connect to your compute instance, replacing `compute-public-ip` with your own values.

    ```nohighlighting
    $ <copy>ssh -i ~/.ssh/cloudshellkey opc@compute-public-ip</copy>
    ```

    You receive a message stating that the authenticity of your compute instance can't be established. Do you want to continue connecting?

3. Enter **yes** to continue. The public IP address of your compute instance is added to the list of known hosts on your Cloud Shell machine.

  The terminal prompt becomes `[opc@workshop ~]$`, where `workshop` is the name of your compute instance and `opc` is your user account on your compute instance. You are now connected to your new compute instance.




## **STEP 4**: Configure X11 forwarding on your compute instance

1. Switch to the `root` user.

    ```nohighlighting
    $ <copy>sudo su -</copy>
    ```

2. Use `yum` to install all the dependencies needed to run X11 applications.

    ```nohighlighting
    # <copy>yum install -y xorg-x11-server-Xorg xorg-x11-xauth xorg-x11-utils xorg-x11-apps xorg-x11-fonts-* xorg-x11-font-utils xorg-x11-fonts-Type1</copy>
    ```

    *REVIEWER: Other sources () say to install:
    sudo yum -y install xauth
    sudo yum -y install xterm
    and that's it*

2. Open the `sshd_config` file, which is the configuration file for the SSH service.

    ```nohighlighting
    # <copy>vi /etc/ssh/sshd_config</copy>
    ```

3. Edit the following lines to be as follows:

    - `X11Forwarding yes` (already set by default)
    - `X11DisplayOffset 10`
    - `X11UseLocalhost no`

  Tip: To delete text, press **d** and use the left and right arrow keys. To add text, press **i** and enter text.

4. Save and exit the vi editor.

  Tip: Press **Esc**, enter **:wq**, and then press **Enter**.

5. Restart the SSH service so the new settings take effect.

    ```nohighlighting
    # <copy>systemctl restart sshd</copy>
    ```


## **STEP 5**: Install an X Server on your local computer

Set up an X Server on your local computer so that you can run graphical applications on your compute instance. For Windows 10, you can install VcXsrv. For macOS, you can install XQuartz.

### Windows 10 - Install VcXsrv

1. In a browser on your Windows machine, access the following URL:

    ```nohighlighting
    <copy>https://sourceforge.net/projects/vcxsrv/</copy>
    ```

2. Click **Download**.

3. In the dialog box, click **Save File** and save the executable to a directory on your local machine. At the time of this writing, the file is named `vcxsrv-64.1.20.9.0.installer.exe`.

4. Double-click the executable file to launch the installer for VcXsvr.

5. For type of install, do a full (all options selected, VcXsrv, Fonts, Start Menu Shortcuts, Desktop Shortcuts), and click **Next**.

6. For **Destination folder**, leave **C:\Program Files\VcXsrv** as is, and click **Install**.

7. When the installation is finished, click **Close**.

8. From the windows **Start** menu, select **VcXsrv**, and then **XLaunch**.

9. For **Display Settings**, leave **multiple windows** selected. For **Display number**, leave **-1** as is to let VcSsrv automatically choose one. Click **Next**.

10. On the **Select how to start clients** page, select **Start no client**, and click **Next**.

11. On the **Extra settings** page, select all options, including **Disable access control**, click **Next**.

12. Click **Finish**. Leave VcXsrv running.

  In the bottom right corner, a VcXsrv icon is displayed. If you need to stop XLaunch for some reason, double-click the icon and click **Exit**.


### macOS - Install XQuartz

1. In a browser on your local machine, enter the following url:

    ```nohighlighting
    <copy>http://www.xquartz.org</copy>
    ```

2. Click **XQuartz-2.8.1.dmg** to download the file. At the time of this writing, the XQuartz version is 2.8.1 for macOS 10.9 or later.

3. Double-click the downloaded DMG file and wait a moment for an XQuartz.pkg file to be displayed.

4. Double-click **XQuartz.pkg** to install XQuartz.

  A message lets you know that the package will run a program to determine if the software can be installed.

5. Click **Continue**.

  The installer is displayed.

6. On the **Introduction** page, click **Continue**.

7. On the **Read Me** page, click **Continue**.

8. On the **License** page, read the software license agreement, and then click **Continue**.

9. In the dialog box, click **Agree** to agree to the terms of the license software agreement.

10. On the **Installation Type** page, click **Install** to perform a standard installation.

11. Close any open applications, including the browser and terminal window.

12. Click **Continue Installation**.

13. In the dialog box, enter your computer user's password to allow the installation, and then click **Install Software**.

  The **Installation** page is displayed showing the installation activities. When the installation is completed, the **Summary** page is displayed.

14. Click **Log Out** to finish.

15. In the dialog box, click **Move to Trash** to delete the installer package.

16. *IMPORTANT!* Reboot your local computer.


## **STEP 6**: Connect to your compute instance from your local machine

An `.Xauthority` file is automatically generated the first time you log in to your compute instance. This file stores credentials in cookies used by `xauth` for authentication of X sessions. Once an X session is started, the cookie is used to authenticate connections to that specific display.


### Windows

Download your private key from Cloud Shell, convert it to PPK file format, and then connect to your compute instance using PuTTY.

1. Download your private key from Cloud Shell.

  a) From the Cloud Shell menu, select **Download**.

    The **Download File** dialog box is displayed.

  b) Enter **.ssh/cloudshellkey**, and then click **Download**.

    The file is transferred and the **Opening cloudshellkey** dialog box is displayed.

  c) Select **Save File** (even if it's selected already), and click **OK**.

  d) Browse to a directory on your local computer to which only you have access, and then click **Save**.

  e) If you haven't set up permissions on the folder to which you just saved your SSH private key, you need to do that before continuing on.

2. Convert your private key to PPK file format.

  a) Open **PuTTY Key Generator**.

  b) From the **Conversions** menu, select **Import key**.

  c) Browse to and select the private key file (.key) that was generated for you when you created your compute instance, and click **Open**. Your private key is converted into PPK format.

  d) Leave **RSA** as the type of key to generate, and click **Save private key**.

  e) Click **Yes** to save without a passphrase.

  f) Enter a name for your private key, and click **Save**. It's helpful to use the same name as your original `KEY` file, but with a `PPK` file extension.

  g) Close PuTTY Key Generator.


3. Configure an X11 forwarding connection in PuTTY that connects to your compute instance.

  a) Open PuTTY on your local Windows computer.

  b) On the **Session** tab, configure the following:

    - **Hostname**: Enter the public IP address for your compute instance.
    - **Port**: Leave port **22** as is.

  c) Browse to **Connection** > **Data**, and enter `opc` as the **Auto-login username**.

  d) Browse to **Connection** > **SSH** > **Auth**, and configure the following:

    - In the **Authentication parameters** area, click **Browse**.

    - Browse to your private key directory, select your private key (in `PPK` format), and then click **Open**.

  e) Browse to **Connection** > **SSH** > **X11**, and configure the following:

    - Select **Enable X11 forwarding**.

    - Leave the **X display location** box empty.

  f) Return to the **Session** tab. In the **Saved Sessions** box, enter the name of your compute instance, and then click **Save**. In the future, you can simply load your saved session and quickly connect.

  g) Click **Open**. A message is displayed that the server's host key is not cached in the registry.

  h) Click **Yes** because you trust this host. You are now logged in as the `opc` user. Notice that the following line is displayed:

    ```
    /usr/bin/xauth: file /home/opc/.Xauthority does not exist
    ```

4. Display the authorization information for the `opc` user used to connect to the X server.

    ```
    $ <copy>xauth list</copy>

    workshop.subnet03311012.vcn03311012.oraclevcn.com:10  MIT-MAGIC-COOKIE-1  9055a7967897789f94fd6a3fbc1b4b90
    ```

5. View the `DISPLAY` environment variable.

    ```
    $ <copy>echo $DISPLAY</copy>

    10.0.0.95:10.0
    ```
    The output is `compute-private-ip:10.0`. Notice that the `10` is also part of the authentication information in the previous step.



### macOS

1. From the **Go** menu, select **Utilities**, and then double-click the **XQuartz** icon.

  A terminal window is displayed.

2. Connect to your compute instance. To use X11 forwarding to your Mac, you can use the `-X` switch. In the following command, replace `compute-public-ip` with the public IP address of your compute instance.

    ```nohighlighting
    $ <copy>ssh -X -i ~/.ssh/cloudshellkey opc@compute-public-ip

    /usr/bin/xauth: file /home/opc/.Xauthority does not exist.
    ```


3. Display the authorization information for the `opc` user used to connect to the X server.

    ```nohighlighting
    $ <copy>xauth list</copy>

    workshop.subnet03311012.vcn03311012.oraclevcn.com:10  MIT-MAGIC-COOKIE-1  9055a7967897789f94fd6a3fbc1b4b90
    ```

4. View the `DISPLAY` environment variable.

      ```
      $ <copy>echo $DISPLAY</copy>

      10.0.0.95:10.0
      ```
      The output is `compute-private-ip:10.0`. Notice that the `10` is also part of the authentication information in the previous step.




## **STEP 6**: Test X11 forwarding

Test that the `opc` user can open a graphical user interface application like `xeyes`.

1. As the `opc` user, launch `xeyes`.

    ```
    $ <copy>xeyes</copy>
    ```
  A pair of eyes is displayed in a separate window. If you move your cursor over the eyes, the eyes follow it.

2. Hover your cursor over the XLaunch application icon.

  The application indicates that there is one client connected.

3. Close `xeyes`.

  (Windows) The XLaunch application icon indicates that there are zero clients connected.



## **STEP 7**: Configure X11 forwarding for an `oracle` user

The Oracle Universal Installer also has a graphical user interface and should be run by the `oracle` user. Therefore, if you plan to do an Oracle Database 19c installation on your compute instance, you need to configure X11 forwarding for the `oracle` user.

1. Switch to the `root` user.

    ```nohighlighting
    $ <copy>sudo su -</copy>
    ```

2. Create an `oracle` user. The following commands are used to create an `oracle` user in preparation for an Oracle Database 19c installation.

    ```nohighlighting
    $ <copy>groupadd -g 54321 oinstall</copy>
    $ <copy>groupadd -g 54322 dba</copy>
    $ <copy>groupadd -g 54323 oper</copy>
    $ <copy>useradd -u 54321 -g oinstall -G dba,oper oracle</copy>
    ```
3. Set the password for the `oracle` user as `Ora4U_1234`.

    ```nohighlighting
    $ <copy>passwd oracle</copy>
    ```

    Enter and confirm `Ora4U_1234` as the password.

4. Return to the `opc` user.

    ```nohighlighting
    # <copy>exit</copy>
    ```

5. *IMPORTANT!* As the `opc` user, copy the `Xauthority` file from the `opc` user to the `oracle` user.

    ```nohighlighting
    $ <copy>sudo cp ~/.Xauthority /home/oracle/.Xauthority</copy>
    ```


6. Switch to the `oracle` user and enter the password `Ora4U_1234`.

    ```nohighlighting
    $ <copy>su - oracle</copy>
    ```

7. Test that the `oracle` user can open a graphical user interface application like `xeyes`.

    ```
    $ <copy>xeyes</copy>
    ```


## What's Next?

Be sure to complete the [Perform Prerequisite Tasks for an Oracle Database 19c Installation](?lab=perform-db19c-prerequisite-tasks.md) prior to doing the [Install Oracle Database 19c with Automatic Root Script Execution](?lab=install-db19c-auto-root-script-execution.md) lab.



## Learn More

- [Running Graphical Applications Securely on Oracle Cloud Infrastructure](https://docs.oracle.com/en-us/iaas/Content/Resources/Assets/whitepapers/run-graphical-apps-securely-on-oci.pdf)


## Acknowledgements

- **Author**- Jody Glover, Principal User Assistance Developer, Database Development
- **Technical Contributors**
    - James Spiller, Principal User Assistance Developer, Database Development
    - Dragos Negru, Principal Cloud Specialist - Data Management, TE Hub
    - Jean-Francois Verrier, User Assistance Director, Database Development
- **Last Updated By/Date** - Jody Glover, Database team, May 4 2021

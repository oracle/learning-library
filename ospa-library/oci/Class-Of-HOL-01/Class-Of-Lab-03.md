![](./media/image1.png)


## Class of SE - HOL Part 3 - Creating and accessing an instance

Contents

[Section 6. Create SSH Key Pair (Linux, Mac, Windows, Windows 10)](#create-ssh-key-pair-linux-mac-windows-client)

[Section 7. Create a Compute Instance](#create-a-compute-instance)

[Section 8. Access the instance](#access-the-instance)

## 

#

# Create SSH Key Pair (Linux, Mac, Windows client)
[Back to top](#Class-of-SE---HOL-Part-3---Creating-and-accessing-an-instance)

SSH keys are required to access a running OCI instance securely. You can use an existing SSH-2 RSA key pair or create a new one. Below are instructions for generating your individual key pair for Linux, Mac, Windows, and Windows 10.  Windows 10 is the first Windows version to natively support ssh and terminal access.   Insructions for creating SSH keys can also be found on the OCI documentation page.
<https://docs.cloud.oracle.com/iaas/Content/GSG/Tasks/creatingkeys.htm>

Scroll down and choose the key creation method for your operating system, Linux/Mac, Windows, or Windows 10.

## Linux or Mac based Operating System  

1.  **Open a terminal**  From the opc user home directory (default) type the ssh-keygen command.  Press \<Enter> when asked for the filename, and \<Enter> twice for *no passphrase*.

    `[opc-instance]$ ssh-keygen`

**Note:** *Don't lose your key or forget the passphrase if you assign one, the key won't be usable without them.* 

Typing *ssh-keygen* by itself creates a key named id_rsa under the default .ssh directory.  If you want to name your key, store it in another directory, or add other security options, the ssh-keygen command takes a number of useful switches.  

**ssh-keygen command switch guide:**

    -t – algorithm
    -N – “passphrase” Not required but best practice for better security
    -b – Number of bits – 2048 is standard
    -C – Key name identifier
    -f - \<path/root\_name\> - location and root name for files

![](./media/image32a.png)

*<p align="center"> Figure 24: ssh-keygen command </p>*

For this lab, the default key is all that's necessary

2.  The key pair you generated is now stored in the default .ssh directory.  Use the `ls -l .ssh` command to verify.

![](./media/image33a.png)

*<p align="center"> Figure 25: Sample key pair stored in the .ssh directory. </p>*

3.  For Linux and Mac Clients you can load the .pub keyfile directly from the OCI Compute Instance creation screen.  Just remember the folder where you stored it.  Or optionally, you can copy the contents of the public key file (.pub). Use an editor or the `cat` command to view the file and copy the key contents. You can use this for the ‘paste key’ dialog when launching an instance.  Whichever method you prefer.

![](./media/image34a.png)

*<p align="center"> Figure 26: Copy ssh key </p>*

##  Windows Operating System (*Version earlier than 10*)

A third party SSH client needs to be installed for Windows versions prior to Windows 10 in order to generate SSH keys. You can use Git Bash, Putty, or a tool of your choice. This tutorial will use Putty as an example. Git Bash or any third party shell program instructions will likely be the same as the Linux instructions above.

**Note:** *If you don’t already have it, download the Putty application and install it on your Windows machine. [<span class="underline">Download Putty</span>](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html).  Puttygen is a utility that comes with the Putty package and is used to generate SSH keys.  For Oracle employees, Putty is also available from the MyDesktop application.*   

<!-- end list -->

1.  After installing Putty, from the Windows start menu, run the PuTTYgen utility

![](./media/image35.png)

*<p align="center"> Figure 27:  PuTTYgen utility command </p>*

2. Click the Generate button and follow the instructions for generating random information.

![](./media/image36.png)

*<p align="center"> Figure 28: Generate the key with PuttyGen </p>*

3. After the key information has been generated, enter an optional **passphrase** and press the **Save private key** button to save the key to your system.

**Note:** *A passphrase is not required but recommended for stronger security.*

![](./media/image37.png)

*<p align="center"> Figure 29: Putty save key dialog </p>*

4. The private key should have the .ppk extension. Name it whatever you want and store it in a folder that’s easily accessible.

![](./media/image38.png)

*<p align="center"> Figure 30: Saving the private key </p>*

**NOTE:**  *We will not use the ‘Save public key’ option in PuttyGen, as the keyfile is not compatible with Linux openSSH. Instead, we will copy and paste the key information into a text file.*

5. Left click on the Public key information and choose ‘Select All’ to select everything in the key field. Then left click again and copy the selected information to the clipboard.

![](./media/image39.png)

*<p align="center"> Figure 31: Save all and copy key to clipboard </p>*

6. We will use the clipboard to paste the key information in the next step but you can also save your public key to a text file with Notepad. Open a plain text editor and paste the key information. Name and save the file with a .pub extension.

![](./media/image40.png)

*<p align="center"> Figure 32: Key pasted and saved with Windows Notepad </p>*

7. Close the Puttygen application

## Windows 10 Based Operating System  

1.  **Open a cmd or Powershell window** Either select the application from the Windows Start menu or type 'cmd' or 'powershell' from the Windows search menu.  

![](./media/image400.png)

*<p align="center"> Figure 33: Windows search menu 'Powershell' </p>*

SSH commands are available from either application, you can use whichever application you prefer.

![](./media/image401.png)

*<p align="center"> Figure 34: Windows CMD window and Powershell window </p>*

2. From your home directory (should be the default C:\Users\<Your Name>) type the `ssh-keygen` command.  Press **Enter** when asked for the filename, and press **Enter** twice for *no passphrase*.

    `PS C:\Users\dkingsle> ssh-keygen`

![](./media/image402.png)

*<p align="center"> Figure 35: ssh-keygen command from Powershell</p>*

Typing *ssh-keygen* by itself creates a key named id_rsa under the default .ssh directory.  If you want to name your key, store it in another directory, or add other security options, the ssh-keygen command takes a number of useful switches.  

**ssh-keygen command switch guide:**

    -t – algorithm
    -N – “passphrase” Not required but best practice for better security
    -b – Number of bits – 2048 is standard
    -C – Key name identifier
    -f - \<path/root\_name\> - location and root name for files

For this lab, the default key is all that's necessary

3.  The key pair you generated is now stored in the default .ssh directory.  Use the `ls -l .ssh` command to verify.

**Note:** *With Linux/Mac OS, the .ssh directory is hidden and can be viewed with the `ls -a` command switch.  In Windows, the .ssh directory is not hidden and requires no special treatment.*

![](./media/image403.png)

*<p align="center"> Figure 36: Key pair files stored in the .ssh directory. </p>*

# Create a Compute Instance
[Back to top](#Class-of-SE---HOL-Part-3---Creating-and-accessing-an-instance)

1.  Now that you've successfully created your SSH keys on whatever platform you're using, open the OCI web console.  Use the top left hamburger menu and choose **Compute \> Instances** to open the Instance Creation menu.

![](./media/image41.png)

*<p align="center"> Figure 37: Create Instance Menu item </p>*

2. Verify that you're using the correct compartment and click the **Create Instance** button

![](./media/image42a.png)

*<p align="center"> Figure 38: Create instance button </p>*

![](./media/image43a.png)

*<p align="center"> Figure 39: Information required to create an instance </p>*

3. Enter information to create your compute instance.

**Note:** *Depending on available resources for Class of SE labs, you may need to select resources from a particular Availability Domain, or use a different compute shape.   If resources aren't available, try another AD, or use **Choose Instance Shape** to find another instance type that has availability.  If in doubt, ask your instructor which AD you should utilize.*

| **Name:**                | \<instance name\> |
| ------------------------ | ------------------------------------------------ |
| Availability Domain: | AD of your choice, AD1, AD2, or AD3   |
| Operating System:    | Oracle Linux 7.6                            |
| Instance Type:       | Virtual Machine                             |
| Shape:               | VM.Standard1.2                              |
| Boot Volume:         | Default                                     |
| SSH Key:             | Choose SSH Key file or Paste SSH keys      |
| Compartment:         | Your compartment* (*ex:* team-100)     |
| VCN:                 | Your VCN* (*ex:* Team 100 VCN)              |
| Subnet Compartment:  | Your subnet compartment* (ex: team-100)     |
| Subnet:              | Public Subnet in your compartment*            |

4. In the **Add SSH Key** section you can select the SSH key file from your file system, use the file with the .pub extension.  Or you can paste directly from the clipboard (if you’ve saved that information from the key generation step earlier).

![](./media/image44.png)

*<p align="center"> Figure 40: Choose SSH Key option </p>*

![](./media/image45.png)

*<p align="center"> Figure 41:  Paste SSH key option </p>*

5. In the Configure networking Section leave the default VCN and subnet information and click **Create**. 

![](./media/image46a.png)

*<p align="center"> Figure 42: Create compute instance dialog </p>*

Your instance will begin provisioning and should be in the available state within a few moments.

![](./media/image47a.png)

*<p align="center"> Figure 43: Instance provisioning </p>*

After a few moments, the icon will turn green and the title will change to RUNNING.

![](./media/image48a.png)

*<p align="center"> Figure 44: Running instance and Primary VNIC information </p>*

6. Take note of the Primary VNIC information which contains the assigned Public and Private IP Addresses.  You will need this information to access the instance later in the lab.  

# Access the instance 
[Back to top](#Class-of-SE---HOL-Part-3---Creating-and-accessing-an-instance)

We will use SSH through a terminal session to access the compute image. From there we will install a simple web application.  Scroll down and choose your preferred access method, Linux/Mac, Windows with Putty, or Windows 10 through Powershell.

## SSH Key access for Linux/Mac 

1.  Use your favorite terminal and issue the below `ssh` command to connect. Use the public IP address of your instance as referenced in the above screenshot.  *(The IP address listed is for example only, yours will be different.)*

2. Issue the following command.  Enter `yes` when prompted about authenticity.

    `ssh  opc@<your ip address>`

![](./media/image49a.png)

*<p align="center"> Figure 45: SSH connection to running instance </p>*

**Note:**  *If your SSH key is located somewhere else in your file structure, use `ssh -i <keyfile path/keyfile name> opc@xxx.xxx.xxx.xxx` to enable SSH to use your key.*

## SSH Key access for Windows with Putty

1.  For Windows clients prior to version 10, open Putty. With the Session category selected, enter the IP address for the instance you want to access and select SSH from the radio buttons (port 22).

![](./media/image50a.png)

*<p align="center"> Figure 46: Putty session information </p>*

2. In the Connection category, choose **Data** and enter ‘opc’ as the Auto-login username.

![](./media/image51a.png)

*<p align="center"> Figure 47: Putty auto-login information </p>*

3. In the **Connection \> SSH \> Auth** category, use the Browse button to navigate and load the .ppk file you created earlier with Putty.

![](./media/image52a.png)

*<p align="center"> Figure 48: Putty private SSH key </p>*

4. Navigate back to the **Session** category, enter a name in the **Saved Sessions** field and choose Save. Use any name you like for the session name in Putty.  This will save your SSH terminal session for use later without having to re-enter the information.

v![](./media/image53a.png)

*<p align="center"> Figure 49: Putty Save SSH Session </p>*

5. Click on **Open** to connect to the instance.

v![](./media/image53b.png)

*<p align="center"> Figure 50: Open Putty Session </p>*

6. Choose **Yes** on the alert message:

![](./media/image54.png)

*<p align="center"> Figure 51: Putty security alert </p>*

7. You will be logged into the compute image:

![](./media/image55.png)

*<p align="center"> Figure 52: Successful Putty instance login </p>*

## SSH Key access for Windows 10 Systems

1.  For Windows 10 clients, open a `cmd` or Powershell window.  From the default user directory enter the SSH login command using the `opc` username and the ip address of your instance.

`ssh opc@<your instance ip address>`

2. Enter `Yes` when asked about the fingerprint.

![](./media/image404.png)

*<p align="center"> Figure 53: Powershell SSH command </p>*

You have successfully logged into a cloud Linux instance as the `opc` admin user.  You can browse the Linux OS, make configuration changes, or install software, as time permits.

![](./media/image99.png)

This lab segment is complete.    If there is time left before the next lecture, browse the OCI cloud interface and familiarize yourself with the layout and basic services.  Wait for the instructor to let you know when to begin section 4.

[Back to top](#Class-of-SE---HOL-Part-3---Creating-and-accessing-an-instance)

##

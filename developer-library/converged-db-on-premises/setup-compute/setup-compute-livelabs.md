# Setup Compute Instance

## Introduction
This lab will show you how to login to your pre-created compute instance running on Oracle Cloud. 

### Objectives
-   Connect to your converged db compute instance

### Prerequisites
This lab assumes you have:
- A LiveLabs Cloud account and assigned compartment
- The IP address and instance name for your Compute instance
- Successfully logged into your LiveLabs account
- A Valid SSH Key

## **Step**: Connect to your instance

Choose the environment where you created your ssh-key in the previous lab (Generate SSH Keys)
***Note:*** *If you are having issues connecting and on your corporate VPN may prevent you from logging in.  Exit VPN to proceed*

### MAC or Windows CYGWIN Emulator
1.  Go to **Compute** -> **Instance** and select the instance you created (make sure you choose the correct compartment)
2.  On the instance homepage, find the Public IP address for your instance.
3.  Open up a terminal (MAC) or cygwin emulator as the opc user.  Enter yes when prompted.

    ````
    ssh -i ~/.ssh/<sshkeyname> opc@<Your Compute Instance Public IP Address>
    ````
    ![](./images/em-mac-linux-ssh-login.png " ")

4.  After successfully logging in, you may *proceed to the next lab*

### Windows using Putty

On Windows, you can use PuTTY as an SSH client. PuTTY enables Windows users to connect to remote systems over the internet using SSH and Telnet. SSH is supported in PuTTY, provides for a secure shell, and encrypts information before it's transferred.

1.  Download and install PuTTY. [http://www.putty.org](http://www.putty.org)
2.  Run the PuTTY program. On your computer, go to **All Programs > PuTTY > PuTTY**
3.  Select or enter the following information:
    - Category: _Session_
    - IP address: _Your service instance’s public IP address_
    - Port: _22_
    - Connection type: _SSH_

  ![](images/7c9e4d803ae849daa227b6684705964c.jpg " ")

#### **Configuring Automatic Login**

1.  In the category section, **Click** Connection and then **Select** Data.

2.  Enter your auto-login username. Enter **opc**.

  ![](images/36164be0029033be6d65f883bbf31713.jpg " ")

#### **Adding Your Private Key**

1.  In the category section, **Click** Auth.
2.  **Click** browse and find the private key file that matches your VM’s public key. This private key should have a .ppk extension for PuTTy to work.

  ![](images/df56bc989ad85f9bfad17ddb6ed6038e.jpg " ")

To save all your settings:

3.  In the category section, **Click** session.
4.  In the saved sessions section, name your session, for example ( EM13C-ABC ) and **Click** Save.
5.  Click **Open** to start your session.

You may now *proceed to the next lab*.  


## Appendix: Troubleshooting Tips

If you encountered any issues during the lab, follow the steps below to resolve them.  If you are unable to resolve, please skip to the **See an Issue** section to submit your issue via our feedback form.
- Invalid public key

### Issue 1: Invalid public key
![](images/invalid-ssh-key.png  " ")

#### Issue #1 Description
When creating your SSH Key, if the key is invalid you may not be able to login to your pre-created instance

#### Tips for fixing for Issue #1
- Go back to the LiveLabs registration page and ensure you created and **copy/paste** your key into the stack correctly.
- Ensure you pasted the *.pub file into the window.
1.  Delete your reservation
2.  Create a new reservation with a valid key.

## Acknowledgements

* **Author** - Rene Fontcha, Master Principal Solutions Architect, NA Technology
* **Contributors** - Kay Malcolm, Product Manager, Database Product Management
* **Last Updated By/Date** - Kay Malcolm, Product Manager, Database Product Management, August 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.

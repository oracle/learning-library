# Upgrade to 19c database Hands-On-Lab Environment setup #

Since we are going to work with upgrading databases, we have prepared an image with several sources database already setup. This image is accessible through Remote Desktop applications and runs in the Oracle OCI Cloud. 

## Disclaimer ##
The following is intended to outline our general product direction. It is intended for information purposes only, and may not be incorporated into any contract. It is not a commitment to deliver any material, code, or functionality, and should not be relied upon in making purchasing decisions. The development, release, and timing of any features or functionality described for Oracle’s products remains at the sole discretion of Oracle.

## Requirements ##

To complete this lab, you need the following account credentials and assets:

- Oracle PTS 19c HOL environment
	- This environment will be pre-setup by your instructor
	- Access details (username, password, ip address) will be made available to you
- Remote Desktop Client compatible with our Remote Desktop Server
	- Windows 7 or lower: Remote Desktop Client version 8.1 or higher
	- Windows 10: Remote Desktop Client from the Microsoft Store
	- MacOS: Only use the Remote Desktop Client provided by Microsoft (available in the iTunes store)

> ** Please do not use any of the credentials until the lab instructs you to **

> ** Do NOT log into the OCI console and/or create cloud resources until the lab instructs you to **

## Connect to the remote Hands-On Lab client image ##

The HOL lab was written based on the applications available through a Remote Desktop session on the client.

- Please connect to the Remote Desktop session provided for you
	- Locate the image IP address on the handout
	- use the Remote Desktop client to connect
	- Accept any certificate warnings that might be displayed
- Login as `oracle` user
	- Use the password as indicated on the handout

## Optional: Using SSH to connect to the image ##

By default, the SSH ports are enabled and the SSH daemon is running in the image so you can connect your favorite SSH client to the image as well for all non-graphical steps in the labs.

> **The ssh server only accepts public/private key authentication. 
> It is NOT allowed to change the authentication method to accept passwords !**

You are allowed to add your own public key to the `authorized_keys` file in the image. It is out of the scope of this hands-on lab to demonstrate how to do this. 

## Next step: Lab 1 - Install 19c ##

**All labs depend on the 19c installation in lab 1**

- There is no dependency between lab 2, lab 3, lab 4 and lab 5. 

Therefore, please continue with your hands-on experience by running the steps in Lab 1.

## Acknowledgements ##

- **Author** - Robert Pastijn, Database Product Management, PTS EMEA - April 2020


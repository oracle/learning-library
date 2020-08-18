# Frequently Asked Questions (FAQ)
## Introduction
The following are Frequently Asked Questions (FAQ) you may refer to when troubleshooting issues encountered while executing above labs.
### Contents
1. How to Check Status of Oracle Management Service, Other Services and Agent
2. How to be root on the workshop instance
3. How to Locate EMCLI on Your Instance
4. Oracle Management Server (OMS) / WebTier is Down
5. Unable to Connect to Oracle Management Server (OMS) Website
6. Restart an Agent Not Responding
7. How to Stop all Enterprise Manager (EM) Services Before Stopping an OCI instance
8. Steps To Setup VCN for FastConnect
9. Licensing Terms for the Enterprise Manager Marketplace Instance
10. How to Reset user oracle  password or if Named Credentials for user oracle are not working
11. Unable to connect to Enterprise Manager Console
12. Unable to Select Shape for Creating an instance
13. While trying to launch the EM instance: "Unable to accept Terms of Use."
14. Information about Oracle Cloud Infrastructure Pricing
15. Additional information on Oracle Cloud Infrastructure Setup
## 1. How to Check Status of Oracle Management Service, Other Services and Agent
Sudo to user oracle; As user *oracle* run the emctl status commands as shown:
````
<copy>emctl status oms
emctl status agent</copy>
````
## 2. How to be root on the workshop instance
You cannot login or su to root but should you need to execute a command as root, then run *sudo su command* as user *opc*. For example:
````
<copy>sudo su cat /var/log/messages|more</copy>
````
## 3. How to Locate emcli on Your Instance
Upon successful login via sudo as "oracle", environment variables are set and emcli is present in your path. The emcli utility is located at */u01/app/em13c/middleware/bin/emcli*
## 4. Oracle Management Server (OMS) / WebTier is Down
Restart the OMS as user *oracle*. Run *sudo su - oracle* first if you're not already connected as "oracle", then run:
````
<copy>. ./home/oracle/start_oms.sh</copy>
````
or
````
<copy>. ./home/oracle/start_all.sh</copy>
````
## 5. Unable to Connect to Oracle Management Server (OMS)  Website
Make sure you are on a public network or Oracle Cloud Network Access VPN. Verify services are up and running as shown in line item 1 above. Restart services as shown in line item 3 as needed.
## 6. Restart an Agent Not Responding
Restart the agent as user *oracle*. Run *sudo su - oracle* first if you're not already connected as "oracle", then run:
````
<copy>. ./home/oracle/start_agent.sh</copy>
````
## 7. How to Stop all Enterprise Manager (EM) Services Before Stopping an OCI instance
​Before stopping an OCI instance, stop all EM services for a clean shutdown as user *oracle*. Run *sudo su - oracle* first if you're not already connected as "oracle", then run:
````
<copy>. ./home/oracle/stop_all.sh</copy>
````
## 8. Steps To Setup VCN for FastConnect
​If (and only if) you are using a private subnet/FastConnect with your **VCN**, there are a few additional steps required to create the Service gateway, define the routing rule and egress rules.
1.  Create the Service Gateway and ``“All <RegionCode> Services in Oracle Services Network”, where <regioncode> `` refers to the OCI region of your EM compartment.
​
![](images/7a85046304e54181a1977a436d95ecf8.png " ")
2.  Add a new Route Rule for the Service Gateway you just created.
​
![](images/fd1722398ea3ca1d3fdf2e8d11410593.png " ")
3.  If (and only if) your private subnet has restrictions on outgoing traffic/egress you have to add egress rules for service network CIDRs for your OCI region.  For a list of CIDRs that apply to your region, refer to the OCI documentation “Public IP Address Ranges for the Oracle Services Network”.    
​
![](images/71d59dba104594e75e69b7e78615a796.png " ")
## 9. Licensing Terms for the Enterprise Manager Marketplace Instance
​This workshop environment is solely intended for non-production use to specifically explore the use cases outlined in the workshop instructions as posted in the Oracle Licensing Library.  All licensed Oracle Enterprise Manager, Oracle Linux and Oracle Database products included in the workshop environment may only be used expressly for workshop purposes and for the duration of the workshop, and furthermore, licensed Enterprise Manager Packs may only be used against the target environments that are included in the base workshop image, for the duration of the workshop.
​
In order to use the functionality, the following Licensed Packs have been enabled in the Enterprise Manager workshop image:
​
For the Database Lifecycle Management
-	Database Lifecycle Management Pack for Oracle  Database
- Cloud Management Pack for Oracle Database
For Database Performance Management On-premises
-	Oracle Diagnostics Pack
-	Oracle Tuning pack
-	Real Application Testing
## 10. How to Reset user *oracle* password or if Named Credentials for user oracle is not working
​Reset the password for user *oracle*. As user *opc*, run the following
````
<copy>sudo su password oracle</copy>
````
If *oracle* OS user password is updated, the Named Credential for *ORACLE* and also *ORACLE_HOST* needs to be updated. This can be done on the command line as user *oracle*. Run *sudo su - oracle* first if you're not already connected as *oracle*, then run:
````
<copy>emcli login -username=sysman -password=\<sysman_password\>
emcli modify_named_credential -cred_name=oracle -attributes="HostPassword:\<oracle_password\>"
emcli modify_named_credential -cred_name=oracle_host -attributes="HostPassword:\<oracle_password\>"
emcli logout</copy>
````
The Named Credential can also be updated via Enterprise Manager UI. On the EM Console navigate to Setup, then Security, and then Named Credentials.
​
![](images/700f13b043e394456607f070b599bc24.png " ")
​
**Click** on Credential Name ORACLE and **Click** on Edit. **Enter** the new password in the Credentials Sections twice and **Click** on Save. Repeat for Credential ORACLE_HOST
​
![](images/2e38a554bdbc3a68ce7cbfd84a6a3588.png " ")
## 11. Unable to connect to Enterprise Manager Console
​Make sure you are on a public network and not connected to a restricted corporate intranet or corporate wifi. Also ensure all web services are up and running by logging into your instance via SSH as indicated in this guide.
## 12. Unable to Select Shape for Creating an instance
​If you are seeing an Authorization Error while trying to Select Shape to Create an Instance:
1. From the Hamburger Menu on the Top Left of the Oracle Cloud Home Page, Go to Compute->Instances
2. Select the Compartment available to you in the Left Compartment Menu (not root)
3. Now that the compartment is set-up for new user, re-do the steps to create the Enterprise Manager Workshop from the Listing Link
### 13. While trying to launch the EM instance: Unable to accept Terms of Use.
​Make sure your email has been verified. Log out and Log back in and restart from the listing link. Also, verify you are using the same region and compartment that was assigned to you.
### 14. Additional information on Oracle Cloud Infrastructure Pricing
<https://www.oracle.com/cloud/pricing.html>
### 15. Additional information on Oracle Cloud Infrastructure Setup
<https://docs.cloud.oracle.com/en-us/iaas/Content/GSG/Concepts/baremetalintro.htm>

## Acknowledgements
- **Author** - Rene Fontcha, Master Principal Platform Specialist, NA Technology
- **Contributors** - Kay Malcolm, Product Manager, Database Product Management
- **Last Updated By/Date** - Kay Malcolm, Product Manager, Database Product Management, August 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section. 

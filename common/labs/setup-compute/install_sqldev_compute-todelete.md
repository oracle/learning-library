# Install SQL Developer on a Compute Instance

## Introduction
This lab will show you how to install SQL Developer on a Compute Instance.

# Prerequisites
This lab assumes that you have created a Compute Instance using an image that does not an application development environment.
Oracle Cloud Infrastructure Marketplace offers a <a href="https://cloudmarketplace.oracle.com/marketplace/en_US/adf.task-flow?adf.tfId=adhtf&adf.tfDoc=/WEB-INF/taskflow/adhtf.xml&application_id=54030984" "target=\_blank">Developer Image /a> that you can use to create an Oracle Cloud Compute instance to serve as your application development system. This image is preconfigured to contain many development tools and utilities.

This Lab assumes you have a VNC Server installed on your Compute Instance and a VNC Viewer installed on your laptop

## **Step 1:** Install SQL Developer

1. Open a VNC Viewer using *localhost:1* as the address of the VNC Server
![./images/tigervnc-viewer.png]()

2. Provide the password you set for the VNC Server
![./images/tigervnc_autheticate.png]()

3. You should now be logged in to your Compute Instance
![./images/tigervnc_screen.png]()

4. Open the Firefox browser from *Applications* -> *Internet* -> *Firefox*
![./images/Gnome_internet_firefox.png]()

Navigate to the SQL Developer Download site:
````
<copy>
https://www.oracle.com/tools/downloads/sqldev-downloads.html
</copy>
````
![./images/Gnome_firefox_sqldev_download.png]()

5. Select the Linux RPM for download

![./images/SQLDevRPM_download.png]()

6. Accept the License Agreement to commence download to /home/opc/Downloads

![./images/SQLDev_clickthrough.png]()

7. The RPM file will be called sqldeveloper-*build number*-noarch.rpm and will be in the /home/opc/Downloads directory

![./images/SQLDev_RPM.png]()

8. Open a terminal window *Applications* -> *System Tools* -> *Terminal*

![./images/vnc_terminal.png]()

9. Change to the Downloads directory and install the RPM

````
cd /home/opc/Downloads

sudo rpm -Uhv sqldeveloper-<Build Number>.noarch.rpm
````
*Note* Replace the *<Build Number>* above with the file name you downloaded. For example

````
sqldeveloper-19.4.0.354.1759-19.4.0-354.1759.noarch.rpm
````
![./images/rpm_install_sqldeveloper.png]()

10. Start SQL developer
As the *opc* user in a terminal window enter:
````
<copy>
/usr/local/bin/sqldeveloper
</copy>
````
![./images/start_sqldeveloper.png]()

11. The first time you start SQL Developer you will have to supply the path to the JDK installed on your Compute Instance.

This will be similar to:
````
/usr/java/jdk1.8.0_231-amd64/
````
Validate the actual path to the JDK on your instance by following the example shown here:
![./images/javac_path.png]()

````
<copy>
which javac
ls -al `which javac`
ls -al /etc/alternatives/javac
</copy>
````
or if you know how to read the output for the *namei* command:
````
<copy>
namei `which javac`
</copy>
````
which will show similar to:
````
[opc@dbroadshow-0-vm-troy ~]$ namei `which javac`
f: /usr/bin/javac
 d /
 d usr
 d bin
 l javac -> /etc/alternatives/javac
   d /
   d etc
   d alternatives
   l javac -> /usr/java/jdk1.8.0_231-amd64/bin/javac
     d /
     d usr
     d java
     d jdk1.8.0_231-amd64
     d bin
     - javac
````
## Conclusion
SQL Developer should now be running on your Compute instance

![./images/sqldeveloper_run.png]()



## Acknowledgements

- **Author** - Troy Anthony, DB Product Management
- **Last Updated By/Date** - Troy Anthony, May 21 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.

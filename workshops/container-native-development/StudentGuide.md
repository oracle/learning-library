
![](images/studentguide/Picture-Title.png)  
Update: January 28, 2017

## Student Guide

This Student Guide will provide you with the instructions nessesary to install the Client Tools used during this workshop. This Workshop will allow you to gain exposure to the Oracle Developer Cloud Service, the Oracle Application Container Cloud Service, and open source products such as Eclipse, Maven, Git, and Brackets.

## Client Enviroment Options

Your client enviroment **must be configured prior** to attempting the Hands on Workshop, or you will not be able to complete the Workshop labs.

You have two options for configuring your workshop client environment.

- ***Option 1***: You can install Virtual Box and download and run a pre-configured **Virtual Box Image**.
    - Refer to the ***Virtual Box Client Installation*** section of this document to use this option
    - **This option is best**, if you don't want to worry about installing and configuring multiple Open Source Software tools on your laptop.
- ***Option 2***: You can **install and configure** Docker, Git, Kubectl, Fn, and Helm on your laptop.
    - Instructions will be provided in the lab guides for each tool.
    - **This option is best** if you want to install and configure the opensource software on your laptop, or your corporate standards will not let you install a hypervisor, or your laptop's resources are not adequate to run virtual images.

# Virtual Box Client Installation

As an alternative to installing Eclipse, Brackets and Git on your laptop, you can follow these steps to download a Virtual Box image that will contain all those products pre-integrated together.

### Hardware Requirements

- You will need a machine capable of running the wokrshop image within Oracle Virtual Box (MAC or PC / Minumum of 50GB of free storage / 8GB RAM)

- You will need full Administrator privileges on your machines, and in some cases will need to set Hardware Virtualization in the BIOS.

    - Hardware Virtualization needs to be enabled in the BIOS to properly run Virtual Box.  If you getting virtualization errors, reboot into the BIOS and make sure that the setting to enable Hardware Virtualization is enabled.

- The latest version of Virtual Box should be installed and tested prior to the workhop.

### Copy OVA file

**Note**: you will download all 6 zip files. You can then use software such as winzip or 7zip to automatically unzip all 6 files into a single *.ova file that can be imported into virtual box.

- [Download](https://www.virtualbox.org/wiki/Downloads) and install Virtual box

- Download this workshops [Virtual box OVA zip files](https://publicdocs-corp.documents.us2.oraclecloud.com/documents/link/LFF42D5B385ADB4324B055CBF6C3FF17C1177E4725F3/folder/FA853951DE14FED12E559568F6C3FF17C1177E4725F3/_VM), and unzip.

### Unzip and import OVA File

- Startup **Oracle Virtual Box**

    ![](images/studentguide/Picture22.png)

- From top left menu select **File -> Import Appliance**

    ![](images/studentguide/Picture23.png)

- Click on **browse** icon to select file to import.

- Navigate to the unzipped OVA file, and Click **Open**

    ![](images/studentguide/Picture24.png)

- Once the File is selected click **Next** to continue.

    ![](images/studentguide/Picture25.png)

- Keep all the defaults and click **Import**

    ![](images/studentguide/Picture26.png)

- Wait for import to complete. The time required to import will vary depending on the speed of your hard disk.

    ![](images/studentguide/Picture27.png)

### Start Virtual Box Image

- After completion of the import, you should see the Oracle Public Cloud image in a Powered Off state. The default settings will work, but if you are familiar with Virtual Box, you are welcome to change any of the settings.

    ![](images/studentguide/Picture28.png)

- With the **Oracle Public Cloud** selected, click **Start**.

    ![](images/studentguide/Picture29.png)

- After a few minutes you will have a running image that will be used for all of the labs.

    ![](images/studentguide/Picture30.png)

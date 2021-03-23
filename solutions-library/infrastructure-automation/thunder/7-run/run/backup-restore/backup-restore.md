# Backup and restore

## Introduction
This solution will backup and restore boot and block volumes in OCI.

## Python scripts
Prerequisites:
  * Install Python3.6 -> sudo yum install python36 -y
  * Install setup tools -> sudo yum install python36-setuptools
  * Install pip -> sudo python3.6 -m easy_install pip
  * Install oci with pip -> sudo python3.6 -m pip install oci

You will have to generate a config file for oci in **/home/user/.oci/config**. If you are running the code as root, the path will be: **/root/.oci/config**

The contents of this file should be:
```
[DEFAULT]
user=ocid1.user.oc1..aaaaaaaav6zc6gd6attdvesbaqj2klp2mribm4rfacbstzk7sag6yhmzetqa
fingerprint=d7:07:3f:b6:f6:f1:ce:d3:0e:fd:24:e7:20:f0:3f:6a
key_file=/root/.oci/oci_api_key.pem
tenancy=ocid1.tenancy.oc1..aaaaaaaaksusyefovxt64bsovu523r5ez6qz25pcnqjw2a243qjmft5n7drq
region=us-ashburn-1
```

## Backup and Restore

### Backup
Based on a compartment that you would pass to the script and the region from the config file (you can also pass this one to the script in order to overwrite the config value), volume groups will be created for each of the instances in that compartment.
Based on those volume groups, volume group backups are getting created at every run. If the volume groups exist from a prior run, the script won't recreate them, but new backups will be created.
The script has also the ability of deleting old volume groups older than x days, where x is an argument you will give to the script.

Go to thunder -> examples -> run -> backup-restore
Examples of running the code:
```

# Display help
$ python3.6 backup.py --help
or
$ python3.6 backup.py -h

# Creating Volume Groups and Volume Group Backups (with region from config file)
$ python3.6 backup.py -compartment comp_name

# Creating Volume Groups and Volume Group Backups (with region that overwrites the value from the config file)
$ python3.6 backup.py -compartment comp_name -region us-ashburn-1

# Deleting Volume Group Backups older than 10 days (with region from config file)
$ python3.6 backup.py -compartment comp_name -delete_volume_group_backups -delete_days 10

# Deleting Volume Group Backups older than 10 days (with region that overwrites the value from the config file)
$ python3.6 backup.py -compartment comp_name -delete_volume_group_backups -delete_days 10


```

### Restore

**Restore an entire volume group**
* Go to the OCI Console and login.
* [OPTIONAL] From the list of services select **Block Storage -> Volume Groups** in order to view the created Volume Groups
* From the list of services select **Block Storage -> Volume Group Backups** in order to view the Volume Group Backup (you will notice that all volume group backups for an instance have as a display name the name of the instance and the date when the volume group backup was created)
* See what is the volume group backup which you want to restore (don't click on it) and in the right, there will be an option icon (3 dots placed vertically) and select **Create Volume Group** --> this option will restore all the block and boot volumes from the volume group backup

**Restore one boot/block volume**
* Go to the OCI Console and login.
* [OPTIONAL] From the list of services select **Block Storage -> Volume Groups** in order to view the created Volume Groups
* From the list of services select **Block Storage -> Volume Group Backups** in order to view the Volume Group Backup (you will notice that all volume group backups for an instance have as a display name the name of the instance and the date when the volume group backup was created)
* See what is the volume group backup which you want to restore and click on it
* Select from left boot or block volumes (depending on what you want to restore)
* In the right, there will be an option icon (3 dots placed veritcally) and select **Create Block Volume / Create Boot Volume (depending on the option you selected before)** --> this option will restore one block/boot volume

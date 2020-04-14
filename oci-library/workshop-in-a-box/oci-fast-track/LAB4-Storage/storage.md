## Lab 4. Storage Cloud Services
**Block Storage**
Objectives
- Create and assign Block Storage volumes to Compute Instances
- Configure backup options


**Creating Block Storage Volumes**
You can create block volumes through the “Block Storage” interface. To access it: From main menu, choose "Block Storage", then “Block Volume”.

![](images/cria_block.png)

Block Volume creation process is a very straight forward process, you just need to hit **“Create Block Volume”**, and fill the requested information:

**Compartment_id:** Choose your own created compartment

**Name:** Name for this disk volume

**Availability Domain:** Choose the AD to store this disk volume

**Size:** Disk size, from 50 GB to 32 TB

**Backup Policy:** From none (No backup Policy) to Silver, Bronze and Gold (More on backup later)

![](images/cria_block_02.png)

After setup, OCI will begin provisioning. Provision time depends on the volume size. In our example (50 GB), it should take no more than 30 seconds:
![](images/block_prov.png)

## Connecting Block Volumes to Compute Instance
To connect Block Volumes to compute instances, you need to access the “Compute Instance” home screen, and from the VM’s detail page, hit **“Attach Block Volume”**.


![](images/attach.png)

On the Block Volume field, locate the disk you just created, and choose the attach method (ISCSI or paravirtualized)
![](images/attach_02.png)

Once disk is properly attached, we can mount it on Compute Instance

To ease disk attachment process, Oracle Cloud Infrastructure provides the necessary commands to detect the new disk from the VM. On the right side of the disk information, you’ll find a three dots menu. 

![](images/attach_03.png)

If you choose the “iSCSI Commands & Information”, you’ll get the necessary commands to detect the recently created disk:
![](images/attach_04.png)

All you need to do is copy the commands, and execute it on the Linux server. 
After disk detection, you need to format and mount the new disk:
1st – Detect the new device with “fdisk -l” command, you’ll note the disk : /dev/sdb
2nd – Format the disk wih “mkfs /dev/sdb”
3rd – Mount he filesystem

![](images/attach_05.png)
![](images/attach_06.png)

## Testing Block Volume performance
According to our documentation, Block Volume’s performance may vary from 3.000 IOPS to 25.000 IOPS, according to disk size. In the next test, we’re going to validate the true performance delivered by the provisioned Block Volume.

**Step 1** Test the true performance of the already provisioned Block Volume (/dev/sdb):  

1 – Install FIO utility on the recently created Linux Compute instance: (as ROOT user, issue the command : “yum install fio”
![](images/fio.png)
![](images/fio_02.png)

2 – Run FIO utility against the new disk:
sudo fio --filename=/dev/sdb --direct=1 --rw=randread --bs=4k \
--ioengine=libaio --iodepth=256 --runtime=30 --numjobs=4 --time_based \
--group_reporting --name=iops-test-job --eta-newline=1 --readonly

![](images/fio_03.png)

## Setting Backup Policies for Block Storage

**Objectives**

- Set Backup Policies: On Oracle Cloud Infrastructure, Block Volume (including boot volumes), and compute node backups are independent. Backup policies can be set on the Block Storage home page (Main Menu > Block Storage > Block Volumes) 

![](images/backup.png)

Backup options can be easily accessed from the “fast menu” (three dots on the right), option  “Assign Backup Policy”

![](images/bkp_type.png)

Where you can choose the most appropriate backup policy for your data.


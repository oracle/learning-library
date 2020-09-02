# Start/Stop/Reboot instances

## Introduction
This solution will start/stop/reboot instances

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

## Stop/Start Instances
Based on a compartment that you would pass to the script and the region from the config file (you can also pass this one to the script in order to overwrite the config value), all the instances from that compartment and region will receive a reboot command (STOP/START).

Go to thunder -> examples -> run -> start-stop

Examples of running the code:
```
# Display help
$ python3.6 start_stop.py --help
or
$ python3.6 start_stop.py -h

# Rebooting all instances from a compartment (region from config file)
$ python3.6 start_stop.py -compartment comp_name -action REBOOT

# Starting all instances from a compartment (region from config file)
$ python3.6 start_stop.py -compartment comp_name -action START

# Stopping all instances from a compartment (region from config file)
$ python3.6 start_stop.py -compartment comp_name -action STOP

# Rebooting one instance from a compartment (region from config file)
$ python3.6 start_stop.py -compartment comp_name -action REBOOT -instances_names uni1

# Rebooting all instances from a compartment (region specified as argumnet)
$ python3.6 start_stop.py -compartment comp_name -region us-ashburn-1 -action REBOOT
 
```

## Known issues
**At the moment, there are no known issues**


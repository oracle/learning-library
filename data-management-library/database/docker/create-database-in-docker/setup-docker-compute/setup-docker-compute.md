# Set up Docker on an Oracle Cloud Compute Instance
## Before You Begin

This lab walks you through the steps to set up Docker on Oracle Linux 7.7 running on an Oracle Cloud compute instance.

### Background
Oracle Cloud Compute makes it easy to create a Linux environment in the cloud, and creates a platform for installing and setting up a Docker container.

### What Do You Need?

* An Oracle Cloud paid account or free trial. To sign up for a trial account with $300 in credits for 30 days, click [here](http://oracle.com/cloud/free)
* An Oracle Cloud compute instance's Public IP Address
* SSH keys

## **STEP 1**: Set up the Docker environment

  Docker is shipped as addon with Oracle Linux 7 UEK4. On Oracle Cloud compute instances, the `addons yum` repository is now enabled by default, so you only need to install the docker-engine package as root.

1. In a terminal window, navigate to the folder where you created the SSH keys. Connect to your compute instance using `ssh`, and the public IP address of your compute instance:

     ```
     $ <copy>ssh -i ./myOracleCloudKey opc@</copy>123.123.123.123
     The authenticity of host '123.123.123.123 (123.123.123.123)' can't be established.
     ECDSA key fingerprint is SHA256:XzZBYaYn0amV0TkzrHpaemIROcEaoSxxLmFeePWHU9I.
     Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
     Warning: Permanently added '123.123.123.123' (ECDSA) to the list of known hosts.
     Enter passphrase for key './myOracleCloudKey':
     [opc@oraclelinux77 ~]$
     ```

2. Switch to the root user:

    ```
    [opc@oraclelinux77 ~]$ <copy>sudo su -</copy>
    [root@oraclelinux77 ~]#
    ```

3. Install the Docker engine, enter **y** when prompted:

    ```
    [root@oraclelinux77 ~]# <copy>yum install docker-engine</copy>
    Loaded plugins: langpacks, ulninfo
    ol7_UEKR5                                                                   | 2.8 kB  00:00:00
    ol7_addons                                                                  | 2.8 kB  00:00:00
    ol7_developer                                                               | 2.8 kB  00:00:00
    ol7_developer_EPEL                                                          | 3.4 kB  00:00:00
    ol7_ksplice                                                                 | 2.2 kB  00:00:00
    ol7_latest                                                                  | 2.7 kB  00:00:00
    ol7_oci_included                                                            | 2.9 kB  00:00:00
    ol7_optional_latest                                                         | 2.2 kB  00:00:00
    ol7_software_collections
    ...
    Total download size: 88 M
    Installed size: 372 M
    Is this ok [y/d/N]: y
    ...
    Dependency Installed:
    container-selinux.noarch 2:2.107-3.el7     containerd.x86_64 0:1.2.0-1.0.5.el7  criu.x86_64 0:3.12-2.el7
    docker-cli.x86_64 0:19.03.1.ol-1.0.0.el7   libnet.x86_64 0:1.1.6-7.el7          protobuf-c.x86_64 0:1.0.2-3.el7
    runc.x86_64 0:1.0.0-65.rc8.el7

    Complete!
    [root@oraclelinux77 ~]#
    ```

  Docker is now installed on the compute instance!

## **STEP 2**: Enable a non-root user

Enable a non-root user to communicate with the Docker engine. When Docker was installed, a new Unix group docker was created along with it. To allow a non-root user (for example, `opc`) to communicate with the Docker daemon directly, you add the non-root user to the docker group.

1. Determine which groups `opc` belongs to:

    ```
    [root@oraclelinux77 ~]# <copy>id opc</copy>
    uid=1000(opc) gid=1000(opc) groups=1000(opc),4(adm),10(wheel),190(systemd-journal)
    [root@oraclelinux77 ~]#
    ```

2. Add `opc` to the `docker` group:

    ```
    [root@oraclelinux77 ~]# <copy>usermod -a -G docker opc</copy>
    [root@oraclelinux77 ~]#
    ```

3. Check that `opc` is now part of the `docker` group:

    ```
    [root@oraclelinux77 ~]# <copy>id opc</copy>
    uid=1000(opc) gid=1000(opc) groups=1000(opc),4(adm),10(wheel),190(systemd-journal),992(docker)
    [root@oraclelinux77 ~]#
    ```

## **STEP 3**: Start Docker

1. Start the Docker service.

    ```
    [root@oraclelinux77 ~]# <copy>systemctl start docker</copy>
    [root@oraclelinux77 ~]#
    ```

2. Enable the Docker service.

    ```
    [root@oraclelinux77 ~]# <copy>systemctl enable docker</copy>
    Created symlink from /etc/systemd/system/multi-user.target.wants/docker.service to /usr/lib/systemd/system/docker.service.
    [root@oraclelinux77 ~]#
    ```

3. Check the status.

    ```
    [root@oraclelinux77 ~]# <copy>systemctl status docker</copy>
    ● docker.service - Docker Application Container Engine
       Loaded: loaded (/usr/lib/systemd/system/docker.service; enabled; vendor preset: disabled)
       Active: active (running) since Tue 2020-04-07 18:21:26 GMT; 21s ago
         Docs: https://docs.docker.com
     Main PID: 11677 (dockerd)
       CGroup: /system.slice/docker.service
               └─11677 /usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock
    ...
    Apr 07 18:21:26 oraclelinux77 systemd[1]: Started Docker Application Container Engine.
    Hint: Some lines were ellipsized, use -l to show in full.
    [root@oraclelinux77 ~]#
    ```

## **STEP 4**: Connect to Docker with the non-root user

1. Open a new terminal window, navigate to the folder where you created the SSH keys. Connect again using SSH:

    ```
    <copy>ssh -i ./myOracleCloudKey opc@</copy>123.123.123.123
    Enter passphrase for key './myOracleCloudKey':
    Last login: Tue Apr  7 18:15:16 2020 from pool-108-26-202-194.bstnma.fios.verizon.net
    [opc@oraclelinux77 ~]$
    ```
2. Check that Docker is configured to allow non-root access:

    ```
    [opc@oraclelinux77 ~]$ <copy>docker run hello-world</copy>
    Unable to find image 'hello-world:latest' locally
    Trying to pull repository docker.io/library/hello-world ...
    latest: Pulling from docker.io/library/hello-world
    1b930d010525: Pull complete
    Digest: sha256:f9dfddf63636d84ef479d645ab5885156ae030f611a56f3a7ac7f2fdd86d7e4e
    Status: Downloaded newer image for hello-world:latest

    Hello from Docker!
    This message shows that your installation appears to be working correctly.

    ...

    [opc@oraclelinux77 ~]$
    ```

  You may now *proceed to the next lab*.

## Acknowledgements
* **Author** - Gerald Venzl, Master Product Manager, Database Development
* **Adapted for Cloud by** -  Tom McGinn, Learning Architect, Database User Assistance
* **Last Updated By/Date** - Tom McGinn, March 2020
* **Contributor** - Arabella Yao, Product Manager Intern, Database Management, June 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section. 

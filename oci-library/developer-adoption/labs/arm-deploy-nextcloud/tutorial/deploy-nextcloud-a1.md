## Deploy Nextcloud on Ampere A1 

Now you can run Nextcloud on the Ampere A1 compute platform as a container deployment. You will also use the new container tools such as Podman,  included in Oracle Linux 8. Podman provides a lightweight utility to run and manage Open Container Initiative (OCI) compatible containers. A Podman deployment can re-use existing container images.
Podman does not require a running daemon and enables containers to start and run without root permissions. To learn more about Podman on Oracle Linux, visit the [official documentation](https://docs.oracle.com/en/operating-systems/oracle-linux/podman/index.html)

### Install the Container Tools

Once the instance has been created with Oracle Linux 8.x, we can install the `container-tools` package to prepare our instance with the required tools to deploy containerized workloads.  

1. Login to the instance using SSH. Use the key you either generated or provided during the instance creation step. The default username for instances running on the Oracle Linux operating system is `opc`.

1. Install the `container-tools` module that pulls in all the tools required to work with containers.
    ```
    <copy>sudo dnf module install container-tools:ol8</copy>
    ```

    ```
    <copy>sudo dnf install git</copy>
    ```

<!-- 1. Set SELinux to be in permissive mode so that Podman can easily interact with the host.
    
    >**Note**: This setting is not recommended for production use. However, setting up SELinux policies for containers are outside the scope of this tutorial. For details, see the [official documentation](https://docs.oracle.com/en/operating-systems/oracle-linux/podman/index.html).

    ```
    sudo setenforce 0
    ``` -->

### Create a Pod Definition

Podman can manage groups of containers called Pods. Formally, pods are a group of one or more containers sharing the same network, pid and ipc namespaces. This concept was initially introduced by the Kubernetes project, and Podman pods are very similar to [Kubernetes Pods](https://kubernetes.io/docs/concepts/workloads/pods/). 

In many ways a pod behaves like a virtual host on which the services within each container are run. This means that each container can access the services on each other container as if they were running on the same host. Running containers in this way can remove a lot of complexity around networking and can make it easier to limit public exposure of ports that are only intended for use by services within the application itself. 

Pods are a great way to manage related containers, like when an application is made up of multiple containers.  In this tutorial, you shall deploy Nextcloud as a Pod. The containers required for NextCloud are contained inside our Pod, and started and stopped together. The first step in managing our application as a Pod is to create an empty pod definition.

Create a Pod with the command below 

  ```
  $ <copy>podman pod create --hostname nextcloud --name nextcloud --publish 8080:80 --infra-image k8s.gcr.io/pause:3.1</copy>
  ```
    
  1. `podman pod create` - creates a pod.
  2. `--hostname nextcloud` - sets the hostname for the pod as `nextcloud`
  3. `--name nextcloud` - sets the name of the pod as `nextcloud`
  4. `--publish 8080:80` - publish port `80` on the pod to port `8080` on the host.
  
### Define Storage Volumes

Now that the pod is defined, we should define some storage options as well before we populate the Pod with our containers. Containers use writable containers layers by default for all files created inside a container. This means that the files and data created by the processes in a container are not persisted and is lost when the container is removed or terminated. It also makes it hard to share the data across containers. Volumes are the preferred way to persist data created by containers. They can be thought of as storage abstractions for storage locations on the host machine, but  managed independent of the container's lifecycle. They also make it easy to share data between containers by simultaneously mounting them on multiple containers.

Based on Nextcloud recommendations, we use 3 volumes to manage data.
1. The volume named `nextcloud-appdata` will store the main application state for next cloud
1. The volume named `nextcloud-files` will store the files uploaded and created by uses. 
1. The volume named `nextcloud-db` will store the database files for the MySQL database. 
 
    ```
     $ <copy>podman volume create nextcloud-appdata</copy>
     $ <copy>podman volume create nextcloud-files</copy>
     $ <copy>podman volume create nextcloud-db</copy>
    ```

### Run MySQL Database

Now you can start the database for Nextcloud with the volume attached. The database container is started in the pod that has already been created. The database used by Nextcloud is MySQL, and here we are running it as a container in the pod. For a more robust and fully managed deployment, you can replace this container with the OCI MySQL database service. 

The command to start the database is shown below, and each of the options are explained.

  >**Note** : Ensure to provide strong passwords for `MYSQL_PASSWORD` and `MYSQL_ROOT_PASSWORD` variables below.

 ```
 $ <copy>podman run --detach --pod=nextcloud \</copy>
  <copy>--env MYSQL_DATABASE=nextcloud \</copy>
  <copy>--env MYSQL_USER=nextcloud \</copy>
  <copy>--env MYSQL_PASSWORD=NEXTCLOUD_PASSWORD \</copy>
  <copy>--env MYSQL_ROOT_PASSWORD=MYSQL_ROOT_PASSWORD \</copy>
  <copy>--volume nextcloud-db:/var/lib/mysql:Z \</copy>
  <copy>--restart on-failure \</copy>
  <copy>--name nextcloud-db \</copy>
  <copy>mysql/mysql-server:8.0 </copy>
  ```
  1. `podman run` - the run command tells podman to run a command in a container with the given parameters. The command to be run is typically defined in the image itself.
  2. `--detach` - Detached mode: run the container in the background and print the new container ID.
  3. `--pod=nextcloud` - Run container in an existing pod. Here we chose to run the container int he pod we created earlier for Nextcloud
  4. `--env` - Sets arbitrary environment variables. These environment variables can be accessed by the processes running inside the container.
  5. `--volume nextcloud-db:/var/lib/mysql:Z` - mounts the volume named `nextcloud-db` at the location `/var/lib/mysql`, the default location for MySQL data files.  The `Z` option tells Podman to label the content with a private unshared label.
  6. `--restart on-failure` - Restart policy to follow when containers exit. Here the container will be restarted when it fails. A failure is when the process in the container exists with a non-zero exist status.
  7. `--name nextcloud-db` - assigns the name `nextcloud-db` to the container.
  8. `mysql/mysql-server:8.0` - the image to run use for creating the container

Since you are running the container in detached mode, Podman will start it in the background and exit. To see the status of the startup and logs, you can execute the following command. Press `Ctrl+C` to stop following the logs.

```
$ <copy>podman logs -f nextcloud-db</copy>
```


### Deploy Nextcloud

Now you can deploy Nextcloud itself as another container in the same pod.  The parameters are similar to the previous command, and here you are passing in the database connectivity details about the database that Nextcloud should use. 

> **Note**: Ensure that the values for the variables `MYSQL_DATABASE`, `MYSQL_USER` and `MYSQL_PASSWORD` are the same that you provided when you started the database. Ensure you update the values for `NEXTCLOUD_ADMIN_USER` and `NEXTCLOUD_ADMIN_PASSWORD` to your choice.

```
$ <copy>podman run --detach --pod=nextcloud \</copy>
  <copy>--env MYSQL_HOST=127.0.0.1 \</copy>
  <copy>--env MYSQL_DATABASE=nextcloud \</copy>
  <copy>--env MYSQL_USER=nextcloud \</copy>
  <copy>--env MYSQL_PASSWORD=NEXTCLOUD_PASSWORD \</copy>
  <copy>--env NEXTCLOUD_ADMIN_USER=NC_ADMIN \</copy>
  <copy>--env NEXTCLOUD_ADMIN_PASSWORD=NC_PASSWORD \</copy>
  <copy>--env NEXTCLOUD_TRUSTED_DOMAINS=<your public IP> \</copy>
  <copy>--volume nextcloud-appdata:/var/www/html:Z \</copy>
  <copy>--volume nextcloud-files:/var/www/html/data:Z \</copy>
  <copy>--restart on-failure \</copy>
  <copy>--name nextcloud-app \</copy>
  <copy>docker.io/library/nextcloud:21</copy>
```

 1. `--env MYSQL_HOST=127.0.0.1` - Since both the database and the application are in the same pod, the application can access the database container  using `127.0.0.1`, as if they were both running on the same host.
 2. `--env NEXTCLOUD_TRUSTED_DOMAINS=<your public IP> ` - Trusted domains are a security feature used by Nextcloud, and you need to provide the list of every domain at which your Nextcloud can be accessed. In this case, it will be the public IP address of the instance, since that is where we will expect Nextcloud to run.

 To see the startup logs you can use :

  ```
  $<copy>podman logs -f nextcloud-app</copy>
  ```

Once the start up is complete, you can navigate to to `http://<your_public_ip>:8080` to reach your Nextcloud server. Use the values you provided for `NEXTCLOUD_ADMIN_USER` and `NEXTCLOUD_ADMIN_PASSWORD` to login.


## Next Steps

This tutorial covered how you can get started with using Nextcloud on the OCI Arm A1 platform. Nextcloud comes with mobile applications as well that you can use to sync your photos and other documents from your mobile devices to your personal nextcloud server. You can also expand on this deployment to support more users, add more server capacity by scaling the compute and storage used by your deployment. When scaling out, it is recommended that you move out from the containerized deployment of MySQL to the much more robust managed service that OCI provides. It provides automated backups and you can seamlessly deploy your database in a highly available manner. 



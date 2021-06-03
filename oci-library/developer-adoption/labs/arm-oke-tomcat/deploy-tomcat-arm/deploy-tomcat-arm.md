# Seamless deployments to your Kubernetes clusters

You can now deploy containerized workloads to your Arm based kubernetes cluster. Container images are built for specific architectures. Container tools such as *Docker* or *Buildah* provide the methods to manage these images and their deployment seamlessly. In this example, you will deploy Apache Tomcat, the popular Java web container to the kubernetes cluster. The docker runtime will fetch the `arm64v8` image when running on Arm and the `amd64` image when running on x86 architectures. This enables us to create seamlessly portable kubernetes deployment manifests as long as we build the application images for both architectures. 

Start by creating an architecture-neutral deployment manifest. The manifest should not refer to any architecture specific containers, as the container runtime is capable of detecting the correct architecture and pulling the appropriate image. To create the manifest, runs the commend below. It creates a new file named `tomcat.yaml`.

```
cat <<EOF > tomcat.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: tomcat
  labels:
    app: tomcat
spec:
  replicas: 3
  selector:
    matchLabels:
      app: tomcat
  template:
    metadata:
      labels:
        app: tomcat
    spec:
      containers:
        - name: tomcat
          image: tomcat:9
          ports:
            - containerPort: 8080
          volumeMounts:
            - name: app-volume
              mountPath: /usr/local/tomcat/webapps/
      volumes:
        - name: app-volume
          configMap:
            name: app-bundle
---
apiVersion: v1
kind: Service
metadata:
  name: tomcat
  labels:
    app: tomcat
spec:
  ports:
  - port: 80
    name: http
    targetPort: 8080
  selector:
    app: tomcat
  type: LoadBalancer
EOF
```
    
  This manifest contains the following objects and actions :

  - A deployment object with the name `tomcat` and label `app: tomcat`. 
  - The deployment has 3 replicas.
  - The pods in the deployment have a single container - `tomcat:9`. Note that the manifest does not specify the architecture, making it valid across all architectures. Docker will pull the image that supports the appropriate architecture at runtime. 
  - A *Volume* object is created from a *ConfigMap*, and mounted in to the container. This ConfigMap will be created later, and will contain the application.
  - The manifest also contains a Service object, and exposes the deployment over a LoadBalancer. 

1. Download the sample application for Apache Tomcat and create it as a ConfigMap. 
    
	 ```
    wget https://tomcat.apache.org/tomcat-9.0-doc/appdev/sample/sample.war
    kubectl create configmap app-bundle --from-file sample.war
    ```
    > This method of mounting an application using a *ConfigMap* is for convenience only, and should not be used in production applications.

2. Deploy the manifest. This creates the kubernetes objects, including the Deployment and the Service. When creating the deployment the docker runtime will detect its running on teh arm architecture and automatically pick the Arm variant of the Apache Tomcat container. The Java application deployed on the container, is platform neutral and hence the same `.war` file can be deployed across all architectures.
    
      ```
      kubectl apply -f tomcat.yaml
      ```

3. Check your deployment status 
    
      ```
      kubectl get deploy,svc
      ```
    You should see output similar to the following
      ```
      NAME                     READY   UP-TO-DATE   AVAILABLE   AGE
      deployment.apps/tomcat   2/2     2            2           9s

      NAME                 TYPE           CLUSTER-IP      EXTERNAL-IP       PORT(S)        AGE
      service/kubernetes   ClusterIP      10.96.0.1       <none>            443/TCP        3d9h
      service/tomcat       LoadBalancer   10.96.120.212   <pending>   80:32547/TCP         9s
      ```
   This shows that Tomcat has been deployed successfully on our Arm based kubernetes cluster and is serving a Java web application. The deployment manifest we used is not tied to the architecture, and can be used for x86 as well as Arm based clusters. 

4. You can optionally get detailed node level details by running  

      ```
      kubectl describe node <node_name>
      ```
   Detailed information about the node, including the architecture and the pods that are scheduled on that node are displayed.

When the external IP address for the LoadBalancer is available (this could take a couple of minutes) you can visit the deployment by pointing your web browser to `http://<your_loadbalancer_ip_address>/sample`

## Next Steps

1. Explore more workloads you can deploy on your Arm based kubernetes cluster by visiting the docker hub repository of the official `arm64v8` images [here](https://hub.docker.com/u/arm64v8)

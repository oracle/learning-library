# Assign WebLogic pods to nodes

## Introduction

When you create a Managed Server (pod), the Kubernetes scheduler selects a node for the pod to run on. The scheduler ensures that, for each resource type, the sum of the resource requests of the scheduled containers is less than the capacity of the node. Note that although actual memory or CPU resource usage on nodes is very low, the scheduler still refuses to place a pod on a node if the capacity check fails.

However, you can create affinity with a `nodeSelector` to constrain a pod to be able to run only on particular nodes. Generally, such constraints are unnecessary because the scheduler will automatically do a reasonable placement, but there are some circumstances where you may want more control over where a pod lands, such as:

- To ensure that a pod ends up on a machine with an SSD attached to it
- To co-locate pods, from two different services that communicate frequently, in the same availability zone
- To ensure pods end up in different availability zones for better high availability
- To move away (*draining*) all pods from a given node because of maintenance reasons.

In this lab, you will learn how to assign pods to individual Managed Server instances and or the entire domain to particular node or nodes.

Estimated Lab Time: 15 minutes

## **STEP 1**: Assign particular servers to specific nodes

Create affinity by assigning particular servers to specific nodes. To assign pods to nodes, you need to label the desired node with a custom tag. Then, define the `nodeSelector` property in the domain resource definition and set the value of the label you applied on the node. Finally, apply the domain configuration changes.

First, get the node names using `kubectl get node`:
```bash
<copy>kubectl get node</copy>
```
The output should be similar to the following:
```bash
NAME             STATUS    ROLES     AGE       VERSION
130.61.110.174   Ready     node      11d       v1.11.5
130.61.52.240    Ready     node      11d       v1.11.5
130.61.84.41     Ready     node      11d       v1.11.5
```

In the case of OKE, the node name can be the public IP address of the node or the subnet's CIDR block's first IP address. But obviously, a unique string which identifies the node.

Now check the current pod allocation using the detailed pod information:
```bash
<copy>kubectl get pod -n sample-domain1-ns -o wide</copy>
```
The output should be similar to the following:
```bash
NAME                             READY     STATUS    RESTARTS   AGE       IP            NODE             NOMINATED NODE
sample-domain1-admin-server      1/1       Running   0          2m        10.244.2.33   130.61.84.41     <none>
sample-domain1-managed-server1   1/1       Running   0          1m        10.244.1.8    130.61.52.240    <none>
sample-domain1-managed-server2   1/1       Running   0          1m        10.244.0.10   130.61.110.174   <none>
sample-domain1-managed-server3   1/1       Running   0          1m        10.244.2.34   130.61.84.41     <none>
```

As you can see from the result, Kubernetes evenly deployed the 3 Managed Servers to the 3 worker nodes. In this case, we can, for example, evacuate one of the nodes. If you have an empty node scenario, then you can assign 1 Managed Server/pod to 1 node, just adopt the labelling and domain resource definition modification accordingly.

## **STEP 2**: Labelling

Knowing the node names, select one which you want to be empty. In this example, this node will be: `130.61.110.174`

Label the other nodes. The label can be any string, but let's use `wlservers1` and `wlservers2`. Execute the
```bash
<copy>kubectl label nodes <YOUR_NODE_NAME> <LABEL_NAME>=true</copy>
```
command but replace your node name and label properly e.g.:
```bash
$ kubectl label nodes 130.61.52.240 wlservers1=true
node/130.61.52.240 labeled
$ kubectl label nodes 130.61.84.41 wlservers2=true
node/130.61.84.41 labeled
```
## **STEP 3**: Modify the domain resource definition

Open your `domain.yaml` file in text editor and find the `adminServer:` entry and insert a new property where you can define the placement of the Administration Server. The provided `domain.yaml` already contains this part (starting at around line #101); you just need to enable it by removing the `#` (comment sign) at the beginning of the lines:
```yaml
adminServer:
  [...]
  serverPod:
    nodeSelector:
      wlservers2: true
```
Assign 2-2 servers (including the Administration Server) to 1-1 labelled node.
You can double check the syntax in the sample [domain.yaml](../domain.short.v8.yaml) where this part is in a comment.

For the Managed Servers, you have to insert `managedServers:`, which has to be at the same level (indentation) with `adminServer:`. In this property, you need to use the WebLogic Server name to identify the pod. The server name is defined during WebLogic image creation and if you followed this tutorial, it is `managed-serverX`.
```yaml
spec:
  [...]
  managedServers:
  - serverName: managed-server1
    serverPod:
      nodeSelector:
        wlservers1: true
  - serverName: managed-server2
    serverPod:
      nodeSelector:
        wlservers1: true
  - serverName: managed-server3
    serverPod:
      nodeSelector:
        wlservers2: true
  [...]
```
Keep the proper indentation. Save the changes and apply the new domain resource definition.
```bash
<copy>kubectl apply -f ~/domain.yaml</copy>
```
The output should be similar to the following:
```bash
domain.weblogic.oracle/sample-domain1 configured
```
The operator according to the changes will start to relocate servers. Poll the pod information and wait until the expected result:
```bash
<copy>kubectl get po -n sample-domain1-ns -o wide</copy>
```
The output should be similar to the following:
```bash
NAME                             READY     STATUS        RESTARTS   AGE       IP            NODE            NOMINATED NODE
sample-domain1-admin-server      1/1       Running       0          3m        10.244.2.36   130.61.84.41    <none>
sample-domain1-managed-server1   1/1       Running       0          55m       10.244.1.8    130.61.52.240   <none>
sample-domain1-managed-server2   1/1       Running       0          56s       10.244.1.9    130.61.52.240   <none>
sample-domain1-managed-server3   1/1       Running       0          2m        10.244.2.37   130.61.84.41    <none>
```

## **STEP 4**: Delete the node assignment

To delete the node assignment, delete the node's label using the `kubectl label nodes <nodename> <labelname>-` command but replace the node name properly:
```bash
$ kubectl label nodes 130.61.52.240 wlservers1-
node/130.61.52.240 labeled
$ kubectl label nodes 130.61.84.41 wlservers2-
node/130.61.84.41 labeled
```
Delete or comment out the (`nodeSelector`) entries you added for the node assignment in your `domain.yaml` and apply:
```bash
<copy>kubectl apply -f ~/domain.yaml</copy>
```
The output should be similar to the following:
```bash
domain.weblogic.oracle/sample-domain1 configured
```
The pod reallocation/restart will happen based on the scheduler decision.

## Acknowledgements
* **Author** - Maciej Gruszka, Peter Nagy, September 2020
* **Last Updated By/Date**

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.

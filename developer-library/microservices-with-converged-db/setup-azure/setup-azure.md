

Prerequisites
1. Azure subscription
2. Azure CLI 
3. kubectl


0. Create  resource group and aks cluster

    az group create --name <resource-group-name> --location <location-name>
    az aks create --resource-group <resource-group-name> --name <aks-cluster-name> --node-count 2 --node-vm-size Standard_DS2_v2 --kubernetes-version 1.18.14
    
  Once aks cluster is created, configure your local KUBECONFIG environment variable to use the k8s configuration of the aks cluster. This is done by the following command automatically:
    az aks get-credentials --resource-group <resource-group-name> --name <aks-cluster-name>
    kubectl get nodes

1. Create Azure Resource Group
    az group create --name <resource-group-name> --location <location-name>

2. Create aks cluster (Azure Kubernetes Service Cluster)
    az aks create --resource-group <resource-group-name> --name <aks-cluster-name> --node-count 2 --node-vm-size Standard_DS2_v2 --kubernetes-version 1.18.14 

3. Merge aks cluster config with your KUBECONFIG
    az aks get-credentials --resource-group <resource-group-name> --name <aks-cluster-name>
    
4. Setup interconnect   oracle blog and https://medium.com/@j.jamalarif/how-to-setup-the-interconnect-between-oracle-cloud-infrastructure-and-microsoft-azure-da359233e5e9
    On OCI...
    - Step 1: Create a VCN in Oracle Cloud Infrastructure
    - Step 2: Create a Dynamic Routing Gateway in Oracle Cloud Infrastructure
    - Step 3: Attach the DRG to the VCN
    - Step 4: Create a VM in Oracle Cloud Infrastructure
    On Azure...
    - Step 1: Create a VNet in Azure
    - Step 2: Create a Virtual Network Gateway in Azure
    - Step 3: Create a VM in Azure
    Setup Interconnect...
    - Step 1: Set Up Azure ExpressRoute
    - Step 2: Set Up Oracle Cloud Infrastructure FastConnect
    - Step 3: Link the VNet to Azure ExpressRoute
    - Step 4: Associate a Network Security Group (NSG) and Route Table with the Azure VNet
    - Step 5: Configure VCN Security Lists and Route Table
    - Step 6: Test the Connection
    - 
    
5. Deploy Verrazzano 


# :notebook: Interesting information for the HOLs. #

:computer: OVA VM machine [link](https://objectstorage.eu-frankfurt-1.oraclecloud.com/p/smpE_ekRW19rd4H31B4fPspIqXxRm-iSuaQ9kOc8_K8/n/wedoinfra/b/DevCS_Clone_WedoDevops/o/HOL5967-OOW2019%20OVAHOL5967-OOW2019.ova "ova hol")
- oci version 2.9.1
- kubectl version 1.17.0
- fn cli 0.5.92

:computer: marketplace developer VM machine [link](https://github.com/oraclespainpresales/GigisPizzaHOL/blob/master/devmachine-marketplace/devmachine-marketplaceor.md)

## Python upgrade to python 3 ##
```sh
sudo yum install python3
```
## OCICLI upgrade to latest version ##
```sh
bash -c "$(curl -L https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh)"
```
## Install Kubectl with curl ##
1. Download last version of kubectl
```sh
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
```
2. Change permission of the binary file
```sh
chmod +x ./kubectl
```
3. Move binary to you PATH
```sh
sudo mv ./kubectl /usr/local/bin/kubectl
```
## OCI SETUP repair permissions error ##
```sh
oci setup repair-file-permissions –file /home/holouser/.oci/private.pem
```
## Fn Cli install ##
```sh
curl -LSs https://raw.githubusercontent.com/fnproject/cli/master/install | sh
```
## Create OCIR Secret. ##
```sh
kubectl create secret docker-registry ocirsecret --docker-server=<region>.ocir.io --docker-username='<tenant_storage_namespace>/<your_user>' --docker-password='<your_auth_token>' --docker-email='<your_email>'
```
Example
```sh
kubectl create secret docker-registry ocirsecret --docker-server=fra.ocir.io --docker-username='wedoinfra/wedo.devops' --docker-password='xxxxxxxxxxxxx' --docker-email='test.email@oracle.com'
```
## Oracle Cloud Regions: ##
https://docs.cloud.oracle.com/iaas/Content/General/Concepts/regions.htm

## Oracle OCIR Regions: ##
https://docs.cloud.oracle.com/iaas/Content/Registry/Concepts/registryprerequisites.htm#Availab

## OKE in Rancher UI ##

https://medium.com/swlh/oke-clusters-from-rancher-2-0-409131ad1293

variable "region" {}
variable "compartment_ocid" {}
variable "subnet_ocid" {}
variable "target_db_admin_pw" {}
variable "target_db_ip" {}
variable "target_db_srv_name" {}
variable "target_db_name" {}
variable "ZoneName" {}
variable "pdb_name" {}

variable availability_domain {
  type        = string
  description = "the availability downmain to provision the management instance in"
}

variable "tenancy_ocid" {
  type        = string
  description = "tenancy ocid"
}

variable compartment_id {
  type        = string
  description = "ocid of the compartment to provision the resources in"
}

variable display_name {
  type        = string
  description = "name of instance"
}

variable hostname_label {
  type        = string
  description = "hostname label"
}

variable subnet_id {
  type        = string
  description = "ocid of the subnet to provision the management instance in"
}

variable shape {
  type        = string
  description = "oci shape for the instance"
  default     = "VM.Standard2.2"
}

variable "BootStrapFile" {
  default = "./userdata/bootstrap.sh"
}

variable source_id {
  type        = string
  description = "ocid of the image to provistion the management instance with"
}

variable ssh_private_key {
  type        = string
  description = "the private ssh key to provision on the bastion host for access to remote instances"
}

variable ssh_public_key {
  type        = string
  description = "the public ssh key to provision on the bastion host for access to remote instances"
}

variable "HostUserName" {
  default = "opc"
}

# Web Server Flag:
#    0 => Jetty in ords
#    1 => Apach Tomcat
variable "web_srv" {
  default = "0"
}

# FQDN Access Flag:
#    0 => FQDN access w/ CA cert SSL enabled (ZoneName required)
#    1 => IP address access
variable "Secure_FQDN_access" {
  default = "1"
}

### Compute ####
variable "ComputeDisplayName" {
  default = "ORDS-Compute"
}

variable "InstanceName" {
  default = "ords-comp" // hostname
}

variable "InstanceShape" {
  default = "VM.Standard2.1"
}

variable "InstanceOS" {
  default = "Oracle Linux"
}

variable "InstanceOSVersion" {
  default = "7.6"
}

variable "com_port" {
  default = "8443"
}

variable "URL_ORDS_file" {
  default = "https://objectstorage.<region>.oraclecloud.com/p/XXXXX/o/ords.war"
}

# Optional: required only for using Tomcat
variable "URL_tomcat_file" {
  default = "https://objectstorage.<region>.oraclecloud.com/p/XXXXX/o/apache-tomcat-8.5.NN.tar.gz"
}

# Optional: required only when configuring APEX
variable "URL_APEX_file" {
  default = "https://objectstorage.<region>.oraclecloud.com/p/XXXXX/o/apex_NN.zip"
}

# APEX Install Mode Flag:
# Optional: required only when configuring APEX
#    0 => Full Development mode
#    1 => Runtime mode
variable "APEX_install_mode" {
  default = "0"
}

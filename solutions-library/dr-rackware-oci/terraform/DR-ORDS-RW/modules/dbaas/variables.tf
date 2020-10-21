variable display_name {
  type        = string
  description = "name of database system"
}

variable compartment_id {
  type        = string
  description = "ocid of the compartment to provision the resources in"
}

variable subnet_id {
  type        = string
  description = "subnet id for the database resource"
}

variable ssh_public_keys {
  type        = string
  description = "ssh public key"
}

variable availability_domain {
  type        = string
  description = "the availability downmain to provision the database instance in"
}

variable "db_system_shape" {
  type        = string
  description = "shape of database instance"
}

variable "db_edition" {
  type        = string
  description = "Oracle Database Edition that applies to all the databases on the DB system."
  default     = "ENTERPRISE_EDITION_EXTREME_PERFORMANCE"
}

variable "db_admin_password" {
  type        = string
  description = "password for SYS, SYSTEM, PDB Admin and TDE Wallet."
}

variable "db_name" {
  type        = string
  description = "database display name"
  default     = "drdb"
}

variable "db_version" {
  type        = string
  description = "A valid Oracle Database version."
  default     = "19.0.0.0"
}

variable "db_home_display_name" {
  type        = string
  description = "The user-friendly name for the DB system."
  default     = "DRDBHome"
}

variable "db_disk_redundancy" {
  type        = string
  description = "The type of redundancy configured for the DB system."
  default     = "NORMAL"
}

variable "db_backup_enabled" {
  type        = string
  description = "if set to true configures automatic backup"
  default     = "false"
}

variable "sparse_diskgroup" {
  type        = string
  description = "Sparse Diskgroup is configured for Exadata dbsystem. If False, Sparse diskgroup is not configured."
  default     = true
}

variable "db_system_display_name" {
  type        = string
  description = "The user-friendly name for the DB system."
  default     = "DRDBSystem"
}

variable "hostname" {
  type        = string
  description = "The hostname for the DB system."
  default     = "drdb"
}

variable "n_character_set" {
  type        = string
  description = "The character set for the database."
  default     = "AL16UTF16"
}

variable "character_set" {
  type        = string
  description = "The national character set for the database."
  default     = "AL32UTF8"
}

variable "db_workload" {
  type        = string
  description = "The database workload type."
  default     = "OLTP"
}

variable "pdb_name" {
  type        = string
  description = "The name of the pluggable database."
  default     = "drpdb"
}

variable "data_storage_size_in_gb" {
  type        = string
  description = "The data storage size, in gigabytes, that is currently available to the DB system. Applies only for virtual machine DB systems."
  default     = "512"
}

variable "license_model" {
  type        = string
  description = "The Oracle license model that applies to all the databases on the DB system. The default is LICENSE_INCLUDED."
  default     = "LICENSE_INCLUDED"
}

variable ping_all_id {
  type        = string
  description = "network security group id"
}

variable "node_count" {
  type        = string
  description = "The number of nodes in the DB system. For RAC DB systems, the value is greater than 1."
  default     = "1"
}

variable "remote_subnet_id" {
  type        = string
  description = "The database subnet id for peered database in remote region"
}

variable "remote_nsg_ids" {
  type        = string
  description = "network security group id"
}

variable "remote_availability_domain" {
  type        = string
  description = "availability domain for the database in remote region"
}

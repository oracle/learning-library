provider "oci" {
  tenancy_ocid     = var.provider_oci.tenancy
  user_ocid        = var.provider_oci.user_id
  fingerprint      = var.provider_oci.fingerprint
  private_key_path = var.provider_oci.key_file_path
  region           = var.provider_oci.region
}

module "oke" {
  source           = "../../../modules/containers"
  compartment_ids  = var.compartment_ids
  cluster_params   = var.cluster_params
  nodepools_params = var.nodepools_params
  linux_images     = var.linux_images
  region           = var.provider_oci.region
  vcn_ids          = var.vcn_ids
  subnet_ids       = var.subnet_ids
}
// Copyright (c) 2019, Oracle and/or its affiliates. All rights reserved.
// Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.

# Home region
data "oci_identity_tenancy" "tenancy" {
  tenancy_id = var.tenancy_ocid
}

# Availability Domains for Primary Region
data oci_identity_availability_domains ADs {
  compartment_id = var.tenancy_ocid
}

# Availability Domains for Standby Region
data oci_identity_availability_domains DR_ADs {
  provider       = oci.dr
  compartment_id = var.tenancy_ocid
}

# Oracle Linux VM Image for Primary Region
data oci_core_images oraclelinux {
  compartment_id = var.compartment_ocid

  operating_system         = "Oracle Linux"
  operating_system_version = "7.8"

  # exclude GPU specific images
  filter {
    name   = "display_name"
    values = ["^Oracle-Linux-7.8-([\\.0-9]+)-([\\.0-9-]+)$"]
    regex  = true
  }
}

# Oracle Linux VM Image for Standby Region
data oci_core_images DR_oraclelinux {
  provider       = oci.dr
  compartment_id = var.compartment_ocid

  operating_system         = "Oracle Linux"
  operating_system_version = "7.8"

  # exclude GPU specific images
  filter {
    name   = "display_name"
    values = ["^Oracle-Linux-7.8-([\\.0-9]+)-([\\.0-9-]+)$"]
    regex  = true
  }
}

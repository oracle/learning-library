// Copyright (c) 2019, Oracle and/or its affiliates. All rights reserved.
// Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.

### Primary Region provider
provider oci {
  tenancy_ocid = var.tenancy_ocid
  region       = var.region
}

### Standby Region provider
provider oci {
  alias        = "dr"
  tenancy_ocid = var.tenancy_ocid
  region       = var.dr_region
}
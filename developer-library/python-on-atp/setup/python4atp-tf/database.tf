
variable "autonomous_database_cpu_core_count" {
    default = "1"
}

variable "autonomous_database_data_storage_size_in_tbs" {
    default = "1"
}

variable "autonomous_database_db_workload" {
    default = "OLTP"
}

resource "oci_database_autonomous_database" "test_autonomous_database" {
    #Required
    admin_password = "${var.autonomous_database_admin_password}"
    compartment_id = "${oci_identity_compartment.python4dev.id}"
    cpu_core_count = "${var.autonomous_database_cpu_core_count}"
    data_storage_size_in_tbs = "${var.autonomous_database_data_storage_size_in_tbs}"
    db_name = "${var.autonomous_database_db_name}"

    #Optional
    db_workload = "${var.autonomous_database_db_workload}"
    display_name = "${var.autonomous_database_display_name}"
}
resource "oci_objectstorage_bucket" "storage_bucket" {
    #Required
    compartment_id = "${oci_identity_compartment.python4dev.id}"
    name = "${var.bucket_name}"
    namespace = "${var.obj_store_namespace}"
}
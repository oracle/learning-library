
# Gets the partner image listing
data "oci_core_app_catalog_listings" "CloudDevImg_catalog_listings" {
  filter {
    name   = "display_name"
    values = ["Oracle Cloud Developer Image"]
  }
}

data "oci_core_app_catalog_listing_resource_versions" "test_CloudDevImg_catalog_listing_resource_versions" {
    #Required
    listing_id = "${lookup(data.oci_core_app_catalog_listings.CloudDevImg_catalog_listings.app_catalog_listings[0],"listing_id")}"  //The OCID of the listing.
}

variable "use_marketplace_image" {
  default = 1
}


#Get Image Agreement 
resource "oci_core_app_catalog_listing_resource_version_agreement" "mp_image_agreement" {

  listing_id               = "${lookup(data.oci_core_app_catalog_listing_resource_versions.test_CloudDevImg_catalog_listing_resource_versions.app_catalog_listing_resource_versions[0], "listing_id")}"
  listing_resource_version = "${lookup(data.oci_core_app_catalog_listing_resource_versions.test_CloudDevImg_catalog_listing_resource_versions.app_catalog_listing_resource_versions[0], "listing_resource_version")}"
}

#Accept Terms and Subscribe to the image, placing the image in a particular compartment
resource "oci_core_app_catalog_subscription" "mp_image_subscription" {

  compartment_id           = "${oci_identity_compartment.python4dev.id}"
  eula_link                = "${oci_core_app_catalog_listing_resource_version_agreement.mp_image_agreement.eula_link}"
  listing_id               = "${oci_core_app_catalog_listing_resource_version_agreement.mp_image_agreement.listing_id}"
  listing_resource_version = "${oci_core_app_catalog_listing_resource_version_agreement.mp_image_agreement.listing_resource_version}"
  oracle_terms_of_use_link = "${oci_core_app_catalog_listing_resource_version_agreement.mp_image_agreement.oracle_terms_of_use_link}"
  signature                = "${oci_core_app_catalog_listing_resource_version_agreement.mp_image_agreement.signature}"
  time_retrieved           = "${oci_core_app_catalog_listing_resource_version_agreement.mp_image_agreement.time_retrieved}"

  timeouts {
    create = "20m"
  }
}
# Gets the partner image subscription
data "oci_core_app_catalog_subscriptions" "CloudDevImg_catalog_subscriptions" {
  #Required
  compartment_id = "${oci_identity_compartment.python4dev.id}"

  #Optional
  listing_id = "${oci_core_app_catalog_subscription.mp_image_subscription.listing_id}"

  filter {
    name   = "listing_resource_version"
    values = ["${oci_core_app_catalog_subscription.mp_image_subscription.listing_resource_version}"]
  }
}
output "subscriptions" {
  value = ["${data.oci_core_app_catalog_subscriptions.CloudDevImg_catalog_subscriptions.app_catalog_subscriptions}"]
}
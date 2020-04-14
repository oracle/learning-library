locals {
  keys_versions_list = flatten([
    for idxkey in var.key_params : [
      for idxversion in range(1, idxkey.rotation_version + 1) : {
        format("%s-%d", idxkey.display_name, idxversion) = {
          key_name    = idxkey.display_name
          vault_name  = idxkey.vault_name
          key_version = idxversion
        }
      }
    ]
  ])

  keys_versions_map = { for item in local.keys_versions_list :
    keys(item)[0] => values(item)[0]
  }
}

# at destroy -> goes to "prepare for deletion" state
resource "oci_kms_vault" "this" {
  for_each       = var.vault_params
  compartment_id = var.compartment_ids[each.value.compartment_name]
  display_name   = each.value.display_name
  vault_type     = each.value.vault_type # DEFAULT is VIRTUAL / Another one is VIRTUAL_PRIVATE
}

resource "oci_kms_key" "this" {
  for_each       = var.key_params
  compartment_id = var.compartment_ids[each.value.compartment_name]
  display_name   = each.value.display_name
  key_shape {
    algorithm = each.value.key_shape_algorithm
    length    = each.value.key_shape_size_in_bytes
  }
  management_endpoint = oci_kms_vault.this[each.value.vault_name].management_endpoint
}

# rotates key at each apply ? NO
# rotation_version parameter needs to be incremented for rotation execution
resource "oci_kms_key_version" "this" {
  for_each            = local.keys_versions_map
  key_id              = oci_kms_key.this[each.value.key_name].id
  management_endpoint = oci_kms_vault.this[each.value.vault_name].management_endpoint
}

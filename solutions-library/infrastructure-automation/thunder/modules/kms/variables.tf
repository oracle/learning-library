variable "compartment_ids" {
  type = map(string)
}

variable "vault_params" {
  type = map(object({
    compartment_name = string
    display_name     = string
    vault_type       = string
  }))

}

variable "key_params" {
  type = map(object({
    compartment_name        = string
    display_name            = string
    vault_name              = string
    key_shape_algorithm     = string
    key_shape_size_in_bytes = number
    rotation_version        = number
  }))
}

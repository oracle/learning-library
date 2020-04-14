// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.

variable "cert_params" {
  type = map(object({
    certificate_data               = string
    private_key_data               = string
    display_name                   = string
    is_trust_verification_disabled = bool
  }))
}

variable "compartment_ids" {
  type = map(string)
}

variable "uri" {
  type = map(string)
}

variable "waas_policy_params" {
  type = map(object({
    domain             = string
    additional_domains = list(string)
    compartment_name   = string
    uri_name           = string
    display_name       = string
    label              = string
    http_port          = number
    https_port         = number
    # certificate_id                = string
    cipher_group                  = string
    client_address_header         = string
    is_behind_cdn                 = bool
    is_cache_control_respected    = bool
    is_https_enabled              = bool
    is_https_forced               = bool
    is_origin_compression_enabled = bool
    is_response_buffering_enabled = bool
    tls_protocols                 = list(string)

    waf_config = map(object({
      origin = string

      access_rules = map(object({
        action                       = string
        name                         = string
        block_action                 = string
        block_error_page_code        = string
        block_error_page_description = string
        block_error_page_message     = string
        block_response_code          = number
        bypass_challenges            = list(string)
        redirect_response_code       = string
        redirect_url                 = string
        criteria = map(object({
          condition = string
          value     = string
        }))
      }))


      address_rate_limiting = map(object({
        is_enabled                    = bool
        allowed_rate_per_address      = number
        block_response_code           = number
        max_delayed_count_per_address = number
      }))


      caching_rules = map(object({
        action                    = string
        name                      = string
        caching_duration          = string
        client_caching_duration   = string
        is_client_caching_enabled = bool
        key                       = string

        criteria = map(object({
          condition = string
          value     = string
        }))
      }))


      captchas = map(object({
        failure_message               = string
        session_expiration_in_seconds = number
        submit_label                  = string
        title                         = string
        url                           = string
        footer_text                   = string
        header_text                   = string
      }))


      device_fingerprint_challenge = map(object({
        is_enabled                              = bool
        action                                  = string
        action_expiration_in_seconds            = number
        failure_threshold                       = number
        failure_threshold_expiration_in_seconds = number
        max_address_count                       = number
        max_address_count_expiration_in_seconds = number

        challenge_settings = map(object({
          block_action                 = string
          block_error_page_code        = string
          block_error_page_description = string
          block_error_page_message     = string
          block_response_code          = number
          captcha_footer               = string
          captcha_header               = string
          captcha_submit_label         = string
          captcha_title                = string
        }))
      }))


      human_interaction_challenge = map(object({
        is_enabled                              = bool
        action                                  = string
        action_expiration_in_seconds            = number
        failure_threshold                       = number
        failure_threshold_expiration_in_seconds = number
        interaction_threshold                   = number
        recording_period_in_seconds             = number

        challenge_settings = map(object({
          block_action                 = string
          block_error_page_code        = string
          block_error_page_description = string
          block_error_page_message     = string
          block_response_code          = number
          captcha_footer               = string
          captcha_header               = string
          captcha_submit_label         = string
          captcha_title                = string
        }))

        set_http_header = map(object({
          name  = string
          value = string
        }))

      }))


      js_challenge = map(object({
        is_enabled                   = bool
        action                       = string
        action_expiration_in_seconds = number
        failure_threshold            = number

        challenge_settings = map(object({
          block_action                 = string
          block_error_page_code        = string
          block_error_page_description = string
          block_error_page_message     = string
          block_response_code          = number
          captcha_footer               = string
          captcha_header               = string
          captcha_submit_label         = string
          captcha_title                = string
        }))

        set_http_header = map(object({
          name  = string
          value = string
        }))

      }))


      protection_settings = map(object({
        allowed_http_methods               = list(string)
        block_action                       = string
        block_error_page_code              = string
        block_error_page_description       = string
        block_error_page_message           = string
        block_response_code                = number
        is_response_inspected              = bool
        max_argument_count                 = number
        max_name_length_per_argument       = number
        max_response_size_in_ki_b          = number
        max_total_name_length_of_arguments = number
        media_types                        = list(string)
        recommendations_period_in_days     = number
      }))


      whitelists = map(object({
        addresses = list(string)
        name      = string
      }))

    }))
  }))
}

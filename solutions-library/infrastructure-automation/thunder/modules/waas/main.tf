// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.

resource "oci_waas_certificate" "this" {
  for_each                       = var.cert_params
  compartment_id                 = var.compartment_ids[each.value.compartment_name]
  certificate_data               = each.value.certificate_data
  private_key_data               = each.value.private_key_data
  display_name                   = each.value.display_name
  is_trust_verification_disabled = each.value.is_trust_verification_disabled
}


resource "oci_waas_waas_policy" "this" {
  for_each           = var.waas_policy_params
  compartment_id     = var.compartment_ids[each.value.compartment_name]
  domain             = each.value.domain
  additional_domains = each.value.additional_domains
  display_name       = each.value.display_name

  origins {
    uri        = var.uri[each.value.uri_name]
    label      = each.value.label
    http_port  = each.value.http_port
    https_port = each.value.https_port
  }

  policy_config {
    # certificate_id                = oci_waas_certificate.this.id
    cipher_group                  = each.value.cipher_group
    client_address_header         = each.value.client_address_header
    is_behind_cdn                 = each.value.is_behind_cdn
    is_cache_control_respected    = each.value.is_cache_control_respected
    is_https_enabled              = each.value.is_https_enabled
    is_https_forced               = each.value.is_https_forced
    is_origin_compression_enabled = each.value.is_origin_compression_enabled
    is_response_buffering_enabled = each.value.is_response_buffering_enabled
    tls_protocols                 = each.value.tls_protocols
  }


  dynamic "waf_config" {
    iterator = waf_config
    for_each = each.value.waf_config
    content {
      origin = waf_config.value.origin

      dynamic "access_rules" {
        iterator = access_rules
        for_each = waf_config.value.access_rules
        content {
          action                       = access_rules.value.action
          name                         = access_rules.value.name
          block_action                 = access_rules.value.block_action
          block_error_page_code        = access_rules.value.block_error_page_code
          block_error_page_description = access_rules.value.block_error_page_description
          block_error_page_message     = access_rules.value.block_error_page_message
          block_response_code          = access_rules.value.block_response_code
          bypass_challenges            = access_rules.value.bypass_challenges
          redirect_response_code       = access_rules.value.redirect_response_code
          redirect_url                 = access_rules.value.redirect_url

          dynamic "criteria" {
            iterator = criteria
            for_each = access_rules.value.criteria
            content {
              condition = criteria.value.condition
              value     = criteria.value.value
            }
          }
        }
      }


      dynamic "address_rate_limiting" {
        iterator = address_rate_limiting
        for_each = waf_config.value.address_rate_limiting
        content {
          is_enabled                    = address_rate_limiting.value.is_enabled
          allowed_rate_per_address      = address_rate_limiting.value.allowed_rate_per_address
          block_response_code           = address_rate_limiting.value.block_response_code
          max_delayed_count_per_address = address_rate_limiting.value.max_delayed_count_per_address
        }
      }


      dynamic "caching_rules" {
        iterator = caching_rules
        for_each = waf_config.value.caching_rules
        content {
          action                    = caching_rules.value.action
          name                      = caching_rules.value.name
          caching_duration          = caching_rules.value.caching_duration
          client_caching_duration   = caching_rules.value.client_caching_duration
          is_client_caching_enabled = caching_rules.value.is_client_caching_enabled
          key                       = caching_rules.value.key

          dynamic "criteria" {
            iterator = criteria
            for_each = caching_rules.value.criteria
            content {
              condition = criteria.value.condition
              value     = criteria.value.value
            }
          }
        }
      }


      dynamic "captchas" {
        iterator = captchas
        for_each = waf_config.value.captchas
        content {
          failure_message               = captchas.value.failure_message
          session_expiration_in_seconds = captchas.value.session_expiration_in_seconds
          submit_label                  = captchas.value.submit_label
          title                         = captchas.value.title
          url                           = captchas.value.url
          footer_text                   = captchas.value.footer_text
          header_text                   = captchas.value.header_text
        }
      }


      dynamic "device_fingerprint_challenge" {
        iterator = device_fingerprint_challenge
        for_each = waf_config.value.device_fingerprint_challenge
        content {
          is_enabled                              = device_fingerprint_challenge.value.is_enabled
          action                                  = device_fingerprint_challenge.value.action
          action_expiration_in_seconds            = device_fingerprint_challenge.value.action_expiration_in_seconds
          failure_threshold                       = device_fingerprint_challenge.value.failure_threshold
          failure_threshold_expiration_in_seconds = device_fingerprint_challenge.value.failure_threshold_expiration_in_seconds
          max_address_count                       = device_fingerprint_challenge.value.max_address_count
          max_address_count_expiration_in_seconds = device_fingerprint_challenge.value.max_address_count_expiration_in_seconds

          dynamic "challenge_settings" {
            iterator = challenge_settings
            for_each = device_fingerprint_challenge.value.challenge_settings
            content {
              block_action                 = challenge_settings.value.block_action
              block_error_page_code        = challenge_settings.value.block_error_page_code
              block_error_page_description = challenge_settings.value.block_error_page_description
              block_error_page_message     = challenge_settings.value.block_error_page_message
              block_response_code          = challenge_settings.value.block_response_code
              captcha_footer               = challenge_settings.value.captcha_footer
              captcha_header               = challenge_settings.value.captcha_header
              captcha_submit_label         = challenge_settings.value.captcha_submit_label
              captcha_title                = challenge_settings.value.captcha_title
            }
          }
        }
      }


      dynamic "human_interaction_challenge" {
        iterator = human_interaction_challenge
        for_each = waf_config.value.human_interaction_challenge
        content {
          is_enabled                              = human_interaction_challenge.value.is_enabled
          action                                  = human_interaction_challenge.value.action
          action_expiration_in_seconds            = human_interaction_challenge.value.action_expiration_in_seconds
          failure_threshold                       = human_interaction_challenge.value.failure_threshold
          failure_threshold_expiration_in_seconds = human_interaction_challenge.value.failure_threshold_expiration_in_seconds
          interaction_threshold                   = human_interaction_challenge.value.interaction_threshold
          recording_period_in_seconds             = human_interaction_challenge.value.recording_period_in_seconds

          dynamic "challenge_settings" {
            iterator = challenge_settings
            for_each = human_interaction_challenge.value.challenge_settings
            content {
              block_action                 = challenge_settings.value.block_action
              block_error_page_code        = challenge_settings.value.block_error_page_code
              block_error_page_description = challenge_settings.value.block_error_page_description
              block_error_page_message     = challenge_settings.value.block_error_page_message
              block_response_code          = challenge_settings.value.block_response_code
              captcha_footer               = challenge_settings.value.captcha_footer
              captcha_header               = challenge_settings.value.captcha_header
              captcha_submit_label         = challenge_settings.value.captcha_submit_label
              captcha_title                = challenge_settings.value.captcha_title
            }
          }

          dynamic "set_http_header" {
            iterator = set_http_header
            for_each = human_interaction_challenge.value.set_http_header
            content {
              name  = set_http_header.value.name
              value = set_http_header.value.value
            }
          }
        }
      }


      dynamic "js_challenge" {
        iterator = js_challenge
        for_each = waf_config.value.js_challenge
        content {
          is_enabled                   = js_challenge.value.is_enabled
          action                       = js_challenge.value.action
          action_expiration_in_seconds = js_challenge.value.action_expiration_in_seconds
          failure_threshold            = js_challenge.value.failure_threshold

          dynamic "challenge_settings" {
            iterator = challenge_settings
            for_each = js_challenge.value.challenge_settings
            content {
              block_action                 = challenge_settings.value.block_action
              block_error_page_code        = challenge_settings.value.block_error_page_code
              block_error_page_description = challenge_settings.value.block_error_page_description
              block_error_page_message     = challenge_settings.value.block_error_page_message
              block_response_code          = challenge_settings.value.block_response_code
              captcha_footer               = challenge_settings.value.captcha_footer
              captcha_header               = challenge_settings.value.captcha_header
              captcha_submit_label         = challenge_settings.value.captcha_submit_label
              captcha_title                = challenge_settings.value.captcha_title
            }
          }

          dynamic "set_http_header" {
            iterator = set_http_header
            for_each = js_challenge.value.set_http_header
            content {
              name  = set_http_header.value.name
              value = set_http_header.value.value
            }
          }
        }
      }


      dynamic "protection_settings" {
        iterator = protection_settings
        for_each = waf_config.value.protection_settings
        content {
          allowed_http_methods               = protection_settings.value.allowed_http_methods
          block_action                       = protection_settings.value.block_action
          block_error_page_code              = protection_settings.value.block_error_page_code
          block_error_page_description       = protection_settings.value.block_error_page_description
          block_error_page_message           = protection_settings.value.block_error_page_message
          block_response_code                = protection_settings.value.block_response_code
          is_response_inspected              = protection_settings.value.is_response_inspected
          max_argument_count                 = protection_settings.value.max_argument_count
          max_name_length_per_argument       = protection_settings.value.max_name_length_per_argument
          max_response_size_in_ki_b          = protection_settings.value.max_response_size_in_ki_b
          max_total_name_length_of_arguments = protection_settings.value.max_total_name_length_of_arguments
          media_types                        = protection_settings.value.media_types
          recommendations_period_in_days     = protection_settings.value.recommendations_period_in_days
        }
      }


      dynamic "whitelists" {
        iterator = whitelists
        for_each = waf_config.value.whitelists
        content {
          addresses = whitelists.value.addresses
          name      = whitelists.value.name
        }
      }
    }
  }
}

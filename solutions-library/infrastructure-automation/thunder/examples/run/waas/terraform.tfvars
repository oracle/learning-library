// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.

compartment_ids = {
  sandbox = "ocid1.compartment.oc1..aaaaaaaaiu3vfcpbjwwgpil3xakqts4jhtjq42kktmisriiszdvvouwsirgq"
}

uri = {
  primary = "150.136.204.78" # Complete with the public ip address of the load balancer
}

cert_params = {}

waas_policy_params = {

  hurricane1 = {
    domain             = "hurricane1.com"
    additional_domains = ["prod.hurricane1.com", "dev.hurricane1.com"]
    compartment_name   = "sandbox"
    display_name       = "Hurricane"
    label              = "primary"
    http_port          = "80"
    https_port         = "443"
    uri_name           = "primary"
    #certificate_id                = oci_waas_certificate.this.id
    cipher_group                  = "DEFAULT"
    client_address_header         = "X_FORWARDED_FOR"
    is_behind_cdn                 = true
    is_cache_control_respected    = true
    is_https_enabled              = false
    is_https_forced               = false
    is_origin_compression_enabled = true
    is_response_buffering_enabled = true
    tls_protocols                 = ["TLS_V1_1"]


    waf_config = {
      waf_config_1 = {
        origin = "primary"
        access_rules = {
          access_rule_1 = {
            action = "ALLOW"
            name   = "hurricane_example_access_rule"
            #complete the following variables only if action is set to BLOCK
            block_action                 = "SET_RESPONSE_CODE"
            block_error_page_code        = 403
            block_error_page_description = "blockErrorPageDescription"
            block_error_page_message     = "blockErrorPageMessage"
            block_response_code          = 403
            bypass_challenges            = []      # when action is set to BYPASS
            redirect_response_code       = "FOUND" # when action is set to REDIRECT.
            redirect_url                 = "http://10.0.0.3"

            criteria = {
              crit1 = {
                condition = "URL_IS"
                value     = "/public"
              }
            }
          }
        }


        address_rate_limiting = {
          address_rate_limiting_1 = {
            is_enabled                    = true
            allowed_rate_per_address      = 1
            block_response_code           = 503
            max_delayed_count_per_address = 10
          }
        }


        caching_rules = {
          caching_rule_1 = {
            action                    = "CACHE"
            name                      = "hurricane_caching_rule_name"
            caching_duration          = "PT1S"
            client_caching_duration   = "PT1S"
            is_client_caching_enabled = false
            key                       = "hurricane_key"

            criteria = {
              crit1 = {
                condition = "URL_IS"
                value     = "/public"
              }
            }
          }
        }


        captchas = {
          captchas_rule_1 = {
            failure_message               = "The CAPTCHA was incorrect. Try again."
            session_expiration_in_seconds = 300
            submit_label                  = "Yes, I am human."
            title                         = "Are you human?"
            url                           = "url"
            footer_text                   = "Enter the letters and numbers as they are shown in the image above."
            header_text                   = "We have detected an increased number of attempts to access this website. To help us keep this site secure, please let us know that you are not a robot by entering the text from the image below"
          }
        }


        device_fingerprint_challenge = {
          device_fingerprint_1 = {
            is_enabled                              = true
            action                                  = "DETECT"
            action_expiration_in_seconds            = 30
            failure_threshold                       = 10
            failure_threshold_expiration_in_seconds = 10
            max_address_count                       = 10
            max_address_count_expiration_in_seconds = 10

            challenge_settings = {
              settings_1 = {
                block_action                 = "SHOW_ERROR_PAGE"
                block_error_page_code        = "DFC"
                block_error_page_description = "Access blocked by website owner. Please contact support."
                block_error_page_message     = "Access to the website is blocked."
                block_response_code          = 403
                captcha_footer               = "Enter the letters and numbers as they are shown in image above."
                captcha_header               = "We have detected an increased number of attempts to access this website. To help us keep this site secure, please let us know that you are not a robot by entering the text from the image below."
                captcha_submit_label         = "Yes, I am human."
                captcha_title                = "Are you human?"
              }
            }
          }
        }


        human_interaction_challenge = {
          first_human_interaction = {
            is_enabled                              = true
            action                                  = "DETECT"
            action_expiration_in_seconds            = 10
            failure_threshold                       = 10
            failure_threshold_expiration_in_seconds = 10
            interaction_threshold                   = 3
            recording_period_in_seconds             = 15

            challenge_settings = {
              first_challenge = {
                block_action                 = "SHOW_ERROR_PAGE"
                block_error_page_code        = "HIC"
                block_error_page_description = "Access blocked by website owner. Please contact support."
                block_error_page_message     = "Access to the website is blocked."
                block_response_code          = 403
                captcha_footer               = "Enter the letters and numbers as they are shown in image above."
                captcha_header               = "We have detected an increased number of attempts to access this website. To help us keep this site secure, please let us know that you are not a robot by entering the text from the image below."
                captcha_submit_label         = "Yes, I am human."
                captcha_title                = "Are you human?"
              }
            }


            set_http_header = {
              first_http_header = {
                name  = "hurricane-hic-alerts"
                value = "{failed_amount}"
              }
            }
          }
        }


        js_challenge = {
          first_js_challenge = {
            is_enabled                   = true
            action                       = "DETECT"
            action_expiration_in_seconds = 10
            failure_threshold            = 10

            challenge_settings = {
              first_challenge = {
                block_action                 = "SHOW_ERROR_PAGE"
                block_error_page_code        = "JSC"
                block_error_page_description = "Access blocked by website owner. Please contact support."
                block_error_page_message     = "Access to the website is blocked."
                block_response_code          = 403
                captcha_footer               = "Enter the letters and numbers as they are shown in image above."
                captcha_header               = "We have detected an increased number of attempts to access this website. To help us keep this site secure, please let us know that you are not a robot by entering the text from the image below."
                captcha_submit_label         = "Yes, I am human."
                captcha_title                = "Are you human?"
              }
            }


            set_http_header = {
              first_http_header = {
                name  = "hurricane-jsc-alerts"
                value = "{failed_amount}"
              }
            }
          }
        }


        protection_settings = {
          first_protection_setting = {
            allowed_http_methods               = ["GET", "POST", "HEAD", "OPTIONS"]
            block_action                       = "SET_RESPONSE_CODE"
            block_error_page_code              = "403"
            block_error_page_description       = "Access blocked by website owner. Please contact support."
            block_error_page_message           = "Access to the website is blocked."
            block_response_code                = 403
            is_response_inspected              = false
            max_argument_count                 = 255
            max_name_length_per_argument       = 400
            max_response_size_in_ki_b          = 1024
            max_total_name_length_of_arguments = 64000
            media_types                        = ["text/html", "text/plain"]
            recommendations_period_in_days     = 10
          }
        }


        whitelists = {
          first_whitelist = {
            addresses = ["192.168.127.127", "192.168.127.128"]
            name      = "whitelist_name"
          }
        }

      }
    }
  }
}

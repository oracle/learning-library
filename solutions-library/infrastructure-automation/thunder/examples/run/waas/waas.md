# WAAS

## Introduction
OCI WAF is a global security service that protects applications from malicious and unwanted internet traffic. WAF can protect any internet facing endpoint, providing consistent rule enforcement across a customer's applications.

WAF provides you with the ability to create and manage rules for internet threats including Cross-Site Scripting (XSS), SQL Injection and other OWASP-defined vulnerabilities. Unwanted bots can be mitigated while tactically allowed desirable bots to enter. Access rules can limit based on geography or the signature of the request.

## Prerequisites

- Terraform v0.12.9 or greater - <https://www.terraform.io/downloads.html/>
- OCI Provider for Terraform v3.61 or greater - <https://github.com/oracle/terraform-provider-oci/releases>
- 1 VCN, 2 Virtual Machines, 1 Public Load Balancer

## Deployment

Install all the software components from the Prerequisites section. Use the links from each description.

You will have to generate an API signing key (public/private keys) and the public key should be uploaded in the OCI
console, for the iam user that will be used to create the resources. Also, you should make sure that this user has
enough permissions to create resources in OCI. In order to generate the API Signing key, follow the steps
from: <https://docs.us-phoenix-1.oraclecloud.com/Content/API/Concepts/apisigningkey.htm#How>
The API signing key will generate a fingerprint in the OCI console, and that fingerprint will be used in a terraform
file described below.

In addition to this, you are required to generate a ssh key for the user that will run the scripts.

You will need an oci provider which can be defined in an \*.auto.tfvars file in your example folder and the values must reflect your OCI tenancy:

```
provider_oci = {
  tenancy              = ""
  user_id              = ""
  fingerprint          = ""
  key_file_path        = ""
  private_key_password = ""
  region               = ""
}
```

## Description

- WAF Policy parameters
    - domain = The web application domain that the WAAS policy protects
    - additional_domains = An array of additional domains for the specified web application
    - compartment_name = The name of the compartment in which to create the WAAS policy
    - display_name = The name for the WAAS policy
    - label = The label of the origin
    - http_port = The HTTP port on the origin that the web application listens on
    - https_port = The HTTPS port on the origin that the web application listens on
    - uri_name = The URI name of the origin.
    - certificate_id = The OCID of the SSL certificate to use if HTTPS is supported
    - cipher_group = The set cipher group for the configured TLS protocol
    - client\_address\_header = Specifies an HTTP header name which is treated as the connecting client's IP address
    - is\_behind\_cdn = Enabling isBehindCdn allows for the collection of IP addresses from client requests if the WAF is connected to a CDN
    - is\_cache\_control\_respected = Enable or disable automatic content caching based on the response cache-control header
    - is\_https\_enabled = Enable or disable HTTPS support
    - is\_https\_forced = Force HTTP to HTTPS redirection
    - is\_origin\_compression\_enabled = Enable or disable GZIP compression of origin responses
    - is\_response\_buffering\_enabled = Enable or disable buffering of responses from the origin
    - tls_protocols = A list of allowed TLS protocols
    - Access rule parameters:
        - action = The action to take when the access criteria are met for a rule
        - name = The name of the access rule
        - block_action = The method used to block requests if action is set to BLOCK and the access criteria are met
        - block\_error\_page\_code = The error code to show on the error page when action is set to BLOCK
        * block\_error\_page\_description = The description text to show on the error page when action is set to BLOCK
        * block\_error\_page\_message = The message to show on the error page when action is set to BLOCK
        * block\_response\_code = The response status code to return when action is set to BLOCK
        * bypass\_challenges = The list of challenges to bypass when action is set to BYPASS
        * redirect\_response\_code = The response status code to return when action is set to REDIRECT
        * redirect_url = The target to which the request should be redirected, represented as a URI reference
        * criteria:
            - condition = The criteria the access rule uses to determine if action should be taken on a request
            - value = The unique name of the access rule
    - Address Rate Limiting rule parameters:
        - is_enabled = Enables or disables the address rate limiting WAF feature
        - allowed\_rate\_per\_address = The number of allowed requests per second from one IP address
        - block\_response\_code = The response status code returned when a request is blocked
        - max\_delayed\_count\_per\_address = The maximum number of requests allowed to be queued before subsequent requests are dropped
    - Caching rule parameters:
        * action                    = The action to take when the criteria of a caching rule are met
        * name                      = The name of the caching rule
        * caching\_duration          = The duration to cache content for the caching rule, specified in ISO 8601 extended format
        * client\_caching\_duration   = The duration to cache content in the user's browser, specified in ISO 8601 extended format
        * is\_client\_caching\_enabled = Enables or disables client caching
        * key                       =  The unique key for the caching rule
        * criteria :
            * condition = The condition of the caching rule criteria
            * value     = The value of the caching rule criteria
    - Capchas rule parameters
        * failure_message               = The text to show when incorrect CAPTCHA text is entered
        * session\_expiration\_in\_seconds = The amount of time before the CAPTCHA expires, in seconds
        * submit_label                  = The text to show on the label of the CAPTCHA challenge submit button
        * title                         = The title used when displaying a CAPTCHA challenge
        * url                           = The unique URL path at which to show the CAPTCHA challenge.
        * footer_text                   =  The text to show in the footer when showing a CAPTCHA challenge
        * header_text                   = The text to show in the header when showing a CAPTCHA challenge
    - Device Fingerprint Challenge rule parameters:
        * is_enabled                              = Enables or disables the device fingerprint challenge WAF feature
        * action                                  = The action to take on requests from detected bots
        * action\_expiration\_in\_seconds            = The number of seconds between challenges for the same IP address
        * failure_threshold                       =  The number of failed requests allowed before taking action
        * failure\_threshold\_expiration\_in\_seconds = The number of seconds before the failure threshold resets
        * max\_address\_count                       = The maximum number of IP addresses permitted with the same device fingerprint
        * max\_address\_count\_expiration\_in\_seconds = The number of seconds before the maximum addresses count resets
        * challenge_settings:
            * block_action                 =  The method used to block requests that fail the challenge, if action is set to BLOCK
            * block\_error\_page\_code        = The error code to show on the error page when action is set to BLOCK
            * block\_error\_page\_description = The description text to show on the error page when action is set to BLOCK
            * block\_error\_page\_message     = The message to show on the error page when action is set to BLOCK
            * block\_response\_code          = The response status code to return when action is set to BLOCK
            * captcha_footer               = The text to show in the footer when showing a CAPTCHA challenge when action is set to BLOCK
            * captcha_header               = The text to show in the header when showing a CAPTCHA challenge when action is set to BLOCK
            * captcha\_submit\_label         = The text to show on the label of the CAPTCHA challenge submit button when action is set to BLOCK
            * captcha_title                = he title used when showing a CAPTCHA challenge when action is set to BLOCK
    - Human Interaction Challenge rule parameters:
        * is_enabled                              = Enables or disables the human interaction challenge WAF feature
        * action                                  =  The action to take against requests from detected bots
        * action\_expiration\_in\_seconds            = The number of seconds between challenges for the same IP address
        * failure_threshold                       = The number of failed requests before taking action
        * failure\_threshold\_expiration\_in\_seconds = The number of seconds before the failure threshold resets
        * interaction_threshold                   = The number of interactions required to pass the challenge
        * recording\_period\_in\_seconds             = The number of seconds to record the interactions from the use
        * challenge_settings:
            * block_action                 =  The method used to block requests that fail the challenge, if action is set to BLOCK
            * block\_error\_page\_code        = The error code to show on the error page when action is set to BLOCK
            * block\_error\_page\_description = The description text to show on the error page when action is set to BLOCK
            * block\_error\_page\_message     = The message to show on the error page when action is set to BLOCK
            * block\_response\_code          = The response status code to return when action is set to BLOCK
            * captcha_footer               = The text to show in the footer when showing a CAPTCHA challenge when action is set to BLOCK
            * captcha_header               = The text to show in the header when showing a CAPTCHA challenge when action is set to BLOCK
            * captcha\_submit\_label         = The text to show on the label of the CAPTCHA challenge submit button when action is set to BLOCK
            * captcha_title                = he title used when showing a CAPTCHA challenge when action is set to BLOCK
        * set\_http\_header:
            * name  = The name of the header
            * value = The value of the header
    - Java Script Challenge rule parameters:
        * is_enabled                   = Enables or disables the JavaScript challenge WAF feature
        * action                       = The action to take against requests from detected bots
        * action\_expiration\_in\_seconds = The number of seconds between challenges from the same IP address
        * failure_threshold            = The number of failed requests before taking action
        * challenge_settings:
            * block_action                 =  The method used to block requests that fail the challenge, if action is set to BLOCK
            * block\_error\_page\_code        = The error code to show on the error page when action is set to BLOCK
            * block\_error\_page\_description = The description text to show on the error page when action is set to BLOCK
            * block\_error\_page\_message     = The message to show on the error page when action is set to BLOCK
            * block\_response\_code          = The response status code to return when action is set to BLOCK
            * captcha_footer               = The text to show in the footer when showing a CAPTCHA challenge when action is set to BLOCK
            * captcha_header               = The text to show in the header when showing a CAPTCHA challenge when action is set to BLOCK
            * captcha\_submit\_label         = The text to show on the label of the CAPTCHA challenge submit button when action is set to BLOCK
            * captcha_title                = he title used when showing a CAPTCHA challenge when action is set to BLOCK
        * set\_http\_header:
            * name  = The name of the header
            * value = The value of the header
    - Protection rule parameters:
        * allowed\_http\_methods               = The list of allowed HTTP methods
        * block_action                       = If action is set to BLOCK, this specifies how the traffic is blocked when detected as malicious by a protection rule
        * block\_error\_page\_code              = The error code to show on the error page when action is set to BLOCK
        * block\_error\_page\_description       = The description text to show on the error page when action is set to BLOCK
        * block\_error\_page\_message           = The message to show on the error page when action is set to BLOCK
        * block\_response\_code                = The response code returned when action is set to BLOCK
        * is\_response\_inspected              = Inspects the response body of origin responses
        * max\_argument\_count                 = The maximum number of arguments allowed to be passed to your application before an action is taken
        * max\_name\_length\_per\_argument       = The maximum length allowed for each argument name, in characters
        * max\_response\_size\_in\_ki\_b          = The maximum response size to be fully inspected, in binary kilobytes (KiB)
        * max\_total\_name\_length\_of\_arguments = The maximum length allowed for the sum of the argument name and value, in characters
        * media\_types                        = The list of media types to allow for inspection, if isResponseInspected is enabled
        * recommendations\_period\_in\_days     = The length of time to analyze traffic traffic, in days
     - Whitelists rule paramters:
        * addresses = A set of IP addresses or CIDR notations to include in the whitelist
        * name      = The unique name of the whitelist

## Dependencies
Apart from the **provider.auto.tfvars**, there may be some other dependencies in the **terraform.tfvars** file that you will have to address.
All the dependencies from this section should have resources that already exist in OCI.

### Compartment Dependency
In order to be able to run the sample code, you will have to prepare a map variable (like in the **terraform.tfvars** file) called **compartment\_ids**, which will hold key/value pairs with the names and ids of the compartments that you want to use.
This variable will be external in order to offer multiple ways of linking them from a terraform perspective.

```
compartment_ids = {
  sandbox = "ocid1.compartment.oc1..aaaaaaaaiu3vfcpbjwwgpil3xakqts4jhtjq42kktmisriiszdvvouwsirgq"
}
```

### Load Balancer Dependency
In order to be able to run the sample code, you will have to prepare a map variable (like in the **terraform.tfvars** file) called **uri**, which will hold key/value pairs with the names and ip of the load balancers that you want to use.
This variable will be external in order to offer multiple ways of linking them from a terraform perspective.

```
uri = {
  primary = "150.136.204.78" # Complete with the public ip address of the load balancer
}
```


## Example

In the provided example, the following resources are created:

1 WAF Policy with the rules:
  - Access Rules
  - Rate Limiting
  - Captcha Challenge
  - Device Fingerprinting Challenge
  - Human Interaction Challenge
  - JavaScript Challenge
  - Protection Rules
  - IP Whitelists

In the example from below, there is a list of compartments containing 1 elements and a list of uri containing 1 element. By setting in waas\_policy\_params `compartment_name` to sandbox, WAF will be created in the sandbox compartmanet `ocid1.compartment.oc1..aaaaaaaaiu3vfcpbjwwgpil3xakqts4jhtjq42kktmisriiszdvvouwsirgq`.
The same thing is happening to uri. You will need to associate the name of the uri with the public ip of the public load balancer.  
All lists can be extended in order to satisfy your needs.
After the creation of the policy, you should visit your DNS provider and add your CNAME to your domain's DNS configuration.

The example is based on terraform.tfvars values:

```

compartment_ids = {
  sandbox = "ocid1.compartment.oc1..aaaaaaaaiu3vfcpbjwwgpil3xakqts4jhtjq42kktmisriiszdvvouwsirgq"
}

uri = {
  primary = "150.136.204.78" # Complete with the public ip address of the load balancer
}

cert_params = {}

waas_policy_params = {
    hurricane1 = {
        domain = "hurricane1.com"
        additional_domains = ["prod.hurricane1.com", "dev.hurricane1.com"]
        compartment_name = "sandbox"
        display_name = "Hurricane"
        label = "primary"
        http_port = "80"
        https_port = "443"
        uri_name = "primary"
        #certificate_id = oci_waas_certificate.this.id
        cipher_group = "DEFAULT"
        client_address_header = "X_FORWARDED_FOR"
        is_behind_cdn = true
        is_cache_control_respected = true
        is_https_enabled = false
        is_https_forced = false
        is_origin_compression_enabled = true
        is_response_buffering_enabled = true
        tls_protocols = ["TLS_V1_1"]

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

```

This is just an example, but the number of the resources can be increased/decreased to suit any needs by adding another map in the specific resource type.

Don't forget to populate the provider with the details of your tenancy as specified in the main README.md file.

## Running the code

Go to **thunder/examples/run/waas**
```
# Run init to get terraform modules
$ terraform init

# Create the infrastructure
$ terraform apply --var-file=path_to_provider.auto.tfvars

# If you are done with this infrastructure, take it down
$ terraform destroy --var-file=path_to_provider.auto.tfvars
```

## Useful Links

[WAF Concepts](https://docs.cloud.oracle.com/en-us/iaas/Content/WAF/Concepts/overview.htm)

[DNS Zones](https://docs.cloud.oracle.com/en-us/iaas/Content/DNS/Tasks/managingdnszones.htm)

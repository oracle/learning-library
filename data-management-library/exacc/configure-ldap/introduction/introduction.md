# Configure LDAP for ExaCC

## About this Workshop

The Lightweight Directory Access Protocol (LDAP) is an open, vendor-neutral, industry standard application protocol for accessing and maintaining distributed directory information services over an Internet Protocol (IP) network. A common use of LDAP is to provide a central place to store usernames and passwords. This allows many different applications and services to connect to the LDAP server to validate users.

ExaCC is able to leverage existing LDAP configuration for user authentication. This document provides the detailed steps on the necessary configurations that will be need to integrate ExaCC with LDAP to allow users to authenticate access using their LDAP credentials.

Estimated Lab Time: 40 minutes 

### About Product/Technology

This purpose of this lab is to provide detailed steps on how to integrate ExaCC with existing LDAP configuration for authentication to ExaCC.

### Objectives

In this lab, you will be guided through the following steps:

- Configure LDAP
- Precheck
- Modify files: nsswitch.conf and ldap.conf
- Generate certificates
- Modify SSSD config file
- Modifiy files: sshd_config and PAM config 
- Start NSCD and change the config to avoid caching issues, validating NSCD.
- Verify the LDAP/AD user existence 
- Backup procedures
- Troubleshooting

### Prerequisites

* Understand LDAP requirements and service setup.
* Understand networking for ExaCC VMs
* You must own an ExaCC tenancy and complete set up before you can log in and perform this lab.

## Acknowledgements
* **Author** -  Nikolaus Dilger, NA Cloud Engineering.
* **Contributors** -  Tia Salau and Howard Zheng, DRCC and ExaCC, NA Cloud Engineering. 
* **Last Updated By/Date** - Tia Salau, DRCC and ExaCC, NA Cloud Engineering group, April 2021



// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.

comp_params = {
  sandbox = {
    name          = "sandbox"
    description   = "The sandbox compartment contains crawl, walk, run resources for the framework including IAM."
    enable_delete = false
  }
}

user_params = {
  "Root_IAMAdmin" = {
    name        = "Root_IAMAdmin"
    description = "User allowed to modify the Administrators and NetSecAdmins group"
    group_name  = "Root_IAMAdminManagers.grp"
  }
  
  "User_IAMManager" = {
    name        = "User_IAMManager"
    description = "User allowed to modify all users groups except the Administrators and NetSecAdmin group."
    group_name  = "User_IAMManagers.grp"
  }
  
  "Tenancy_NetSecAdmins" = {
    name        = "Tenancy_NetSecAdmins"
    description = "Network admin of security-lists, internet-gateways, cpes, ipsec-connections."
    group_name = "Tenancy_NetSecAdmins.grp" 
  }

  "Tenancy_ReadOnly" = {
    name        = "Tenancy_ReadOnly"
    description = "Tenancy_ReadOnly"
    group_name = "Tenancy_ReadOnly.grp"
  }

  "Sandbox_Engineer" = {
    name        = "Sandbox_Engineer"
    description = "User with full access to manage resources in the sandbox compartment."
    group_name = "Sandbox_Engineer.grp" 
  }

}

group_params = {
  "Root_IAMAdminManagers.grp" = {
    name        = "Root_IAMAdminManagers.grp"
    description = "Group for users allowed to modify the Administrators and NetSecAdmins group."
  }
  
  "User_IAMManagers.grp" = {
    name        = "User_IAMManagers.grp"
    description = "Group for users allowed to modify all users groups except the Administrators and NetSecAdmin group."
  }
  
  "Tenancy_NetSecAdmins.grp" = {
    name        = "Tenancy_NetSecAdmins.grp"
    description = "Administrators of the VCN’s, but restricted from the follow resources: vcns, subnets, route-tables, dhcp-options, drgs, drg-attachments, vnics, vnic-attachments."
  }
  
  "Tenancy_ReadOnly.grp" = {
    name        = "Tenancy_ReadOnly.grp"
    description = "Viewing & Inspecting the tenancy configuration. Aim at Management and users in training before getting read/write access."
  }
  
  "Sandbox_Engineer.grp" = {
    name        = "Sandbox_Engineer.grp"
    description = "Group able to perform Engineering activities on all resources limited to the sandbox compartment."
  }
}

policy_params = {
  "Root_IAMAdminManagers.pl" = {
    name           = "Root_IAMAdminManagers.pl"
    description    = "Root_IAMAdminManagers.pl"

    statements = [
      "ALLOW GROUP Root_IAMAdminManagers.grp to read users IN TENANCY",
      "ALLOW GROUP Root_IAMAdminManagers.grp to read groups IN TENANCY",
      "ALLOW GROUP Root_IAMAdminManagers.grp to manage users IN TENANCY",
      "ALLOW GROUP Root_IAMAdminManagers.grp to manage groups IN TENANCY where target.group.name = 'Administrators'",
      "ALLOW GROUP Root_IAMAdminManagers.grp to manage groups IN TENANCY where target.group.name = 'Tenancy_NetSecAdmins.grp'",
    ]
  }
  
  "User_IAMManagers.pl" = {
    name           = "User_IAMManagers.pl"
    description    = "User_IAMManagers.pl"

    statements = [
      "ALLOW GROUP User_IAMManagers.grp to read users IN TENANCY",
      "ALLOW GROUP User_IAMManagers.grp to read groups IN TENANCY",
      "ALLOW GROUP User_IAMManagers.grp to manage users IN TENANCY",
      "ALLOW GROUP User_IAMManagers.grp to manage groups IN TENANCY where all {target.group.name ! = 'Administrators', target.group.name ! = 'Tenancy_NetSecAdmins.grp'}"
    ]
  }
  
  "Tenancy_NetSecAdmins.pl" = {
    name           = "Tenancy_NetSecAdmins.pl"
    description    = "Tenancy_NetSecAdmins.pl"

    statements = [
      "ALLOW GROUP Tenancy_NetSecAdmins.grp to manage security-lists IN TENANCY",
      "ALLOW GROUP Tenancy_NetSecAdmins.grp to manage internet-gateways IN TENANCY",
      "ALLOW GROUP Tenancy_NetSecAdmins.grp to manage cpes IN TENANCY",
      "ALLOW GROUP Tenancy_NetSecAdmins.grp to manage ipsec-connections IN TENANCY",
      "ALLOW GROUP Tenancy_NetSecAdmins.grp to use virtual-network-family IN TENANCY",
      "ALLOW GROUP Tenancy_NetSecAdmins.grp to manage load-balancers IN TENANCY",
      "ALLOW GROUP Tenancy_NetSecAdmins.grp to read all-resources IN TENANCY",
    ]
  }
  
  "Tenancy_ReadOnly.pl" = {
    name           = "Tenancy_ReadOnly.pl"
    description    = "Tenancy_ReadOnly.pl"

    statements = [
      "ALLOW GROUP Tenancy_ReadOnly.grp to read all-resources IN TENANCY"
    ]
  }
  "Sandbox_Engineer.pl" = {
    name           = "Sandbox_Engineer.pl"
    description    = "Sandbox_Engineer.pl"

    statements = [
      "ALLOW GROUP Sandbox_Engineer.grp to manage instance-family IN TENANCY where target.compartment.name=/sandbox/",
      "ALLOW GROUP Sandbox_Engineer.grp to manage object-family IN TENANCY where target.compartment.name=/sandbox/",
      "ALLOW GROUP Sandbox_Engineer.grp to manage database-family IN TENANCY where target.compartment.name=/sandbox/",
      "ALLOW GROUP Sandbox_Engineer.grp to manage volume-family IN TENANCY where target.compartment.name=/sandbox/",
      "ALLOW GROUP Sandbox_Engineer.grp to manage virtual-network-family IN TENANCY where target.compartment.name=/sandbox/",
      "ALLOW GROUP Sandbox_Engineer.grp to manage app-catalog-listing IN TENANCY where target.compartment.name=/sandbox/",
      "ALLOW GROUP Sandbox_Engineer.grp to manage cluster-family IN TENANCY where target.compartment.name=/sandbox/",
      "ALLOW GROUP Sandbox_Engineer.grp to manage file-family IN TENANCY where target.compartment.name=/sandbox/",
      "ALLOW GROUP Sandbox_Engineer.grp to manage app-catalog-listing IN TENANCY where target.compartment.name=/sandbox/",
      "ALLOW GROUP Sandbox_Engineer.grp to read all-resources IN TENANCY"
    ]
  }
}

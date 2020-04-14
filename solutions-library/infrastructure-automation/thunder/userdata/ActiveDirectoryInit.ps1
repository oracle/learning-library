# Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.
#ps1_sysnative
########
# Title: ActiveDirectoryInit.ps1
# Version & Date: v1 31 Oct 2018
# Creator: john.s.parker@oracle.com
# Warning: This script is a representation of how to use PowerShell to create an Active Directory Domain controller
# and build the first DC in a new Active Directory Forest. This script creates and uses the domain administrator
account
# there are potential for mistakes and destructive actions. USE AT YOUR OWN RISK!!
# This is the first script in the Active Directory Series that will establish the first
# Active Directory Domain Controller. This script will unlock the local administrator account
# this account will become the Domain Administrator.
#
# This script will install the required Windows features that are required for Active
# Directory. This script will install the prerequisites for Active Directory, then create a
# one-time executed script on the login after the reboot. This script will reboot the host
# a total of 2 times to add the windows features, create the forest, and promote the domain controller.
#
# Variables for this script
# $password - this is the password necessary to unlock the administrator account
# - and is used in both runs of the AD build.
# $FullDomainName - the full name for the AD Domain example: CESA.corp
# $ShortDomainName - the short name for the AD Domain example: CESA
# $encrypted - you must encrypt the password so that you can use it as you set up your domain controller
# $addsmodule02 - this is the text block that will be used to create the RunOnceScript that will finish the installation
# - of the domain controller.
# $RunOnceKey - this is the key that will create the command to complete the installation of the domain controller.
Try {
#
# Start the logging in the C:\DoimainJoin directory
#
Start-Transcript -Path "C:\DomainJoin\stage1.txt"
# Global Variables
$password="P@ssw0rd123!!"
# Set the Administrator Password and activate the Domain Admin Account
#
net user Administrator $password /logonpasswordchg:no /active:yes
# Install the Windows features necessary for Active Directory
# Features
# - .NET Core
# - Active Directory Domain Services
# - Remote Active Directory Services
# - DNS Services
#
Install-WindowsFeature NET-Framework-Core
Install-WindowsFeature AD-Domain-Services
Install-WindowsFeature RSAT-ADDS
Install-WindowsFeature RSAT-DNS-Server
# Create text block for the new script that will be ran once on reboot
#
# WE NEED TO MAKE THE PASSWORD FULL SHORT DOMAIN NAMES VARIABLES IN TF
$addsmodule02 = @"
#ps1_sysnative
Try {
Start-Transcript -Path C:\DomainJoin\stage2.txt
`$password = "P@ssw0rd123!!"
`$FullDomainName = "cesa.corp"
`$ShortDomainName = "CESA"
`$encrypted = ConvertTo-SecureString `$password -AsPlainText -Force
Import-Module ADDSDeployment
Install-ADDSForest ``
-CreateDnsDelegation:`$false ``
-DatabasePath "C:\Windows\NTDS" ``
-DomainMode "WinThreshold" ``
-DomainName `$FullDomainName ``
-DomainNetbiosName `$ShortDomainName ``
-ForestMode "WinThreshold" ``
-InstallDns:`$true ``
-LogPath "C:\Windows\NTDS" ``
-NoRebootOnCompletion:`$false ``
-SysvolPath "C:\Windows\SYSVOL" ``
-SafeModeAdministratorPassword `$encrypted ``
-Force:`$true
} Catch {
Write-Host $_
} Finally {
Stop-Transcript
}
"@
Add-Content -Path "C:\DomainJoin\ADDCmodule2.ps1" -Value $addsmodule02
# Adding the run once job
#
$RunOnceKey = "HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce"
set-itemproperty $RunOnceKey "NextRun" ('C:\Windows\System32\WindowsPowerShell\v1.0\Powershell.exe -
executionPolicy Unrestricted -File ' + "C:\DomainJoin\ADDCmodule2.ps1")
# End the logging
#
} Catch {
Write-Host $_
} Finally {
Stop-Transcript
}
# Last step is to reboot the local host
#
Restart-Computer -ComputerName "localhost" -Force
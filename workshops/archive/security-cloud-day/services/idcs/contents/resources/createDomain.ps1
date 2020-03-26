Install-windowsfeature AD-domain-services
Import-Module ADDSDeployment
Import-Module ServerManager
Add-WindowsFeature RSAT-ADDS-Tools
Get-WindowsFeature RSAT
Install-ADDSForest -InstallDns:$true -CreateDnsDelegation:$false -DomainName oracledemo.com -DomainMode Win2012 -ForestMode Win2012 -DatabasePath "c:\NTDS" -SYSVOLPath "c:\SYSVOL" -LogPath "c:\Logs" -safemodeadministratorpassword (convertto-securestring “Or#cle123” -asplaintext -force) -NoRebootOnCompletion:$false -Force:$true 
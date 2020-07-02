Start-Transcript
Enable-PSRemoting -SkipNetworkProfileCheck -Force
Get-NetConnectionProfile | Set-NetConnectionProfile -NetworkCategory Private
winrm quickconfig -force
winrm quickconfig '-transport:http'
winrm set winrm/config/client '@{AllowUnencrypted="true"}'
winrm set winrm/config/client/auth '@{Basic="true"}'
winrm set winrm/config/listener?Address=*+Transport=HTTP '@{Port="5985"}'
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
winrm set winrm/config/service/auth '@{Basic="true"}'
winrm set winrm/config/service/auth '@{CredSSP="true"}'
winrm set winrm/config '@{MaxTimeoutms="7200000"}'  
winrm set winrm/config/winrs '@{MaxMemoryPerShellMB="2048"}'

netsh advfirewall firewall add rule name="WinRM HTTP" protocol=TCP dir=in profile=any localport=5985 remoteip=any localip=any action=allow
netsh advfirewall firewall add rule name="WinRM HTTPS" protocol=TCP dir=in profile=any localport=5986 remoteip=any localip=any action=allow

# disable A: D: drives
Set-ItemProperty HKLM:\SYSTEM\CurrentControlSet\Services\Flpydisk -Name Start -Value 4
Set-ItemProperty HKLM:\System\CurrentControlSet\Services\cdrom -Name Start -Value 4
# disable Windows Animations
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop\WindowMetrics" -Name MinAnimate -Value 0

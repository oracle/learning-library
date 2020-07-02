sc config "WinRM" start= auto
powershell -Command "Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Force"
powershell -Command "Set-ExecutionPolicy Unrestricted -Force"
powershell -NoLogo -ExecutionPolicy RemoteSigned -File A:\WinRM.ps1

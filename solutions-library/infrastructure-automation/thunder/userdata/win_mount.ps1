#ps1_sysnative
Start-Transcript
Sleep 300

$user='opc'
$password='${password}'
$enable_admin='${enable_admin}'

net user $user $password
if ($enable_admin.ToLower() -eq "yes") {
    net user administrator $password
    net user administrator /active:yes
}

# takes a disk number and creates a partition on it
function CreatePartitionOnDisk {
    Param ($number,$mount_point)
    
    Initialize-Disk -Number $number -PartitionStyle GPT
    New-Partition -DiskNumber $number -UseMaximumSize -DriveLetter $mount_point
    Format-Volume -DriveLetter $mount_point -FileSystem NTFS -confirm:0
    
    return
}

# parse input, example mapping -> "D:50GB E:60GB F:80GB"
$device_disk_mappings='${device_disk_mappings}'
$device_disk_mappings=$device_disk_mappings.split(' ')
$att_type='${block_vol_att_type}'

if ($att_type -eq "iscsi") {
    Set-Service -Name msiscsi -StartupType Automatic
    Start-Service msiscsi
    Write-Host "Locating attached volumes.  This may take several minutes..."
    for ($i=2; $i -lt ($device_disk_mappings.length + 2 ); $i++) {
        $DiskPos = $i
        Write-Host ""
        Write-Host ("Searching address: 169.254.2." + $DiskPos)
        $TargetPortal = New-IscsiTargetPortal -TargetPortalAddress 169.254.2.$DiskPos -ErrorAction SilentlyContinue
        if ($TargetPortal) {
            Write-Host ("Target Portal found at address: 169.254.2." + $DiskPos)
            $TargetPortal | Get-IscsiTarget | Connect-IscsiTarget -NodeAddress {$_.NodeAddress} -IsPersistent $True -ErrorAction SilentlyContinue | Out-Null
        }
    }
}

$formatted = @(0) * ((Get-Disk | Select number).length)
foreach($device in $device_disk_mappings) {
    $mount_point=$device.split(':')[0]
    $disk_size=$device.split(':')[1]
    $disk_size=($disk_size -replace '[^0-9]')
    # 2 possibilities for disk sizes
    $number=(Get-Disk | Where-Object { ($_.Size/1GB) -eq $disk_size } | select number).number
    # 1) same size in only 1 disk
    if($number.length -eq 1) {
        CreatePartitionOnDisk $number $mount_point
    # 2) same size for multiple disks
    } elseif($number.length -gt 1) {
        foreach($potential_disk in $number) {
            # disk not formatted yet
            if($formatted[$potential_disk] -eq 0) {
                CreatePartitionOnDisk $potential_disk $mount_point
                $formatted[$potential_disk] = 1
                break # mount point solved
            }
            # disk previously formatted -> look for the others with same size
            else {continue}
        }
    } else {
        echo "Error !"
    }
}
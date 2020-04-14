# reference: https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/7/html/Installation_Guide/sect-kickstart-syntax.html
# based on one of our production installs with some modifications
# and some integrations from https://raw.githubusercontent.com/geerlingguy/packer-centos-7/master/http/ks.cfg

# Run the installer
install

# Use CDROM installation media
cdrom

# System language
lang en_US.UTF-8

# Keyboard layouts
keyboard us

# Enable more hardware support
unsupported_hardware

# Network information
network --bootproto=dhcp

# System authorization information
auth --enableshadow --passalgo=sha512

# Root password
rootpw Ra90OracleCloud!

# Selinux in permissive mode (will be disabled by provisioners)
selinux --permissive

# System timezone
timezone UTC

# System bootloader configuration
bootloader --append=" crashkernel=auto" --location=mbr --boot-drive=vda

# Run the text install
text

# Skip X config
skipx

# Only use /dev/vda
ignoredisk --only-use=vda

# Overwrite the MBR
zerombr

# Partition clearing information
clearpart --none --initlabel

# Disk partitioning information
part pv.305 --fstype="lvmpv" --ondisk=vda --size=48000
part /boot --fstype="ext4" --ondisk=vda --size=1024 --label=BOOT
volgroup VGsystem --pesize=4096 pv.305
logvol swap  --fstype="swap" --size=4000 --name=LVswap --vgname=VGsystem
logvol /  --fstype="ext4" --size=8000 --label="ROOT" --name=LVroot --vgname=VGsystem
logvol /tmp  --fstype="ext4" --size=3000 --name=LVtmp --vgname=VGsystem
logvol /home  --fstype="ext4" --size=3000 --name=LVhome --vgname=VGsystem
logvol /usr/local/xactly  --fstype="ext4" --size=3000 --name=LVxactly --vgname=VGsystem
logvol /var  --fstype="ext4" --size=3000 --name=LVvar --vgname=VGsystem
logvol /var/log  --fstype="ext4" --size=3000 --name=LVvarlog --vgname=VGsystem
logvol /var/log/audit  --fstype="ext4" --size=3000 --name=LVvarlogaudit --vgname=VGsystem
logvol /var/tmp  --fstype="ext4" --size=3000 --name=LVvartmp --vgname=VGsystem


# Do not run the Setup Agent on first boot
firstboot --disabled

# Accept the EULA
eula --agreed

# System services
services --disabled="chronyd" --enabled="sshd"

# Reboot the system when the install is complete
reboot


# Packages

%packages
@core
perl
kexec-tools
# unnecessary firmware
-aic94xx-firmware
-atmel-firmware
-b43-openfwwf
-bfa-firmware
-ipw2100-firmware
-ipw2200-firmware
-ivtv-firmware
-iwl100-firmware
-iwl1000-firmware
-iwl3945-firmware
-iwl4965-firmware
-iwl5000-firmware
-iwl5150-firmware
-iwl6000-firmware
-iwl6000g2a-firmware
-iwl6050-firmware
-libertas-usb8388-firmware
-ql2100-firmware
-ql2200-firmware
-ql23xx-firmware
-ql2400-firmware
-ql2500-firmware
-rt61pci-firmware
-rt73usb-firmware
-xorg-x11-drv-ati-firmware
-zd1211-firmware

%end

%addon com_redhat_kdump --enable --reserve-mb='auto'

%end

%post # changes for OCI compatibility
rpm -Uvh https://dl.fedoraproject.org/pub/epel/7/x86_64/Packages/e/epel-release-7-12.noarch.rpm
yum -y install cloud-init cloud-utils cloud-utils-growpart
perl -wpi -e 's/name: centos/name: opc\n    gecos: Oracle Public Cloud User/g' /etc/cloud/cloud.cfg
sed -i '/gecos: Cloud User/d' /etc/cloud/cloud.cfg
cat >> /etc/cloud/cloud.cfg << EOF
datasource_list: ['Oracle', 'OpenStack']
datasource:
  OpenStack:
    metadata_urls: ['http://169.254.169.254']
    timeout: 10
    max_wait: 20
EOF
> /lib/udev/rules.d/75-persistent-net-generator.rules
> /etc/udev/rules.d/70-persistent-net.rules
%end

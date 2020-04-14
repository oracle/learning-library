install
text
skipx
autostep
lang       en_US.UTF-8
keyboard   us
rootpw     pM0dularc
network    --bootproto dhcp --device eth0 --activate
firewall   --enabled --ssh
authconfig --enableshadow --passalgo=sha512 --enablefingerprint
timezone   --utc Etc/UTC
selinux    --disabled
services   --enabled=acpid,ntpd,sshd
# partitioning
zerombr
clearpart                 --all --initlabel
bootloader                --location=mbr
part pv.305               --fstype="lvmpv" --ondisk=vda --size=48000
part /boot                --fstype="ext4" --ondisk=vda --size=1024
volgroup VGsystem         --pesize=4096 pv.305
logvol swap               --fstype="swap" --size=4000 --name=LVswap --vgname=VGsystem
logvol /                  --fstype="ext4" --size=8000 --name=LVroot --vgname=VGsystem
logvol /tmp               --fstype="ext4" --size=3000 --name=LVtmp --vgname=VGsystem
logvol /home              --fstype="ext4" --size=3000 --name=LVhome --vgname=VGsystem
logvol /usr/local/xactly  --fstype="ext4" --size=3000 --name=LVxactly --vgname=VGsystem
logvol /var               --fstype="ext4" --size=3000 --name=LVvar --vgname=VGsystem
logvol /var/log           --fstype="ext4" --size=3000 --name=LVvarlog --vgname=VGsystem
logvol /var/log/audit     --fstype="ext4" --size=3000 --name=LVvarlogaudit --vgname=VGsystem
logvol /var/tmp           --fstype="ext4" --size=3000 --name=LVvartmp --vgname=VGsystem
reboot

%packages
@Core
%end

%post # install cloud-init and configure
rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
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

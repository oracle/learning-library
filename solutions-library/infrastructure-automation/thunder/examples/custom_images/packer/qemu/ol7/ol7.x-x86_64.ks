install
text
skipx
autostep
lang en_US.UTF-8
keyboard us
network --bootproto dhcp --activate
repo --name=epel --baseurl=https://archive.fedoraproject.org/pub/epel/7/x86_64/ --cost=100
firewall --enabled

bootloader --append=" crashkernel=auto LANG=en_US.UTF-8 console=tty0 console=ttyS0 rd.luks=0 rd.md=0 rd.dm=0 rd.iscsi.bypass=1 netroot=iscsi:169.254.0.2:::1:iqn.2015-02.oracle.boot:uefi iscsi_param=node.session.timeo.replacement_timeout=6000 net.ifnames=1 nvme_core.shutdown_timeout=10 ipmi_si.tryacpi=0 ipmi_si.trydmi=0 ipmi_si.trydefaults=0 libiscsi.debug_libiscsi_eh=1 loglevel=4" --location=mbr
zerombr
clearpart --all --initlabel
part pv.305 --fstype="lvmpv" --ondisk=vda --size=48000
part /boot --fstype="ext4" --ondisk=vda --size=1024
volgroup VGsystem --pesize=4096 pv.305
logvol swap  --fstype="swap" --size=4000 --name=LVswap --vgname=VGsystem
logvol /  --fstype="ext4" --size=8000 --name=LVroot --vgname=VGsystem
logvol /tmp  --fstype="ext4" --size=3000 --name=LVtmp --vgname=VGsystem
logvol /home  --fstype="ext4" --size=3000 --name=LVhome --vgname=VGsystem
logvol /usr/local/xactly  --fstype="ext4" --size=3000 --name=LVxactly --vgname=VGsystem
logvol /var  --fstype="ext4" --size=3000 --name=LVvar --vgname=VGsystem
logvol /var/log  --fstype="ext4" --size=3000 --name=LVvarlog --vgname=VGsystem
logvol /var/log/audit  --fstype="ext4" --size=3000 --name=LVvarlogaudit --vgname=VGsystem
logvol /var/tmp  --fstype="ext4" --size=3000 --name=LVvartmp --vgname=VGsystem

rootpw pM0dularc
authconfig --enableshadow --passalgo=sha512 --enablefingerprint
timezone --utc America/Los_Angeles
selinux --disabled
reboot

%packages
@Core
iscsi-initiator-utils-iscsiuio
iscsi-initiator-utils
efivar-libs
grub2-efi-x64
efibootmgr
shim-x64
jq
-i*-firmware
-aic94xx-firmware
-alsa-firmware
-alsa-tools-firmware
-biosdevname
-ivtv-firmware
-ivtv-firmware
-iwl100-firmware
-iwl1000-firmware
-iwl105-firmware
-iwl135-firmware
-iwl2000-firmware
-iwl2030-firmware
-iwl3160-firmware
-iwl3945-firmware
-iwl4965-firmware
-iwl5000-firmware
-iwl5150-firmware
-iwl6000-firmware
-iwl6000g2a-firmware
-iwl6000g2b-firmware
-iwl6050-firmware
-iwl7260-firmware
-iwl7265-firmware
-libertas-sd8686-firmware
-libertas-sd8787-firmware
-libertas-usb8388-firmware
-linux-firmware
-NetworkManager
-NetworkManager-team
-NetworkManager-tui
-NetworkManager-libnm
-NetworkManager-config-server
%end

%post --interpreter=/bin/bash --logfile /root/xactly-post.log
yum install -y cloud-init cloud-utils-growpart
sed -i 's/name: cloud-user/name: opc\n    gecos: Oracle Public Cloud User/g' /etc/cloud/cloud.cfg
sed -i '/gecos: Cloud User/d' /etc/cloud/cloud.cfg
cat >> /etc/cloud/cloud.cfg << EOF
datasource_list: ['Oracle', 'OpenStack']
datasource:
  OpenStack:
    metadata_urls: ['http://169.254.169.254']
    timeout: 10
    max_wait: 20

EOF
chmod 755 /etc/rc.d/rc.local
sed -i "s/rhgb quiet//" /etc/default/grub
grub2-mkconfig -o /boot/grub2/grub.cfg
sed -i '/PasswordAuthentication/d' /etc/ssh/sshd_config
sed -i '/UseDNS/d' /etc/ssh/sshd_config
sed -i '/PermitRootLogin/d' /etc/ssh/sshd_config
echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
echo "UseDNS no" >> /etc/ssh/sshd_config
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
mkdir -p /etc/dhcp/exit-hooks.d/
%end

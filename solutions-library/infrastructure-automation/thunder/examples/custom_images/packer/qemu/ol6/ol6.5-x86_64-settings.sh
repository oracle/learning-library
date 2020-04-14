> /lib/udev/rules.d/75-persistent-net-generator.rules # you get eth1 otherwise
# change boot kernel to Oracle Linux Server Red Hat Compatible Kernel since Unbreakable Enterprise Kernel crashed
perl -wpi -e 's/default=0/default=1/g' /boot/grub/grub.conf
perl -wpi -e 's/( rhgb| quiet)//g'     /boot/grub/grub.conf
sed -i '/PermitRootLogin/d'          /etc/ssh/sshd_config
sed -i '/UseDNS/d'                   /etc/ssh/sshd_config
sed -i '/PasswordAuthentication/d'   /etc/ssh/sshd_config
sed -i '/UsePAM/d'	             /etc/ssh/sshd_config
echo "PermitRootLogin yes" >>        /etc/ssh/sshd_config
echo "UseDNS no" >>                  /etc/ssh/sshd_config
echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
echo "UsePAM yes" >>    	     /etc/ssh/sshd_config
cat > /etc/sysconfig/network-scripts/ifcfg-eth0 << EOF
DEVICE=eth0
BOOTPROTO=dhcp
ONBOOT=yes
TYPE=Ethernet
EOF
cat > /etc/sysconfig/network << EOF
NETWORKING=yes
NOZEROCONF=yes
EOF
chmod 755 /etc/rc.d/rc.local
# enable secondary console
echo ttyS0 >> /etc/securetty
# lock root account
passwd -d root
passwd -l root

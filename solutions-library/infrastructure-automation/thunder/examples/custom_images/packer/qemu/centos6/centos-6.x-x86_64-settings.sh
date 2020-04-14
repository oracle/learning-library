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
EOF
chmod 755 /etc/rc.d/rc.local
# enable secondary console
echo ttyS0 >> /etc/securetty
# lock root account
passwd -d root
passwd -l root


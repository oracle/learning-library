echo "export PS1=\"\$USER@\$(hostname): \w \\\\$ \"" >> /root/.bashrc
rm /etc/udev/rules.d/70-persistent-net.rules
mkdir -p /etc/dhcp/exit-hooks.d/
# lock root account
passwd -d root
passwd -l root

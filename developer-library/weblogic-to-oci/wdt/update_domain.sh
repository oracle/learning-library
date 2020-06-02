TARGET_WLS_ADMIN=

echo "Copying files over to the WLS admin server..."
scp source.* opc@${TARGET_WLS_ADMIN}:~/
scp install_wdt.sh opc@${TARGET_WLS_ADMIN}:~/
scp update_domain_as_oracle_user.sh opc@${TARGET_WLS_ADMIN}:~/

echo "Changing ownership of files to oracle user..."
ssh opc@${TARGET_WLS_ADMIN} "sudo chown oracle:oracle *.*; sudo chmod +x *.sh; sudo mv *.* /home/oracle/; "

echo "Installing WebLogic Deploy Tooling..."
ssh opc@${TARGET_WLS_ADMIN} "sudo su -c './install_wdt.sh' - oracle"

echo "Updating the domain..."
ssh opc@${TARGET_WLS_ADMIN} "sudo su -c './update_domain_as_oracle_user.sh' - oracle"

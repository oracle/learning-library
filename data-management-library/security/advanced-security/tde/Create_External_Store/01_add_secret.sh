#!/bin/bash

# keep track of script usage with a simple curl query
# the remote host runs nginx and uses a javascript function to mask your public ip address
# see here for details: https://www.nginx.com/blog/data-masking-user-privacy-nginscript/
#
file_path=`realpath "$0"`
curl -Is --connect-timeout 3 http://150.136.21.99:6868${file_path} > /dev/null

# generate an output based on the script name
outfile=$(basename -s .sh $0)".out"
#echo $outfile
rm -f $outfile 2>&1
exec > >(tee -a $outfile) 2>&1

echo
echo "Create the auto login external store by creating and adding the wallet password to the \$WALLET_ROOT/tde_seps/cwallet.sso "
echo

sqlplus -s / as sysdba <<EOF
--
ADMINISTER KEY MANAGEMENT ADD SECRET 'Oracle123'  FOR CLIENT 'TDE_WALLET' TO LOCAL AUTO_LOGIN KEYSTORE '$WALLET_DIR/tde_seps';
EOF

echo
echo "View the contents of the directory that holds the external store wallet..."
echo "You should see one file, cwallet.sso"
echo
ls -al $WALLET_DIR/tde_seps

echo

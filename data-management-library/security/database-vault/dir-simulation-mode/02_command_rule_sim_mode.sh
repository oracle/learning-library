#!/bin/bash

# generate an output based on the script name
outfile=$(basename -s .sh $0)".out"
#echo $outfile
rm -f $outfile 2>&1
exec > >(tee -a $outfile) 2>&1

# keep track of script usage with a simple curl query
# the remote host runs nginx and uses a javascript function to mask your public ip address
# see here for details: https://www.nginx.com/blog/data-masking-user-privacy-nginscript/
#
file_path=`realpath "$0"`
curl -Is --connect-timeout 3 http://150.136.21.99:6868${file_path} > /dev/null

sqlplus -s /nolog <<EOF
--
connect c##dvowner/Oracle123@pdb1
BEGIN
DBMS_MACADM.CREATE_COMMAND_RULE(
 command 	 => 'CONNECT',
 rule_set_name   => 'Disabled',
 object_name       => '%',
 object_owner       => '%',
 enabled         => DBMS_MACUTL.G_SIMULATION);
END;
/
--
EOF

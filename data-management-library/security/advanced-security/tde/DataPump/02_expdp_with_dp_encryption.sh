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
echo "Perform a Data Pump Export and view the data."
echo "This Data Pump Export will use the 'ENCRYPTION=ALL' option to encrypt the data and use the TDE wallet..."
echo

expdp masking_admin/Oracle123@pdb1 schemas=EMPLOYEESEARCH_PROD DUMPFILE=empsearch_prod.dmp REUSE_DUMPFILES=YES ENCRYPTION=ALL
ls -al /u01/app/oracle/admin/cdb1/dpdump/9623C50C30AD638EE0532C00000A4926/empsearch_prod.dmp
strings /u01/app/oracle/admin/cdb1/dpdump/9623C50C30AD638EE0532C00000A4926/empsearch_prod.dmp | more


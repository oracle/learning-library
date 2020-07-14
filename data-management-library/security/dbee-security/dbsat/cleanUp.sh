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

echo "Clean up files related to unzipping and running DBSAT..."
rm -f dbsat
rm -f dbsat.bat
rm -f *.log
rm -f *.csv
rm -f *.xls
rm -f *.html
rm -f sat_*
rm -Rf Discover
rm -Rf xlsxwriter
rm -f ttt*

echo "Clean-up DBSAT files copied to Glassfish home..."
rm -f $GLASSFISH_HOME/hr_prod_pdb1/dbsat/*.html
rmdir $GLASSFISH_HOME/hr_prod_pdb1/dbsat

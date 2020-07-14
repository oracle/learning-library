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
echo "Start Glassfish..."
echo
$DBSEC_ADMIN/start_Glassfish.sh

echo
echo "Make a directory in the Glassfish HR app for the DBSAT HTML file..."
echo
mkdir $GLASSFISH_HOME/hr_prod_pdb1/dbsat

echo
echo "Copy the .html files to our new Glassfish DBSAT directory..."
echo 
cp *.html $GLASSFISH_HOME/hr_prod_pdb1/dbsat

echo
echo "Use your local browser to view it on your PUBLIC_IP at:"
echo
for x in `ls *.html`
do 
echo "http://${PUBLIC_IP}:8080/hr_prod_pdb1/dbsat/$x"
done
echo 

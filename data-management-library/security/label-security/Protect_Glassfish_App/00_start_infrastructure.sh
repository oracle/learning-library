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

### Start Database
$DBSEC_ADMIN/start_cdb.sh

echo
echo "Add a new rule to our ruleset to allow local sqlplus connections as EMPLOYEESEARCH..."
echo
sqlplus /nolog <<EOF
@$DBSEC_HOME/workshops/dbsec/ols_scripts/add_local_sqlplus_rule.sql
EOF

GL_HOME=${GLASSFISH_HOME}

### Start up Glassfish ###
cd ${GL_HOME}
nohup ./startGlassfish.sh &

# Make sure the files are original and not OLS enabled
 # if it is, we will use our original backup file.
 # if it is not, we will continue as expected.
cd ${GL_HOME}/hr_prod_pdb1
if [ "`grep -il set_app_user_label *.jsp* | wc -l`" -gt "0" ]
 then
  echo "" 
  echo "OLS-enbled hr_prod_pdb1 files are in place."
  echo "We must restore the original hr_prod_pdb1 files first..."
  echo ""
  tar zxvf ${GL_HOME}/emergency_hr_prod_pdb1.tar.gz 
  echo "" 
  echo "Done."
else
  echo "hr_prod_pdb1 app is ready."
fi

sleep 10

read -p "Press enter to close"


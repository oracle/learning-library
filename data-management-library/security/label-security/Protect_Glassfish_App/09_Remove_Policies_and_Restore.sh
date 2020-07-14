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


sqlplus -s / as sysdba << EOF

set echo on;

connect lbacsys/Oracle123@pdb1
show con_name
show user


prompt Drop OLS Policy
-- Drop existing policy
begin 
 LBACSYS.SA_SYSDBA.DROP_POLICY(
    policy_name => 'OLS_DEMO_HR_APP',
     drop_column => TRUE);
end;
/

connect employeesearch_prod/Oracle123@pdb1
show con_name
show user

truncate table employeesearch_prod.demo_hr_error_log;

EOF

#sqlplus /nolog <<EOF
#@$DBSEC_HOME/workshops/dbsec/ols_scripts/remove_local_sqlplus_rule.sql
#EOF

OLS_LABS=$DBSEC_HOME/workshops/Database_Security_Labs/Label_Security
ORIG_SCRIPTS=${OLS_LABS}/Protect_Glassfish_App/hr_prod_pdb1/

# Copy the original scripts back into place
echo 
echo "Copy the original Glassfish scripts back into place..."
echo
cd ${GLASSFISH_HOME}/hr_prod_pdb1
cp ${ORIG_SCRIPTS}/controller.jsp controller.jsp
cp ${ORIG_SCRIPTS}/employee_create.jsp employee_create.jsp
cp ${ORIG_SCRIPTS}/employee_modify.jsp employee_modify.jsp
cp ${ORIG_SCRIPTS}/employee_view.jsp employee_view.jsp
cp ${ORIG_SCRIPTS}/search_engineering.jsp search_engineering.jsp
cp ${ORIG_SCRIPTS}/search.jsp search.jsp
cp ${ORIG_SCRIPTS}/session_data.jsp session_data.jsp

ls -alrt *.jsp

echo


# Delete the .out files
#cd ${OLS_LABS}
#echo
#echo
#find ./ -type f -name "*.out" 
#echo
#echo
#find ./ -type f -name "*.out" -exec rm {} \;
#echo
#echo
#find ./ -type f -name "*.out" 
#
#echo
#echo

cd ${GLASSFISH_HOME}
nohup ./redeployAppGlassfish.sh hr_prod_pdb1 &

sleep 10

echo
echo

#cd ${GLASSFISH_HOME}
#./stopGlassfish.sh

echo
echo
#cd $DBSEC_HOME/scripts
#./stop_cdb.sh

echo
echo
read -p "Press enter to close"


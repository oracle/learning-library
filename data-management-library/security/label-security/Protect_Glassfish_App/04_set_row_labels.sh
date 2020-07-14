#!/bin/bash

# keep track of script usage with a simple curl query
# the remote host runs nginx and uses a javascript function to mask your public ip address
# see here for details: https://www.nginx.com/blog/data-masking-user-privacy-nginscript/
#
file_path=`realpath "$0"`
curl -Is --connect-timeout 3 http://150.136.21.99:6868${file_path} > /dev/null


# 04_set_row_labels.sh

# generate an output based on the script name
outfile=$(basename -s .sh $0)".out"
#echo $outfile
rm -f $outfile 2>&1
exec > >(tee -a $outfile) 2>&1

$ORACLE_HOME/bin/sqlplus -s /nolog << EOF

set trimspool on;

set lines 180
set pages 999

set echo on;

-- Apply the policy to our table, EMPLOYEESEARCH_PROD.DEMO_HR_EMPLOYEES
prompt Now set the row labels in EMPLOYEESEARCH_PROD.DEMO_HR_EMPLOYEES

connect EMPLOYEESEARCH_PROD/Oracle123@pdb1

show user

update EMPLOYEESEARCH_PROD.demo_hr_employees set location = 'Germany' where location is null;

update EMPLOYEESEARCH_PROD.demo_hr_employees set olslabel = char_to_label('OLS_DEMO_HR_APP','P::GER') where location in ('Germany','Berlin');

update EMPLOYEESEARCH_PROD.demo_hr_employees set olslabel = char_to_label('OLS_DEMO_HR_APP','P::USA') where location in ('Costa Mesa','New York','Santa Clara','Sunnyvale');

update EMPLOYEESEARCH_PROD.demo_hr_employees set olslabel = char_to_label('OLS_DEMO_HR_APP','P::EU') where location in ('Paris','London');

update EMPLOYEESEARCH_PROD.demo_hr_employees set olslabel = char_to_label('OLS_DEMO_HR_APP','P::CAN') where location in ('Toronto');

commit;
exit
EOF


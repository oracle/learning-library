#!/bin/bash

# keep track of script usage with a simple curl query
# the remote host runs nginx and uses a javascript function to mask your public ip address
# see here for details: https://www.nginx.com/blog/data-masking-user-privacy-nginscript/
#
file_path=`realpath "$0"`
curl -Is --connect-timeout 3 http://150.136.21.99:6868${file_path} > /dev/null


# generate a log file for our script output
rm 06_query_employee_data.out 2>&1
exec > >(tee -a 06_query_employee_data.out) 2>&1

sqlplus employeesearch_prod/Oracle123@pdb1 <<EOF
--
set lines 110
set pages 9999
column firstname format a20
column corporate_card format a20
select firstname, sin, ssn, nino, corporate_card from demo_hr_employees where sin is not null and rownum < 6
union all
select firstname, sin, ssn, nino, corporate_card from demo_hr_employees where ssn is not null and rownum < 6
union all
select firstname, sin, ssn, nino, corporate_card from demo_hr_employees where nino is not null and rownum < 6;
exit;
EOF


#!/bin/bash

# generate an output based on the script name
outfile=$(basename -s .sh $0)".out"
#echo $outfile
rm -f $outfile 2>&1
exec > >(tee -a $outfile) 2>&1

echo
echo "Setup Traditional Auditing Policies..."
echo

$ORACLE_HOME/bin/sqlplus -s "/ as sysdba" <<EOF
set echo on

connect c##zeus/Oracle123@pdb1

-- Turn on auditing options

Audit alter any table by access;

Audit create any table by access;

Audit drop any table by access;

Audit Create any procedure by access;

Audit Drop any procedure by access;

Audit Alter any procedure by access;

Audit Grant any privilege by access;

Audit grant any object privilege by access;

Audit grant any role by access;

Audit audit system by access;

Audit create external job by access;

Audit create any job by access;

Audit create any library by access;

Audit create public database link by access;

Audit exempt access policy by access;

Audit alter user by access;

Audit create user by access;

Audit role by access;

Audit create session by access;

Audit drop user by access;

Audit alter database by access;

Audit alter system by access;

Audit alter profile by access;

Audit drop profile by access;

Audit database link by access;

Audit system audit by access;

Audit profile by access;

Audit public synonym by access;

Audit system grant by access;

Audit select on EMPLOYEESEARCH_PROD.DEMO_HR_EMPLOYEES by access;

--  FGA Policies
execute DBMS_FGA.DROP_POLICY(		-
object_schema => 'EMPLOYEESEARCH_PROD',			-
object_name   => 'DEMO_HR_EMPLOYEES',		-
policy_name   => 'chk_hr_emp');

rem Add FGA policy to detect any queries of salary info > $10,000

execute DBMS_FGA.ADD_POLICY(		-
object_schema => 'EMPLOYEESEARCH_PROD',			-
object_name   => 'DEMO_HR_EMPLOYEES',		-
policy_name   => 'chk_hr_emp',		-
audit_condition => 'salary>10000', 	-
audit_column => 'salary');


exit;
EOF



set echo on



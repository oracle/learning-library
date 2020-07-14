#!/bin/bash

# generate an output based on the script name
outfile=$(basename -s .sh $0)".out"
#echo $outfile
rm -f $outfile 2>&1
exec > >(tee -a $outfile) 2>&1


# The policy does not take effect until after the audited users log into the database instance. 
# In other words, if you create and enable a policy while the audited users are logged in
# then the policy cannot collect audit data;  the users must log out and then log in again before auditing can begin. 
# Once the session is set up with auditing for it, then the setting lasts 
# as long as the user session and then ends when the session ends.

echo
echo "Create a Unified Audit Policy to audit users accessing DEMO_HR_EMPLOYEES who are not EMPLOYEESEARCH_PROD."
echo 

sqlplus -s sys/Oracle123@pdb1 as sysdba << EOF
set pages 999
set lines 110
--
noaudit policy AUDIT_OUTSIDE_HR_APP;
drop audit policy AUDIT_OUTSIDE_HR_APP;
--
set echo on;
create audit policy AUDIT_OUTSIDE_HR_APP 
 ACTIONS select, update, insert, delete on EMPLOYEESEARCH_PROD.DEMO_HR_EMPLOYEES;
--
audit policy AUDIT_OUTSIDE_HR_APP except EMPLOYEESEARCH_PROD;
--
column audit_option format A20
column policy_name format A25
column entity_name format a25
column enabled_option format a20
--
select POLICY_NAME, AUDIT_OPTION, CONDITION_EVAL_OPT
  from AUDIT_UNIFIED_POLICIES
 where POLICY_NAME ='AUDIT_OUTSIDE_HR_APP';
--
SELECT policy_name, enabled_option, entity_name, success, failure
  FROM audit_unified_enabled_policies
  WHERE policy_name = 'AUDIT_OUTSIDE_HR_APP';
exit;
EOF

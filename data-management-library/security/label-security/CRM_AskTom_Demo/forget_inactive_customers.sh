#!/bin/bash

# keep track of script usage with a simple curl query
# the remote host runs nginx and uses a javascript function to mask your public ip address
# see here for details: https://www.nginx.com/blog/data-masking-user-privacy-nginscript/
#
file_path=`realpath "$0"`
curl -Is --connect-timeout 3 http://150.136.21.99:6868${file_path} > /dev/null

sqlplus -s lbac_super/Oracle123@pdb1 <<EOF

set pages 999
set lines 125
column country format a20
column char_label format a20
column active format a10
column old_label format a25
column new_label format a25

prompt
show user;

prompt
prompt Show what the new label will be for INACTIVE customers
select active, country, count(*) count_of_each, olslabel, label_to_char(olslabel) old_label, OLS_LEAST_UBOUND (olslabel,char_to_label('OLS_CRM_DEMO','D:FGT')) new_label
  from crm.customers
 where active = 'N'
group by active, country, olslabel, label_to_char(olslabel)
 order by active, country;

prompt
prompt Update the inactive users in CRM.CUSTOMERS 
prompt
prompt update crm.customers
prompt    set olslabel = to_data_label('OLS_CRM_DEMO',OLS_LEAST_UBOUND (olslabel,char_to_label('OLS_CRM_DEMO','D:FGT')))
prompt  where active = 'N';;

update crm.customers
   set olslabel = to_data_label('OLS_CRM_DEMO',OLS_LEAST_UBOUND (olslabel,char_to_label('OLS_CRM_DEMO','D:FGT')))
 where active = 'N';

prompt
prompt Show all row labels grouped by country
select active, country, count(*) count_of_each, olslabel, label_to_char(olslabel) old_label
  from crm.customers
group by active, country, olslabel, label_to_char(olslabel)
 order by active, country;

commit;

EOF


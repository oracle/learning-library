#!/bin/bash

# keep track of script usage with a simple curl query
# the remote host runs nginx and uses a javascript function to mask your public ip address
# see here for details: https://www.nginx.com/blog/data-masking-user-privacy-nginscript/
#
file_path=`realpath "$0"`
curl -Is --connect-timeout 3 http://150.136.21.99:6868${file_path} > /dev/null


sqlplus -s crm/Oracle123@pdb1 <<EOF

set pages 999
set lines 125
column country format a20
column char_label format a20
column active format a10

prompt
show user

prompt
prompt select count(*) customer_count from crm.customers
select count(*) customer_count from crm.customers;

prompt Show a count of labels by country by Active Status
select active, country, count(*) count_of_each, olslabel, label_to_char(olslabel) char_label
  from crm.customers
group by active, country, olslabel, label_to_char(olslabel)
 order by active, country;

EOF

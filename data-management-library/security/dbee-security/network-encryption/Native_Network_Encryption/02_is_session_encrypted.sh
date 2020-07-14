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
echo
echo "Query if there is a \"Encryption service adapter\" row in the query output:"
echo

sqlplus -s ${DBUSR_SYSTEM}/${DBUSR_PWD}@pdb1 <<EOF
BREAK ON SID SKIP PAGE ON SID
set lines 140
set pages 999
column username format a20
column auth_type format a10
column network_service_banner format a45
select a.sid, a.username, b.authentication_type as auth_type, regexp_substr(b.network_service_banner,'[^:]+',1,1 ) network_service_banner
  from V\$SESSION a
     , V\$SESSION_CONNECT_INFO b
 where a.sid = sys_context('userenv','sid')
   and a.sid = b.sid;

EOF
 

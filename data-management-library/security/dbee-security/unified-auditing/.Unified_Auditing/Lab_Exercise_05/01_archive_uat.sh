#!/bin/bash


# generate an output based on the script name
outfile=$(basename -s .sh $0)".out"
#echo $outfile
rm -f $outfile 2>&1
exec > >(tee -a $outfile) 2>&1


# keep track of script usage with a simple curl query
# the remote host runs nginx and uses a javascript function to mask your public ip address
# see here for details: https://www.nginx.com/blog/data-masking-user-privacy-nginscript/
#
file_path=`realpath "$0"`
curl -Is --connect-timeout 3 http://150.136.21.99:6868${file_path} > /dev/null


sqlplus -s sys/Oracle123@pdb1 as sysdba << EOF

SELECT COUNT(*) From UNIFIED_AUDIT_TRAIL;

BEGIN
 DBMS_AUDIT_MGMT.SET_LAST_ARCHIVE_TIMESTAMP ( AUDIT_TRAIL_TYPE => DBMS_AUDIT_MGMT.AUDIT_TRAIL_UNIFIED, LAST_ARCHIVE_TIME => sysdate);
END;
/

BEGIN
DBMS_AUDIT_MGMT.CLEAN_AUDIT_TRAIL( AUDIT_TRAIL_TYPE => DBMS_AUDIT_MGMT.AUDIT_TRAIL_UNIFIED, USE_LAST_ARCH_TIMESTAMP => FALSE);
END;
/

SELECT COUNT(*) FROM UNIFIED_AUDIT_TRAIL;

exit;

EOF

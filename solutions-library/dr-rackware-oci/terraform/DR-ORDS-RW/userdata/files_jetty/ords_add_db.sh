#!/bin/bash

# This script requires 3 arguments
# -p : target db's admin pw
# -i : target db's IP address, whether public or private is ok as long as it is reachable from compute isntance
# -s : target db's service name to connect

usage_exit() {
      echo "Usage: $CMDNAME -p VALUE -i VALUE -s VALUE" 1>&2
      echo "   -p: Target DB/PDB's Admin (SYS) password    " 1>&2
      echo "   -i: Listener's IP address for Target DB/PDB " 1>&2
      echo "   -s: Target DB/PDB's Service Name            " 1>&2
      echo "   -h: Showing this usage message" 1>&2
      exit 1
}

while getopts p:i:s:h OPT
do
  case $OPT in
    "p" ) FLG_P="TRUE" ; VALUE_PW="$OPTARG" ;;
    "i" ) FLG_I="TRUE" ; VALUE_IP="$OPTARG" ;;
    "s" ) FLG_S="TRUE" ; VALUE_SN="$OPTARG" ;;
    "h" ) usage_exit ;;
      * ) usage_exit ;;
  esac
done

if [ "$FLG_P" = "TRUE" ] && [ "$FLG_I" = "TRUE" ] && [ "$FLG_S" = "TRUE" ]; then
  echo "Required options are specified."
else
  echo "Required option is missing."
  usage_exit
fi

### Configure ords for the target database
# Set target DB's environment information
DBAdmPwd=${VALUE_PW}
DBSystemIP=${VALUE_IP}
DBSrv=${VALUE_SN}
DBName=`echo ${DBSrv} | awk -F. '{print $1}'`

### Debug
#echo $DBSystemIP
#echo $DBAdmPwd
#echo $DBSrv
#echo $DBName

# Check if ords is already setup or not.
ords_check=`sqlplus -s sys/"${DBAdmPwd}"@${DBSystemIP}/${DBSrv} as sysdba @ords_pu_check | sed -e '/^$/d' -e 's/^[ \t]*//'`
if [ "$ords_check" = "0" ]; then
  echo "ORDS has not configured for $DBName yet"
elif [ "$ords_check" = "1" ]; then
  echo "Found ORDS has been already configured for $DBName"
  exit
else
  echo "Found connection to $DBName or ORDS configuration for $DBName is something wrong. Exiting..."
  exit 1
fi

# Update password verify function - MOS 2408087.1
CURRENT_PW_VERIFY_FUNC=`sqlplus -s sys/"${DBAdmPwd}"@${DBSystemIP}/${DBSrv} as sysdba @pw_prof_chk|sed '/^$/d'`
cp pw_verify_base.sql pw_verify_back.sql
sed -i -e "s/ToBeUpdated_PW_VERIFY_FUNC/$CURRENT_PW_VERIFY_FUNC/g" pw_verify_back.sql
sqlplus -s sys/"${DBAdmPwd}"@${DBSystemIP}/${DBSrv} as sysdba @pw_verify_null

# Setup ords for target DB
cp ords_setup_base.exp ords_setup.exp
sed -i -e "s/ToBeUpdated_DBAdmPwd/${DBAdmPwd}/g" ords_setup.exp
sed -i -e "s/ToBeUpdated_DBSystemIP/${DBSystemIP}/g" ords_setup.exp
sed -i -e "s/ToBeUpdated_DBSrv/${DBSrv}/g" ords_setup.exp
sed -i -e "s/ToBeUpdated_DBName/${DBName}/g" ords_setup.exp

java -jar ords.war map-url --type base-path /${DBName} ${DBName}

expect ords_setup.exp

# Restore password verify function
sqlplus -s sys/"${DBAdmPwd}"@${DBSystemIP}/${DBSrv} as sysdba @pw_verify_back

# Add entries to defaults.xml
### nothing should be done this time

# Copy ords.war to Tomcat webapps directory if Tomcat is configured
ls -d /opt/apache-tomcat-*/webapps >/dev/null 2>&1
chk_result=`echo $?`
if [ $chk_result -eq 0 ]; then
  cp ords.war /opt/apache-tomcat-*/webapps
  ls -l /opt/apache-tomcat-*/webapps/ords.war
fi

# Cleanup
rm -rf ords_setup.exp pw_verify_back.sql

echo "ORDS for $DBName is configured."

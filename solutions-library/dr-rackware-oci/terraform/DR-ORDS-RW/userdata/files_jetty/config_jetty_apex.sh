#!/bin/bash

# This script requires 7 arguments
# Arg1 : Target db's admin pw
# Arg2 : Target db's IP address, whether public or private is ok as long as it is reachable from compute isntance
# Arg3 : Target db's service name to connect
# Arg4 : Compute IP address for ords
# Arg5 : Compute port for access for ords
# Arg6 : Object Storage URL for APEX zip file
# Arg7 : Install mode: 0(full development) or 1(runtime)

# Set Variables
DBAdmPwd=$1
DBSystemIP=$2
DBSrv=$3
DBName=`echo ${DBSrv} | awk -F. '{print $1}'`
ComIP=$4
ComPort=$5
URL_APEX_file=$6
if [ $7 -eq 0 ]; then
  MODE=full
elif [ $7 -eq 1 ]; then
  MODE=runtime
else
  echo "Arg for Install Option is not set properly, 7th arg: $7"
  exit 1
fi

### Configure APEX for the target database
# Update the scripts with the Compute Instance IP and port, give execution permmision to apex_add_db.sh
sed -i -e "s/ToBeUpdated_IPAddress/${ComIP}/g" -e "s/ToBeUpdated_Port/${ComPort}/g" apex_add_db.sh

# Download apex zip
curl -v -X GET -o apex.zip ${URL_APEX_file}

# Unzip downloaded file
unzip -q apex.zip

source $HOME/.bash_profile

# Update password verify function - MOS 2408087.1
CURRENT_PW_VERIFY_FUNC=`sqlplus -s sys/"${DBAdmPwd}"@${DBSystemIP}/${DBSrv} as sysdba @pw_prof_chk|sed '/^$/d'`
cp pw_verify_base.sql pw_verify_back.sql
sed -i -e "s/ToBeUpdated_PW_VERIFY_FUNC/$CURRENT_PW_VERIFY_FUNC/g" pw_verify_back.sql
sqlplus -s sys/"${DBAdmPwd}"@${DBSystemIP}/${DBSrv} as sysdba @pw_verify_null

# APEX installation to target db
cd apex
if ! tail apexins.sql | grep exit > /dev/null ; then
  echo "exit" >> apexins.sql
fi
if ! tail apxrtins.sql | grep exit > /dev/null ; then
  echo "exit" >> apxrtins.sql
fi

if [ "$MODE" = "full" ]; then
  sqlplus -s sys/"${DBAdmPwd}"@${DBSystemIP}/${DBSrv} as sysdba @apexins SYSAUX SYSAUX TEMP /i/
elif [ "$MODE" = "runtime" ]; then
  sqlplus -s sys/"${DBAdmPwd}"@${DBSystemIP}/${DBSrv} as sysdba @apxrtins SYSAUX SYSAUX TEMP /i/
else
  echo "Install Option is not set properly, MODE: ${MODE}"
  exit 1
fi

sqlplus -s sys/"${DBAdmPwd}"@${DBSystemIP}/${DBSrv} as sysdba @$HOME/config_apex1 ${DBAdmPwd}
if ! tail apex_rest_config_core.sql | grep exit > /dev/null ; then
  echo "exit" >> apex_rest_config_core.sql
fi
sqlplus -s sys/"${DBAdmPwd}"@${DBSystemIP}/${DBSrv} as sysdba @apex_rest_config_core ./ ${DBAdmPwd} ${DBAdmPwd}
sqlplus -s sys/"${DBAdmPwd}"@${DBSystemIP}/${DBSrv} as sysdba @$HOME/config_apex2
cd $HOME

# Restore password verify function
sqlplus -s sys/"${DBAdmPwd}"@${DBSystemIP}/${DBSrv} as sysdba @pw_verify_back

# Setup APEX for target DB
cp apex_setup_base.exp apex_setup.exp
sed -i -e "s/ToBeUpdated_DBAdmPwd/${DBAdmPwd}/g" apex_setup.exp
sed -i -e "s/ToBeUpdated_DBSystemIP/${DBSystemIP}/g" apex_setup.exp
sed -i -e "s/ToBeUpdated_DBSrv/${DBSrv}/g" apex_setup.exp
sed -i -e "s/ToBeUpdated_DBName/${DBName}/g" apex_setup.exp

expect apex_setup.exp

# Validate ords
cp ords_validate_base.exp ords_validate.exp
sed -i -e "s/ToBeUpdated_DBAdmPwd/${DBAdmPwd}/g" ords_validate.exp
sed -i -e "s/ToBeUpdated_DBSystemIP/${DBSystemIP}/g" ords_validate.exp
sed -i -e "s/ToBeUpdated_DBSrv/${DBSrv}/g" ords_validate.exp

expect ords_validate.exp

# Wait for 10 sec
sleep 10

# Restart ords as standalone
cd ~
./stop_ords.sh
./start_ords.sh

# Cleanup 
rm -rf apex_setup.exp ords_setup.exp ords_validate.exp pw_verify_back.sql
history -c

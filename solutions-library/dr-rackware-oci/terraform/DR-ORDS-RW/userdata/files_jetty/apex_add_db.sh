#!/bin/bash

# This script requires 3 arguments and 1 argument is optional
# -p : target db's admin pw
# -i : target db's IP address, whether public or private is ok as long as it is reachable from compute isntance
# -s : target db's service name to connect
# -m : APEX installation mode

usage_exit() {
      echo "Usage: $CMDNAME -p VALUE -i VALUE -s VALUE" 1>&2
      echo "   -p: Target DB/PDB's Admin (SYS) password [required]    " 1>&2
      echo "   -i: Listener's IP address for Target DB/PDB [required] " 1>&2
      echo "   -s: Target DB/PDB's Service Name [required]            " 1>&2
      echo "   -m: Installation mode, full(default) or runtime        " 1>&2
      echo "   -h: Showing this usage message" 1>&2
      exit 1
}

while getopts p:i:s:m:h OPT
do
  case $OPT in
    "p" ) FLG_P="TRUE" ; VALUE_PW="$OPTARG" ;;
    "i" ) FLG_I="TRUE" ; VALUE_IP="$OPTARG" ;;
    "s" ) FLG_S="TRUE" ; VALUE_SN="$OPTARG" ;;
    "m" ) FLG_M="TRUE" ; VALUE_IM="$OPTARG" ;;
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

### Check if an APEX file exists in HOME directory
if [ ! -d $HOME/apex ]; then
  echo "$HOME/apex directory is not found."
  echo "Please put the APEX zip file to HOME directory and unzip it, then retry."
  exit 1
fi 

### Configure APEX for the target database
# Set target DB's environment information
DBAdmPwd=${VALUE_PW}
DBSystemIP=${VALUE_IP}
DBSrv=${VALUE_SN}
DBName=`echo ${DBSrv} | awk -F. '{print $1}'`
if [ "$FLG_M" = "TRUE" ]; then
  MODE=`echo ${VALUE_IM} | tr '[:upper:]' '[:lower:]'`
else
  MODE=full
fi
if [ ! "$MODE" = "full" ] && [ ! "$MODE" = "runtime" ]; then
  echo "Install Option is not set properly."
  usage_exit
fi

### Debug
#echo $DBSystemIP
#echo $DBAdmPwd
#echo $DBSrv
#echo $DBName
#echo $MODE

# Check if ords is already setup or not.
ords_check=`sqlplus -s sys/"${DBAdmPwd}"@${DBSystemIP}/${DBSrv} as sysdba @ords_pu_check | sed -e '/^$/d' -e 's/^[ \t]*//'`
if [ "$ords_check" = "0" ]; then
  echo "ORDS has not configured for $DBName yet"
  ORDS_CONFIG=yet
elif [ "$ords_check" = "1" ]; then
  echo "Found ORDS has been already configured for $DBName"
else
  echo "Found connection to $DBName or ORDS configuration for $DBName is something wrong. Exiting..."
  exit 1
fi

# Check if APEX is already setup or not.
apex_inst_check=`sqlplus -s sys/"${DBAdmPwd}"@${DBSystemIP}/${DBSrv} as sysdba @apex_inst_check | sed -e '/^$/d' -e 's/^[ \t]*//'`
if [ ! "$apex_inst_check" = "no rows selected" ]; then
  echo "APEX has benn already configured for $DBName"
  exit
fi

# Update password verify function - MOS 2408087.1
CURRENT_PW_VERIFY_FUNC=`sqlplus -s sys/"${DBAdmPwd}"@${DBSystemIP}/${DBSrv} as sysdba @pw_prof_chk|sed '/^$/d'`
cp pw_verify_base.sql pw_verify_back.sql
sed -i -e "s/ToBeUpdated_PW_VERIFY_FUNC/$CURRENT_PW_VERIFY_FUNC/g" pw_verify_back.sql
sqlplus -s sys/"${DBAdmPwd}"@${DBSystemIP}/${DBSrv} as sysdba @pw_verify_null

# Setup ords for target DB
if [ "$ORDS_CONFIG" = "yet" ]; then
  cp ords_setup_base.exp ords_setup.exp
  sed -i -e "s/ToBeUpdated_DBAdmPwd/${DBAdmPwd}/g" ords_setup.exp
  sed -i -e "s/ToBeUpdated_DBSystemIP/${DBSystemIP}/g" ords_setup.exp
  sed -i -e "s/ToBeUpdated_DBSrv/${DBSrv}/g" ords_setup.exp
  sed -i -e "s/ToBeUpdated_DBName/${DBName}/g" ords_setup.exp

  java -jar ords.war map-url --type base-path /${DBName} ${DBName}

  expect ords_setup.exp
fi

# APEX installation to target db
cd apex
if [ ! -e apexins.sql ] || [ ! -e apxrtins.sql ]; then
  echo "APEX installation scripts were not found."
  exit 1
fi
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

ls -d /opt/apache-tomcat-*/webapps >/dev/null 2>&1
chk_result=`echo $?`
cd $HOME

# Copy ords.war to Tomcat webapps directory if Tomcat is configured
if [ $chk_result -eq 0 ]; then
  tomcat_dir=`ls -d /opt/apache-tomcat-*/webapps`
  if [ ! -d ${tomcat_dir}/i ]; then
    cp -r $HOME/apex/images ${tomcat_dir}/i
  fi
  cp ords.war ${tomcat_dir}
  ls -l ${tomcat_dir}/ords.war
fi

# Restart ords if ords is not running with apex mode
if [ ! $chk_result -eq 0 ]; then
  # Wait for 10 sec
  sleep 10
  if ! ps -ef | grep ords.war | grep -v grep | grep apex-images > /dev/null ; then
    ./stop_ords.sh
    ./start_ords.sh
  fi
fi

# Cleanup
rm -rf apex_setup.exp ords_setup.exp ords_validate.exp pw_verify_back.sql

if [ "$MODE" = "full" ]; then
  echo "Application Express for $DBName is configured."
  echo "   https://ToBeUpdated_IPAddress:ToBeUpdated_Port/ords/$DBName/"
elif [ "$MODE" = "runtime" ]; then
  echo "Application Express for $DBName is configured as Runtime mode."
fi

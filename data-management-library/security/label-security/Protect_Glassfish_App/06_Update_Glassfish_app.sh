#!/bin/bash

#06_Update_HRAPP_Glassfish_app.sh

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

export GL_HOME=${GLASSFISH_HOME}
export HRAPP_DIR=$GL_HOME/hr_prod_pdb1

#export CURR_DIR=`dirname "$(readlink -f "$0")"`
export CURR_DIR=$DBSEC_HOME/workshops/Database_Security_Labs/Label_Security/Protect_Glassfish_App
echo $CURR_DIR

echo
echo "These are the updated .jsp files we will be using"
echo

ls -al ${CURR_DIR}/hr_prod_pdb1_ols/*.jsp

echo
echo "We have added an additional call to the database to execute our set_ap_user_label procedure."
echo
sed -n '190,199p' hr_prod_pdb1_ols/search.jsp

echo
read -p "Press Enter when ready to continue..."
 
echo 
echo "Copying the files in to place..."
echo
cp ${CURR_DIR}/hr_prod_pdb1_ols/controller.jsp ${HRAPP_DIR}/controller.jsp
cp ${CURR_DIR}/hr_prod_pdb1_ols/employee_create.jsp ${HRAPP_DIR}/employee_create.jsp
cp ${CURR_DIR}/hr_prod_pdb1_ols/employee_view.jsp ${HRAPP_DIR}/employee_view.jsp
cp ${CURR_DIR}/hr_prod_pdb1_ols/search.jsp ${HRAPP_DIR}/search.jsp
cp ${CURR_DIR}/hr_prod_pdb1_ols/session_data.jsp ${HRAPP_DIR}/session_data.jsp

ls -alrt ${HRAPP_DIR}/*.jsp | tail -6

echo
read -p "Press Enter when ready to continue..."

echo
echo "Restarting the glassfish app..."
echo
#$GL_HOME/redeployAppGlassfish.sh
$GL_HOME/stopGlassfish.sh
$GL_HOME/startGlassfish.sh

echo 
echo "Now you should be able to login and see how we have updated our application to prevent application users from seeing data"
echo

read -p "Press return when complete. "

echo
echo "If you would like to follow along with the Glassfish log file you can do so by opening a terminal and executing: "
echo 
echo "tail -f ${GL_HOME}/glassfish/domains/domain1/logs/server.log"
echo
echo

read -p "Press return to exit lab script."

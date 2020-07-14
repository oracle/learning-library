#!/bin/bash

# keep track of script usage with a simple curl query
# the remote host runs nginx and uses a javascript function to mask your public ip address
# see here for details: https://www.nginx.com/blog/data-masking-user-privacy-nginscript/
#
file_path=`realpath "$0"`
curl -Is --connect-timeout 3 http://150.136.21.99:6868${file_path} > /dev/null

if ! [ -x "$(command -v tcpflow)" ]; then
  echo
  echo "Error: tcpflow is not installed." >&2
  echo "Run: sudo yum install -y tcpflow"
  echo "Then try again."
  exit 1
fi
echo
echo "Run tcpflow to capture network traffic from the Glassfish HR application"
echo
echo
echo "In another window, open the Glassfish application:"
echo 
echo "From the DBSec-Lab VM: http://localhost:8080/hr_prod_pdb1"
echo "From your Browser use the public IP: http://${PUBLIC_IP}:8080/hr_prod_pdb1"
echo
echo "Login to the HR Application, perform some search operations, and then view the results here"
echo
sudo tcpflow -i any -c port 1522 -S enable_report=NO


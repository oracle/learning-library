#!/bin/bash

# keep track of script usage with a simple curl query
# the remote host runs nginx and uses a javascript function to mask your public ip address
# see here for details: https://www.nginx.com/blog/data-masking-user-privacy-nginscript/
#
file_path=`realpath "$0"`
curl -Is --connect-timeout 3 http://150.136.21.99:6868${file_path} > /dev/null

echo 
echo "Run tcpdump in the background, monitoring port 1522"
echo
sudo tcpdump -nnvvXSs 1514 -i any '(port 1522) and (length > 74)' -w tcpdump.pcap &
sleep 5

echo 
echo "Execute SQL commands using PDB1 so we are on port 1522..."
echo

sqlplus system/Oracle123@pdb1 <<EOF
select firstname, lastname, salary, address_1 from employeesearch_prod.demo_hr_employees;
exit
EOF

sleep 6

echo 
echo "Interupt (kill) the tcpdump process..."
echo
#now interrupt the process.  get its PID:  
pid=$(ps -e | pgrep tcpdump)  
echo $pid  

#interrupt it:  
sleep 5
sudo kill -2 $pid

echo 
echo "View the output of our tcpdump file using strings..."
echo
strings tcpdump.pcap 

echo
echo 

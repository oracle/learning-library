#!/bin/bash

# This script requires 1 argument
# Arg1 : Compute FQDN (with customer's public domain)

# Set Variables 
ComFQDN=$1

### Setup Jetty with using CA certifiate
# Clean up self-signed Cert
rm -rf ~/conf/ords/standalone/self-signed*

# Update ords propaties
openssl pkcs8 -topk8 -inform PEM -outform PEM -nocrypt -in ~/.acme.sh/${ComFQDN}/${ComFQDN}.key        -out ~/conf/ords/standalone/${ComFQDN}.pkcs8.key
openssl pkcs8 -topk8 -inform PEM -outform DER          -in ~/conf/ords/standalone/${ComFQDN}.pkcs8.key  -out ~/conf/ords/standalone/${ComFQDN}.pkcs8.der -nocrypt
rm ~/conf/ords/standalone/${ComFQDN}.pkcs8.key
cp ~/.acme.sh/${ComFQDN}/${ComFQDN}.cer ~/conf/ords/standalone/
sed -i -e "s|ssl.cert=$|ssl.cert=$HOME/conf/ords/standalone/${ComFQDN}.cer|" ~/conf/ords/standalone/standalone.properties
sed -i -e "s|ssl.cert.key=$|ssl.cert.key=$HOME/conf/ords/standalone/${ComFQDN}.pkcs8.der|" ~/conf/ords/standalone/standalone.properties

# Restart ords as standalone
cd ~
./stop_ords.sh
./start_ords.sh

# Update URL for *_add_db.sh
for i in apex_add_db.sh
do
  IP=`grep https $HOME/${i}|awk -F: '{print $2}'|sed -e 's|//||'`
  sed -i -e "s/${IP}/${ComFQDN}/g" $HOME/${i}
done

# Cleanup 
history -c

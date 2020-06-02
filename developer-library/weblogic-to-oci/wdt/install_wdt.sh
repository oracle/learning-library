WLSDT_VERSION=1.7.3
curl -LO https://github.com/oracle/weblogic-deploy-tooling/releases/download/weblogic-deploy-tooling-${WLSDT_VERSION}/weblogic-deploy.zip 
unzip weblogic-deploy.zip
rm weblogic-deploy.zip

# make the scripts executable
chmod +x weblogic-deploy/bin/*.sh

weblogic-deploy/bin/updateDomain.sh \
-oracle_home $MW_HOME \
-domain_home $DOMAIN_HOME \
-model_file source.yaml \
-variable_file source.properties \
-archive_file source.zip \
-admin_user weblogic \
-admin_url t3://$(hostname -i):9071


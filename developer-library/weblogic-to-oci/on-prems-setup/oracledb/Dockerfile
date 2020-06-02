# wrapping this image to get access to some more dependencies needed to use rman and Database Cloud Module
FROM container-registry.oracle.com/database/enterprise:12.2.0.1

LABEL maintainer='Emmanuel Leroy <emmanuel.leroy@oracle.com>'

USER root
# openssl is required to create a wallet for OCI connection. zip is required to package the wallet and port it to the target DB
RUN yum install -y openssl nano zip

USER oracle
# set JAVA_HOME and PATH to run java without issues
ENV JAVA_HOME=$ORACLE_HOME/jdk
ENV PATH=$PATH:$JAVA_HOME/bin
# ORACLE_SID is updated by the init container, so we need to update it from env.
ENV ORACLE_SID=$DB_SID

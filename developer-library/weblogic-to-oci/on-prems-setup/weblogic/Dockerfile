#
# Copyright (c) 2014-2018 Oracle and/or its affiliates. All rights reserved.
#
#
#Licensed under the Universal Permissive License v 1.0 as shown at http://oss.oracle.com/licenses/upl.
#
# ORACLE DOCKERFILES PROJECT
# --------------------------
# This Dockerfile extends the Oracle WebLogic image in DockerStore
# configures a Data Source using WLST online to connect to an Oracle DB
# container from DockerStore
#
# REQUIRED FILES TO BUILD THIS IMAGE
# ----------------------------------
#
# HOW TO BUILD THIS IMAGE
# -----------------------
# Put all downloaded files in the same directory as this Dockerfile
# Run:
#      $ sudo docker build -t 12212-oradb-wlsstore .
#

# Pull base image
# ---------------
FROM store/oracle/weblogic:12.2.1.4

ARG DOMAIN_NAME=base_domain

# Maintainer
# ----------
LABEL maintainer='Emmanuel Leroy <emmanuel.leroy@oracle.com>'

# Environment variables required for this build (do NOT change)
# -------------------------------------------------------------
ENV MW_HOME="$ORACLE_HOME" \
    PATH=$PATH:/u01/oracle:$DOMAIN_HOME \
    DOMAIN_HOME=/u01/oracle/user_projects/domains/${DOMAIN_NAME}

# COPY environment variable file and export them locally.
COPY ./env /u01/oracle/env
RUN `cat /u01/oracle/env | awk '{printf "export %s\n",$1}'` \
    && env | sort

USER root
RUN yum install -y zip nano openssh-clients

# Copy scripts and apps
# --------------------------------
COPY scripts/*  /u01/oracle/
RUN chmod +xr /u01/oracle/*.sh
# propagate environment to the root user & create the datasource properties file from template.
RUN `cat /u01/oracle/env | awk '{printf "export %s\n",$1}'` \ 
    && cat /u01/oracle/oradatasource.tpl | sed 's/"/\\\"/g;s/.*/echo "&"/e' > /u01/oracle/oradatasource.properties \
    && cat /u01/oracle/oradatasource.properties

# Installation of Supplemental Quick Installer
# --------------------------------------------
USER oracle
# propagate environment to the oracle user and create the domain, then deploy datasource and app
RUN cd /u01/oracle \
    && `cat /u01/oracle/env | awk '{printf "export %s\n",$1}'` \
    && ./create_domain.sh \
    && ./deploy.sh 

EXPOSE $ADMIN_PORT
WORKDIR $DOMAIN_HOME

CMD ["/u01/oracle/startNMWebLogic.sh"]

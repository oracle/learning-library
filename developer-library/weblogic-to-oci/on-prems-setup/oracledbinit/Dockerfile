FROM store/oracle/database-instantclient:12.2.0.1

LABEL maintainer='Emmanuel Leroy <emmanuel.leroy@oracle.com>'

# Database initialization scripts, provisioning the PDB, creating schema, etc...
COPY ./scripts /home/oracle/

WORKDIR /home/oracle/

CMD ./setup.sh
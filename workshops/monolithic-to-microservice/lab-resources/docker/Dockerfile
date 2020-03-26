FROM        java:8-jdk

ENV         JAVA_HOME         /usr/lib/jvm/java-8-openjdk-amd64
ENV         GLASSFISH_HOME    /usr/local/glassfish4
ENV         PATH              $PATH:$JAVA_HOME/bin:$GLASSFISH_HOME/bin
ENV         TNS_ADMIN         /usr/local/wallet_DB/

RUN         echo "deb [check-valid-until=no] http://archive.debian.org/debian jessie-backports main" > /etc/apt/sources.list.d/jessie-backports.list
RUN         sed -i '/deb http:\/\/deb.debian.org\/debian jessie-updates main/d' /etc/apt/sources.list

RUN         apt-get -o Acquire::Check-Valid-Until=false update && \
            apt-get install -y curl unzip zip inotify-tools && \
            rm -rf /var/lib/apt/lists/*

#download and install the glassfish server
RUN         curl -L -o /tmp/glassfish-4.1.zip https://download.oracle.com/glassfish/4.1.1/release/glassfish-4.1.1.zip && \
            unzip /tmp/glassfish-4.1.zip -d /usr/local && \
            rm -rf /usr/local/glassfish4/glassfish/domains/domain1/osgi-cache/felix && \
#           rm -rf /usr/local/glassfish4/glassfish/modules/jackson* && \
            rm -f /tmp/glassfish-4.1.zip && \
            mkdir /usr/local/wallet_DB && \
            mkdir /usr/local/alpha

#clone and deploy the project on the glassfish server
#COPY     AlphaProductCatalog.war /usr/local/glassfish4/glassfish/domains/domain1/autodeploy/AlphaProductCatalog.war
COPY AlphaProductsRestService.war /usr/local/alpha
COPY Wallet_orcl.zip /usr/local/wallet_DB

RUN         unzip /usr/local/wallet_DB/Wallet_orcl.zip -d /usr/local/wallet_DB/ && \
            cd /usr/local/alpha && \
            jar xvf /usr/local/alpha/AlphaProductsRestService.war && \
            rm /usr/local/alpha/AlphaProductsRestService.war

COPY sqlnet.ora /usr/local/wallet_DB
COPY glassfish_module/* /usr/local/glassfish4/glassfish/modules/

EXPOSE      8080

WORKDIR     /usr/local/glassfish4

# verbose causes the process to remain in the foreground
CMD         asadmin start-domain --verbose

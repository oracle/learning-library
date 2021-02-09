#!/bin/bash

#check the docker status
systemctl status docker

#check Docker images
docker images

#check docker Container
docker ps -a

Application=$(docker ps -aqf "name=CShopApplication")
ApplicationApi=$(docker ps -aqf "name=CshopApplicationAPI")

docker stop $Application $ApplicationApi
docker container rm $Application $ApplicationApi

#echo "Please Provide the ADB instance name"
#read ADB_DB

#unzip the Wallet
FILE=/u01/script/wallet/tnsnames.ora
if [ -f "$FILE" ]; then
    echo "$FILE exists."
else 
    echo "$FILE does not exist."
	mkdir /u01/script/wallet
	unzip /home/oracle/converged-wallet.zip -d /u01/script/wallet
	cd /u01/script/
	chmod -R 775 wallet/
	cd wallet/
	sed -i -e s%\"?/network/admin\"%\${TNS_ADMIN}% sqlnet.ora
fi


#docker pull images
docker pull us-ashburn-1.ocir.io/orasenatdpltsecitom03/converged_db_atp/convergedbappatp:latest
docker pull us-ashburn-1.ocir.io/orasenatdpltsecitom03/converged_db_atp/convergedbapiatp:latest

#check Docker images
docker images

#Run the images
docker run -it -d --restart always --name CShopApplication -p 3000:3000 us-ashburn-1.ocir.io/orasenatdpltsecitom03/converged_db_atp/convergedbappatp:latest
docker run -it -d --restart always --name CshopApplicationAPI -p 3001:3001 us-ashburn-1.ocir.io/orasenatdpltsecitom03/converged_db_atp/convergedbapiatp:latest

Application=$(docker ps -aqf "name=CShopApplication")
ApplicationApi=$(docker ps -aqf "name=CshopApplicationAPI")
docker cp /u01/script/wallet $Application:Convergedb/ConvergeDBAppNew/database/wallet/
docker cp /u01/script/wallet $ApplicationApi:ConvergedbAPI/ConvergeDBAppAPI/database/wallet/

#work in Progress ( if the service name will same everytime , Then not required below steps )

#Hostname=$ADB_DB"_high"
#docker exec -it $Application /bin/bash -c "cd /Convergedb/ConvergeDBAppNew/database/ && sed -i -e s/"convergedkay_high"/"$Hostname"/g config.js && sed -i -e s/"convergedkay_high"/"$Hostname"/g configSpatial.js && sed -i -e s/"convergedkay_high"/"$Hostname"/g analytics.js"
#docker exec -it $ApplicationApi /bin/bash -c "cd /ConvergedbAPI/ConvergeDBAppAPI/database/ && sed -i -e s/"convergedkay_high"/"$Hostname"/g config.js && sed -i -e s/"convergedkay_high"/"$Hostname"/g configSpatial.js"


#Start the application
docker exec -it $Application /bin/bash -c "source ~/.bash_profile && cd /Convergedb/ConvergeDBAppNew/ && pm2 start index.js --name ApplicationNodejs"
docker exec -it $ApplicationApi /bin/bash -c "source ~/.bash_profile && cd /ConvergedbAPI/ConvergeDBAppAPI/ && pm2 start index.js --name ApplicationApi"

#check docker Container
docker ps -a

#OUTPUT
#echo check the Application Url on Browser http://$Hostname:3000/
#echo check the ApplicationAPI Url on Browser http://$Hostname:3001/products


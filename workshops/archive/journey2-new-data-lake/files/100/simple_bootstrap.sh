#!/bin/bash

echo "Demonstration bootstrap for Big Data Cloud"

# use the BDC bootstrap APIs to get the name of the default Storage Container
default_container=$(getDefaultContainer)


#  setup sudo for zeppelin
echo "setting up sudoers for zeppelin"
echo 'zeppelin  ALL=(ALL)  NOPASSWD: ALL' >> /etc/sudoers


# Install some extra tools.  In this case, install the mlocate yum package
echo "installing mlocate"
yum install -y mlocate
updatedb



# import notebooks
# https://zeppelin.apache.org/docs/0.7.0/rest-api/rest-notebook.html#import-a-note
echo "importing lab notebooks"
mkdir /tmp/notebooks
cd /tmp/notebooks
# download a zip file of notebooks
wget -nc https://github.com/millerhoo/journey2-new-data-lake/raw/master/workshops/journey2-new-data-lake/files/Notes.zip

# unzip the zip
unzip Notes.zip

# do search/replace as needed.  Here we change the hard-coded container name journeyC to the actual container name for this cluster
sed -i -- "s/journeyC/$default_container/g" *.json

# loop through the notebooks and import them
for note in /tmp/notebooks/*.json
do
  echo $note
  curl -X POST -d @"$note" -H "Content-Type: application/json" http://127.0.0.1:9995/api/notebook/import
done


echo "done with bootstrap"

# Log file when this runs will be copied up to your default container.
# Can also be viewed on the bdcsce server via: cat /u01/bdcsce/data/var/log/bootstrap.*
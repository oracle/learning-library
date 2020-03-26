#!/bin/bash

echo "Running bootstrap for Big Data User Journeys"

# check to see if we are running this manually (DOMAINID will be set)
#if [[ -z "$DOMAINID" ]]
#then
#  echo Did not detect DOMAINID.  This is being run automatically.
  default_container=$(getDefaultContainer)
  objectStoreURL=$(getBaseObjectStoreUrl)
#else
#  echo Detected DOMAINID=$DOMAINID.  This is being run manually.
# NOTE WE NO LONGER SUPPORT RUNNING THIS MANUALLY.  TOO MANY POTENTIAL USER ERRORS.  JUST FOLLOW THE INSTRUCTIONS AND CREATE A NEW BDC INSTANCE
#  echo CONTAINER=$CONTAINER
#  default_container=$CONTAINER
#  default_full_container=Storage-$DOMAINID/$CONTAINER
#  objectStoreURL=swift://$CONTAINER.default
#fi


#  setup sudo for zeppelin
echo "setting up sudoers for zeppelin"
echo 'zeppelin  ALL=(ALL)  NOPASSWD: ALL' >> /etc/sudoers
echo "last 10 lines of /etc/sudoers"
tail -10 /etc/sudoers



# making utility script
echo "setting up object_store_env.sh"
echo "export CONTAINER=$default_container" > ~zeppelin/object_store_env.sh
echo "export OBJECT_STORE=$objectStoreURL" >> ~zeppelin/object_store_env.sh
chown zeppelin ~zeppelin/object_store_env.sh
chmod u+x ~zeppelin/object_store_env.sh

# delete 2 sample notebooks as we have newer ones
echo "Deleting 2 sample notebooks as we provide newer ones"
cat <<EOF > /tmp/delete_notebooks.py
#!/usr/local/bin/python
#based on https://community.hortonworks.com/articles/36031/sample-code-to-automate-interacting-with-zeppelin.html by Ali Bajwa
def delete_request(url):
  import json, urllib2
  req = urllib2.Request(str(url))
  req.get_method = lambda: 'DELETE'
  try:
    response = urllib2.urlopen(req).read()
  except urllib2.HTTPError, error:
    print 'Exception: ' + error.read()
  jsonresp = json.loads(response.decode('utf-8'))
  print jsonresp['status']


import json, urllib2
zeppelin_int_url = 'http://127.0.0.1:9995/api/notebook/'
data = json.load(urllib2.urlopen(zeppelin_int_url))
for body in data['body']:
  if body['name'] == ' Tutorial 1 Notebook Basics':
    body1 = body
    delete_request(zeppelin_int_url + body1['id'])
  elif body['name'] == ' Tutorial 2 Working with the Object Store and HDFS':
    body2 = body
    delete_request(zeppelin_int_url + body2['id'])
EOF
python /tmp/delete_notebooks.py


# import notebooks
# https://zeppelin.apache.org/docs/0.7.0/rest-api/rest-notebook.html#import-a-note
echo "importing lab notebooks"
mkdir /tmp/notebooks
cd /tmp/notebooks
wget -nc https://github.com/millerhoo/journey2-new-data-lake/raw/master/workshops/journey2-new-data-lake/files/Notes.zip
unzip Notes.zip
sed -i -- "s/journeyC/$default_container/g" *.json
for note in /tmp/notebooks/*.json
do
  echo $note
  curl -X POST -d @"$note" -H "Content-Type: application/json" http://127.0.0.1:9995/api/notebook/import
done

# fix sh interpreter timeout and spark kafka dependency
# https://zeppelin.apache.org/docs/0.7.0/rest-api/rest-interpreter.html
echo "fixing sh interpreter timeout and spark kafka dependency"
cat <<EOF > /tmp/sh_settings.py
#!/usr/local/bin/python
#based on https://community.hortonworks.com/articles/36031/sample-code-to-automate-interacting-with-zeppelin.html by Ali Bajwa
def post_request(url, body):
  import json, urllib2
  encoded_body = json.dumps(body)
  req = urllib2.Request(str(url), encoded_body)
  req.get_method = lambda: 'PUT'
  try:
    response = urllib2.urlopen(req, encoded_body).read()
  except urllib2.HTTPError, error:
    print 'Exception: ' + error.read()
  jsonresp = json.loads(response.decode('utf-8'))
  print jsonresp['status']
        
 
 
import json, urllib2
zeppelin_int_url = 'http://127.0.0.1:9995/api/interpreter/setting/'
data = json.load(urllib2.urlopen(zeppelin_int_url))
for body in data['body']:
  if body['group'] == 'sh':
    shbody = body
  elif body['group'] == 'spark':
    sparkbody = body    
    

 
 
shbody['properties']['shell.command.timeout.millisecs'] = '3000000'
post_request(zeppelin_int_url + shbody['id'], shbody)

my_dict = {'groupArtifactVersion':  'org.apache.spark:spark-streaming-kafka-0-8_2.11:2.1.0',       'local': False}
sparkbody['dependencies'].append(my_dict)
post_request(zeppelin_int_url + sparkbody['id'], sparkbody)
EOF
#cat /tmp/sh_settings.py
python /tmp/sh_settings.py

#  clean yum
echo "cleaning up yum metadata just in case"
yum clean metadata

# install helper tool: locate
echo "installing mlocate"
yum install -y mlocate
updatedb

echo "done with bootstrap for Big Data User Journeys"

# Log file when this runs will be copied up to your default container.
# Can also be viewed on the bdcsce server via: cat /u01/bdcsce/data/var/log/bootstrap.*
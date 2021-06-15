#
# log-to-adw-with-ords-and-fn version 1.0.
#
# Copyright (c) 2021 Oracle, Inc.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.
#
# Oracle Database Development Tools Group and Gregory Verstraeten
# 

import io
import json
import logging
import requests
import base64
import sys
import oci

from fdk import response


# Use the secrets service to get the password for the DB
def read_secret_value(signer, secret_id):
    
    secret_client = oci.secrets.SecretsClient(config={}, signer=signer)
    
    response = secret_client.get_secret_bundle(secret_id)

    base64_Secret_content = response.data.secret_bundle_content.content
    base64_secret_bytes = base64_Secret_content.encode('ascii')
    base64_message_bytes = base64.b64decode(base64_secret_bytes)
    secret_content = base64_message_bytes.decode('ascii')

    return secret_content

# soda_insert uses the Autonomous Database REST API to insert JSON documents
def soda_insert(ordsbaseurl, dbschema, dbuser, dbpwd, collection, logentries):
    auth=(dbuser, dbpwd)
    sodaurl = ordsbaseurl + dbschema + '/soda/latest/'
    bulkinserturl = sodaurl + 'custom-actions/insert/' + collection + "/"
    headers = {'Content-Type': 'application/json'}
    resp = requests.post(bulkinserturl, auth=auth, headers=headers, data=json.dumps(logentries))
    return resp.json()

def handler(ctx, data: io.BytesIO=None):
    signer = oci.auth.signers.get_resource_principals_signer()
    logger = logging.getLogger()
    logger.info("function start")

    # Retrieving the Function configuration values
    try:
        cfg = dict(ctx.Config())
        ordsbaseurl = cfg["ords_base_url"]
        dbschema = cfg["db_schema"]
        dbuser = cfg["db_user"]
        secret_ocid = cfg["secret_ocid"]
        collection = cfg["collection"]
    except:
        logger.error('Missing configuration keys: ords_base_url, db_schema, db_user, secret_ocid and collection')
        raise
    
    # Retrieving the log entries from Service Connector Hub as part of the Function payload
    try:
        logentries = json.loads(data.getvalue())
        if not isinstance(logentries, list):
            raise ValueError
    except:
        logger.error('Invalid payload')
        raise
    
    # The log entries are in a list of dictionaries. We can iterate over the the list of entries and process them.
    # For example, we are going to put the Id of the log entries in the function execution log
    logger.info("Processing the following LogIds:")
    for logentry in logentries:
        logger.info(logentry["oracle"]["logid"])

    # Now, we are inserting the log entries in the JSON Database
    secret_content = read_secret_value(signer, secret_ocid)    
    resp = soda_insert(ordsbaseurl, dbschema, dbuser, secret_content, collection, logentries)
    logger.info(resp)
    if "items" in resp:
        logger.info("Logs are successfully inserted")
        logger.info(json.dumps(resp))
    else:
        raise Exception("Error while inserting logs into the database: " + json.dumps(resp))

    # The function is done, we don't return any response because it would be useless
    logger.info("function end")
    return response.Response(
        ctx, 
        response_data="",
        headers={"Content-Type": "application/json"}
    )
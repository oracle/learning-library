#
# oci-load-file-into-adw-python version 1.0.
#
# Copyright (c) 2020 Oracle, Inc.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.
#

import io
import json
import oci
import csv
import requests

from fdk import response


def csv_insert(ordsbaseurl, schema, dbuser, dbpwd, document):
    auth=(dbuser, dbpwd)
    batchurl = ordsbaseurl + schema + '/region/batchload?batchRows=5000&errorsMax=20'
    headers = {'Content-Type': 'text/csv'}
    r = requests.post(batchurl, auth=auth, headers=headers, data=document.data.text)

def load_data(signer, namespace, bucket_name, object_name, ordsbaseurl, schema, dbuser, dbpwd):
    client = oci.object_storage.ObjectStorageClient(config={}, signer=signer)
    try:
        print("INFO - About to read object {0} in bucket {1}...".format(object_name, bucket_name), flush=True)
        # we assume the file can fit in memory, otherwise we have to use the "range" argument and loop through the file
        csvdata = client.get_object(namespace, bucket_name, object_name)
        if csvdata.status == 200:
             insert_status = csv_insert(ordsbaseurl, schema, dbuser, dbpwd, csvdata)
        else:
            raise SystemExit("cannot retrieve the object" + str(object_name))
    except Exception as e:
        raise SystemExit(str(e))
    print("INFO - All documents are successfully loaded into the database", flush=True)


def move_object(signer, namespace, source_bucket, destination_bucket, object_name):
    objstore = oci.object_storage.ObjectStorageClient(config={}, signer=signer)
    objstore_composite_ops = oci.object_storage.ObjectStorageClientCompositeOperations(objstore)
    resp = objstore_composite_ops.copy_object_and_wait_for_state(
        namespace, 
        source_bucket, 
        oci.object_storage.models.CopyObjectDetails(
            destination_bucket=destination_bucket, 
            destination_namespace=namespace,
            destination_object_name=object_name,
            destination_region=signer.region,
            source_object_name=object_name
            ),
        wait_for_states=[
            oci.object_storage.models.WorkRequest.STATUS_COMPLETED,
            oci.object_storage.models.WorkRequest.STATUS_FAILED])
    if resp.data.status != "COMPLETED":
        raise Exception("cannot copy object {0} to bucket {1}".format(object_name,destination_bucket))
    else:
        resp = objstore.delete_object(namespace, source_bucket, object_name)
        print("INFO - Object {0} moved to Bucket {1}".format(object_name,destination_bucket), flush=True)


def handler(ctx, data: io.BytesIO=None):
    signer = oci.auth.signers.get_resource_principals_signer()
    object_name = bucket_name = namespace = ordsbaseurl = schema = dbuser = dbpwd = ""
    try:
        cfg = ctx.Config()
        input_bucket = cfg["input_bucket"]
        processed_bucket = cfg["processed_bucket"]
        ordsbaseurl = cfg["ords_base_url"]
        schema = cfg["db_schema"]
        dbuser = cfg["db_user"]
        dbpwd = cfg["dbpwd_cipher"]
    except Exception as e:
        print('Missing function parameters: bucket_name, ordsbaseurl, schema, dbuser, dbpwd', flush=True)
        raise
    try:
        body = json.loads(data.getvalue())
        print("INFO - Event ID {} received".format(body["eventID"]), flush=True)
        print("INFO - Object name: " + body["data"]["resourceName"], flush=True)
        object_name = body["data"]["resourceName"]
        print("INFO - Bucket name: " + body["data"]["additionalDetails"]["bucketName"], flush=True)
        if body["data"]["additionalDetails"]["bucketName"] != input_bucket:
            raise ValueError("Event Bucket name error")
        print("INFO - Namespace: " + body["data"]["additionalDetails"]["namespace"], flush=True)
        namespace = body["data"]["additionalDetails"]["namespace"]
    except Exception as e:
        print('ERROR: bad Event!', flush=True)
        raise
    load_data(signer, namespace, input_bucket, object_name, ordsbaseurl, schema, dbuser, dbpwd)
    move_object(signer, namespace, input_bucket, processed_bucket, object_name)

    return response.Response(
        ctx, 
        response_data=json.dumps({"status": "Success"}),
        headers={"Content-Type": "text/csv"}
    )
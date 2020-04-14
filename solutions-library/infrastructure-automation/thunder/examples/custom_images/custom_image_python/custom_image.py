import oci
import time
from datetime import datetime, timedelta
from datetime import date
import argparse
from oci.config import from_file
from oci.config import validate_config

# Args parser configuration
parser = argparse.ArgumentParser(formatter_class=argparse.RawTextHelpFormatter, 
                description="Create and move image(s) to other region.")

parser.add_argument("-compartment", dest="compartment_name", type=str, required=True,
                help="The compartment name in which the instances from which you want to create and move the images reside. \n")

parser.add_argument("-destination_region", dest="destination_region", type=str, required=True,
                help="The region in which the image(s) will be moved.\n")

parser.add_argument("-instances", dest="list_of_instances", nargs='+', required=True,
                help="The names of the instances from which images will be created and moved to destination region. \n")

args = parser.parse_args()

def spawn_config(destination_region, config):
    if destination_region:
        config["region"]      =  destination_region
        compute_client        =  oci.core.ComputeClient(config)
        identity_client       =  oci.identity.IdentityClient(config)
        vcn_client            =  oci.core.VirtualNetworkClient(config)
        object_storage_client =  oci.object_storage.ObjectStorageClient(config)
    else:
        compute_client        =  oci.core.ComputeClient(config)
        identity_client       =  oci.identity.IdentityClient(config)
        vcn_client            =  oci.core.VirtualNetworkClient(config)
        object_storage_client =  oci.object_storage.ObjectStorageClient(config)
    return compute_client, identity_client, vcn_client, object_storage_client

def check_status(wait_time, state, list_of_instances, compartment_params):
    compute_client, identity_client, vcn_client, object_storage_client = spawn_config(None, config)
    i = 0
    while True:
        print("[INFO] Image(s) %s, pending..."%(state))
        time.sleep(wait_time)
        imgs = compute_client.list_images(compartment_params[0]["comp_id"]).data
        for img in imgs:
            if img.lifecycle_state == "AVAILABLE" and img.display_name in list_of_instances:
                i = i + 1
        if i == len(list_of_instances):
            print("[INFO] Image(s) available! Moving on...\n")
            break
        else:
            i = 0

def create_image (compartment_name, config, list_of_instances):
    compute_client, identity_client, vcn_client, object_storage_client = spawn_config(None, config)
    compartments       = oci.pagination.list_call_get_all_results(identity_client.list_compartments, config["tenancy"], compartment_id_in_subtree=True).data
    compartment_params = [{"comp_id": compartment.id, "comp_name": compartment.name} for compartment in compartments if compartment.lifecycle_state != "DELETED" if compartment.name == compartment_name]
    if len(compartment_params) == 0:
        print("[INFO] There is no compartment with the name %s in the tenancy\nExiting..." %(compartment_name))
        exit(1)

    instances_list  = compute_client.list_instances(compartment_params[0]["comp_id"]).data
    instances_params = [{"instance_id": instance.id, "display_name": instance.display_name} for instance in instances_list if instance.lifecycle_state == "RUNNING" if instance.display_name in list_of_instances]
    if len(instances_params) == 0:
        print("[INFO] There is/are no instance(s) with the name %s in the compartment\nExiting..." %(list_of_instances))
        exit(1)
    if len(instances_params) < len(list_of_instances):
        print("[INFO] Not all instances introduced exist in the compartment. \nOnly the following instances are valid:")
        for instance in instances_params:
            print("- %s"%(instance["display_name"]))
        print("\n[INFO] Exiting...")
        exit(1)

    img_list = []
    print("\n[INFO] Instances from which images will be created: ")
    for instance in instances_params:
        print("Instance name:",instance["display_name"])
        image_details = oci.core.models.CreateImageDetails(
            compartment_id      = compartment_params[0]["comp_id"],
            display_name        = instance["display_name"],
            instance_id         = instance["instance_id"]
        )
        images = compute_client.create_image(image_details).data
        img_list.append(images)

    images_list = [{"image_id": image.id, "image_name": image.display_name, "state": image.lifecycle_state} for image in img_list]

    print("\n[INFO] Created images - details:\n ")      
    for image in images_list:
        print("display_name: %s\nlifecycle_state: %s\n" %(image["image_name"],image["state"]))
    
    return compartment_params, images_list

def create_bucket(compartment_params, config):
    compute_client, identity_client, vcn_client, object_storage_client = spawn_config(None, config)
    tenancy_id = config["tenancy"]
    namespace  = identity_client.get_tenancy(tenancy_id).data.name
    print("[INFO] Creating bucket...")
    bucket_name = "images_bucket"
    bucket_details = oci.object_storage.models.CreateBucketDetails(
        compartment_id = compartment_params[0]["comp_id"],
        name           = bucket_name
    )

    object_storage_client.create_bucket(namespace,bucket_details).data
    print("[INFO] Bucket created! Moving on...\n")

    return namespace

def export_image(images_list, config, namespace):
    compute_client, identity_client, vcn_client, object_storage_client = spawn_config(None, config)

    for image in images_list:
        export_details = oci.core.models.ExportImageViaObjectStorageTupleDetails(
            bucket_name      = "images_bucket",
            destination_type = "objectStorageTuple",
            namespace_name   = namespace,
            object_name      = image["image_name"]
        )
        compute_client.export_image(image["image_id"], export_details)

def create_par (list_of_instances, config, namespace):
    compute_client, identity_client, vcn_client, object_storage_client = spawn_config(None, config)
    print("[INFO] Creating PAR...\n")
    today = date.today()
    par_expire_time = (datetime.now() + timedelta(hours=1)).strftime('%H:%M:%S')
    current_date    = today.strftime("%Y-%m-%d")

    objects = object_storage_client.list_objects(namespace, "images_bucket").data
    pars_list = []
    for obj in objects.objects:
        if obj.name in list_of_instances:
            par_details = oci.object_storage.models.CreatePreauthenticatedRequestDetails(
                access_type  = "ObjectReadWrite",
                name         = obj.name,
                object_name  = obj.name,
                time_expires = "%sT%s.52Z"%(current_date,par_expire_time)
            )
            par_data = object_storage_client.create_preauthenticated_request(namespace,"images_bucket",par_details).data
            pars_list.append(par_data)

    return pars_list

def import_image (compartment_params, pars_list, list_of_instances, destination_region, config):
    current_region = config["region"]
    compute_client, identity_client, vcn_client, object_storage_client = spawn_config(destination_region, config)

    for par in pars_list:
        if par.name in list_of_instances:
            source_uri = "https://objectstorage.%s.oraclecloud.com%s"%(current_region,par.access_uri)
            ImageSourceDetails = oci.core.models.ImageSourceViaObjectStorageUriDetails(
                source_uri   = source_uri,
                source_type  = "objectStorageUri"
            )

            create_image_details = oci.core.models.CreateImageDetails(
                compartment_id       = compartment_params[0]["comp_id"],
                image_source_details = ImageSourceDetails,
                display_name         = par.name
                )

            import_data = compute_client.create_image(create_image_details).data

    return current_region

def cleanup (list_of_instances, current_region, config, namespace, destination_region):
    print("[INFO] Deleting PAR(s)...")
    compute_client, identity_client, vcn_client, object_storage_client = spawn_config(current_region, config)
    par_list = object_storage_client.list_preauthenticated_requests(namespace, "images_bucket").data

    for par in par_list:
        if par.name in list_of_instances:
            object_storage_client.delete_preauthenticated_request(namespace, "images_bucket", par.id)

    print("[INFO] Deleting object(s)...")
    objects = object_storage_client.list_objects(namespace, "images_bucket").data
    for obj in objects.objects:
        if obj.name in list_of_instances:
            object_storage_client.delete_object(namespace, "images_bucket", obj.name)

    print("[INFO] Deleting bucket...")
    object_storage_client.delete_bucket(namespace, "images_bucket")
    print("\n[INFO] Image(s) successfully moved to %s region!\n"%(destination_region))


if __name__ == "__main__":

    # Create config for python sdk
    config = from_file()
    validate_config(config)

    action_create_image   = create_image(args.compartment_name, config, args.list_of_instances)
    check_status(30,"provisioning", args.list_of_instances, action_create_image[0])
    action_create_bucket  = create_bucket(action_create_image[0], config)
    export_image(action_create_image[1], config, action_create_bucket)
    check_status(300,"exporting to bucket",args.list_of_instances,action_create_image[0])
    action_create_par     = create_par(args.list_of_instances, config, action_create_bucket)
    action_import_image   = import_image (action_create_image[0], action_create_par, args.list_of_instances, args.destination_region, config)
    check_status(300,"importing to destination region", args.list_of_instances, action_create_image[0])
    cleanup(args.list_of_instances, action_import_image, config, action_create_bucket, args.destination_region)

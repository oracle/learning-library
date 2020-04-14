# Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.

#
# Flavius Dinu (flavius.dinu@oracle.com)
#       Oracle Cloud Infrastructure
#
# Release (Date): 1.0 (May 2019)
#
# Copyright Oracle, Inc.  All rights reserved.

import oci
from oci.config import validate_config
from oci.config import from_file
import argparse
import datetime
import backoff

# Args parser configuration

parser = argparse.ArgumentParser(formatter_class=argparse.RawTextHelpFormatter, description="Creates backups for boot and block volumes")

parser.add_argument("-compartment", dest="compartment", type=str, required=True,
                    help="The compartment name in which the instances will have their block and boot volumes backed up. \n")

parser.add_argument("-region", dest="region", type=str, required=False,
                    help="The region in which the instances will have their block and boot volumes backed up. If no region is provided, it will default to the one from the config file\n")

parser.add_argument("-delete_volume_group_backups", action="store_const", const="delete_volume_group_backups", required=False,
                    help="Specifying this option will delete the volume group backups that are older than 30 days by default\n")

parser.add_argument("-delete_days", dest="delete_days", type=int, required=False,
                    help="Specify the number of days for backup delete. If omitted, backups older than 30 days will be removed\n")

args = parser.parse_args()


compute_client = None
block_storage_client = None
identity_client = None

def initialize(config):
    global compute_client
    global block_storage_client
    global identity_client
    if args.region:
        config["region"] = args.region
        compute_client = oci.core.ComputeClient(config)
        block_storage_client = oci.core.BlockstorageClient(config)
        identity_client = oci.identity.IdentityClient(config)
    else:
        compute_client = oci.core.ComputeClient(config)
        block_storage_client = oci.core.BlockstorageClient(config)
        identity_client = oci.identity.IdentityClient(config)
    return compute_client, block_storage_client, identity_client


def is_throttling_error(err):
    if err.status == 429:
        return False
    return True


@backoff.on_exception(backoff.expo, exception=oci.exceptions.ServiceError, max_time=300, giveup=is_throttling_error)
def list_volume_attachments(compartment_id, instance_id, limit):
    return compute_client.list_volume_attachments(compartment_id=compartment_id, instance_id=instance_id, limit=limit).data


@backoff.on_exception(backoff.expo, exception=oci.exceptions.ServiceError, max_time=300, giveup=is_throttling_error)
def list_boot_volume_attachments(instance_ad, compartment_id, instance_id, limit=1000):
    return compute_client.list_boot_volume_attachments(instance_ad, compartment_id, instance_id=instance_id, limit=1000).data


@backoff.on_exception(backoff.expo, exception=oci.exceptions.ServiceError, max_time=300, giveup=is_throttling_error)
def list_volume_groups(compartment_id, display_name, lifecycle_state, limit=1000):
    return block_storage_client.list_volume_groups(compartment_id=compartment_id, display_name=display_name, lifecycle_state=lifecycle_state, limit=limit)


@backoff.on_exception(backoff.expo, exception=oci.exceptions.ServiceError, max_time=300, giveup=is_throttling_error)
def create_volume_group(availability_domain, compartment_id, display_name, volume_ids):
    return block_storage_client.create_volume_group(oci.core.models.CreateVolumeGroupDetails(
        availability_domain=availability_domain,
        compartment_id=compartment_id,
        display_name=display_name,
        source_details=oci.core.models.VolumeGroupSourceFromVolumesDetails(
            type="volumeIds",
            volume_ids=volume_ids
        )
    ))


@backoff.on_exception(backoff.expo, exception=oci.exceptions.ServiceError, max_time=300, giveup=is_throttling_error)
def create_volume_group_backup(compartment_id, display_name, volume_group_id, backup_type):
    return block_storage_client.create_volume_group_backup(oci.core.models.CreateVolumeGroupBackupDetails(
        compartment_id=compartment_id,
        display_name=display_name,
        volume_group_id=volume_group_id,
        type=backup_type
    ))


@backoff.on_exception(backoff.expo, exception=oci.exceptions.ServiceError, max_time=300, giveup=is_throttling_error)
def list_volume_group_backups(compartment_id, limit=1000):
    return block_storage_client.list_volume_group_backups(compartment_id, limit=limit).data


@backoff.on_exception(backoff.expo, exception=oci.exceptions.ServiceError, max_time=300, giveup=is_throttling_error)
def delete_volume_group_backup(vg_id):
    block_storage_client.delete_volume_group_backup(vg_id)


def create_volume_groups(compartment_name):
    print("===============================\nStarting Volume Groups Creation\n===============================\n")
    compartments = oci.pagination.list_call_get_all_results(identity_client.list_compartments, config["tenancy"], compartment_id_in_subtree=True).data
    compartment_params = [{"comp_id": compartment.id, "comp_name": compartment.name} for compartment in compartments if compartment.lifecycle_state != "DELETED" if compartment.name == compartment_name]
    if len(compartment_params) == 0:
        print("There is no compartment with the name %s in the tenancy\nExiting..." %(compartment_name))
        exit(1)
    instances = compute_client.list_instances(compartment_id=compartment_params[0]["comp_id"], limit=1000).data
    instance_params = [{"instance_id": instance.id, "instance_ad": instance.availability_domain, "instance_name": instance.display_name} for instance in instances if instance.lifecycle_state != "TERMINATED"]
    volume_group_ids = []
    for instance in instance_params:
        block_vols = list_volume_attachments(compartment_params[0]["comp_id"], instance_id=instance["instance_id"], limit=1000)
        boot_vols = list_boot_volume_attachments(instance["instance_ad"], compartment_params[0]["comp_id"], instance_id=instance["instance_id"], limit=1000)

        block_vols_ids = [block_vol.volume_id for block_vol in block_vols]
        boot_vols_ids = [boot_vol.boot_volume_id for boot_vol in boot_vols]

        storage_volumes = block_vols_ids + boot_vols_ids

        # Check if volume group exists
        vg_exist = list_volume_groups(compartment_params[0]["comp_id"], display_name=instance["instance_name"], lifecycle_state="AVAILABLE", limit=1000)

        if(len(vg_exist.data) == 0):
            volume_group = create_volume_group(instance["instance_ad"], compartment_params[0]["comp_id"], instance["instance_name"], storage_volumes)
            print("[INFO] [New Volume Group]\nCreated Volume Group %s\n\t-id: %s\n\t-availability domain: %s" % (volume_group.data.display_name, volume_group.data.id, volume_group.data.availability_domain))
            volume_group_ids.append({"volume_group_id": volume_group.data.id, "volume_group_name": volume_group.data.display_name})
        else:
            print("[INFO] Volume Group %s already exists\n\t-id: %s\n\t-availability domain: %s" % (vg_exist.data[0].display_name, vg_exist.data[0].id, vg_exist.data[0].availability_domain))
            volume_group_ids.append({"volume_group_id": vg_exist.data[0].id, "volume_group_name": vg_exist.data[0].display_name})
    return volume_group_ids


def backup_volume_groups(compartment_name, volume_groups):
    print("===============================\nStarting Volume Group Backup Creation\n===============================\n")
    compartments = oci.pagination.list_call_get_all_results(identity_client.list_compartments, config["tenancy"], compartment_id_in_subtree=True).data
    compartment_params = [{"comp_id": compartment.id, "comp_name": compartment.name} for compartment in compartments if compartment.lifecycle_state != "DELETED" if compartment.name == compartment_name]
    if len(compartment_params) == 0:
        print("There is no compartment with the name %s in the tenancy\nExiting..." %(compartment_name))
        exit(1)
    for volume_group in volume_groups:
        volume_group_backup = create_volume_group_backup(
            compartment_id=compartment_params[0]["comp_id"],
            display_name=volume_group["volume_group_name"] + ' ' + str(datetime.datetime.now()),
            volume_group_id=volume_group["volume_group_id"],
            backup_type="INCREMENTAL"
        )
        print("[INFO] Created Volume Group Backup %s\n\t-id: %s\n" % (volume_group_backup.data.display_name, volume_group_backup.data.id))


def delete_volume_group_backups(compartment_name, days=30):
    print("===============================\nDeleting volume group backups older than %d days\n===============================\n" %(days))
    compartments = oci.pagination.list_call_get_all_results(identity_client.list_compartments, config["tenancy"], compartment_id_in_subtree=True).data
    compartment_params = [{"comp_id": compartment.id, "comp_name": compartment.name} for compartment in compartments if compartment.lifecycle_state != "DELETED" if compartment.name == compartment_name]
    if len(compartment_params) == 0:
        print("There is no compartment with the name %s in the tenancy\nExiting..." %(compartment_name))
        exit(1)
    volume_group_backups_list = list_volume_group_backups(compartment_params[0]["comp_id"], limit=1000)
    volume_group_backups = [{"vg_id": volume_group.id, "time_created": volume_group.time_created, "vg_name": volume_group.display_name} for volume_group in volume_group_backups_list if volume_group.lifecycle_state != "TERMINATED"]
    deleted_volumes = 0
    for volume_group in volume_group_backups:
        date_difference = datetime.datetime.now() - volume_group["time_created"]
        if(int(date_difference.days) > days):
            deleted_volumes += 1
            print("[INFO] Volume Group Backup %s with id: %s will be deleted\n" % (volume_group["vg_name"], volume_group["vg_id"]))
            delete_volume_group_backup(volume_group["vg_id"])
    print("Removed %d block volume group backups" % (deleted_volumes))


if __name__ == "__main__":

    # Create config for python sdk
    config = from_file()
    validate_config(config)

    initialize(config=config)
    if args.compartment and not args.delete_volume_group_backups:
        volume_groups = create_volume_groups(args.compartment)
        volume_groups_backup_ids = backup_volume_groups(args.compartment, volume_groups)

    if args.compartment and args.delete_volume_group_backups:
        if args.delete_days:
            delete_volume_group_backups(args.compartment, args.delete_days)
        else:
            delete_volume_group_backups(args.compartment)

    print("Finished")

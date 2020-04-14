# Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.
import os
import sys
from itertools import islice
import oci
from oci.config import validate_config
from oci.config import from_file
import json
import argparse
import time


parser = argparse.ArgumentParser(formatter_class=argparse.RawTextHelpFormatter, description="Start/Stop/Reboot Instances")

parser.add_argument("-compartment", dest="compartment", type=str, required=True,
                help="The compartment name in which the instances will be stopped/started/rebooted. \n")

parser.add_argument("-region", dest="region", type=str, required=False,
                help="The region in which the instances will be stopped/started/rebooted\n")

parser.add_argument("-action", dest="action", type=str, required=True,
                help="The action for the instances. Supported values are: STOP, START, REBOOT \n")

parser.add_argument("-wait", action="store_true", required=False,
                help="Use oci wait until built in function \n")

parser.add_argument("-instances_names", dest="instances_names", nargs='+', required=False,
                help="The names of the instances. If omitted, all the instances from that compartment will be stopped/started/rebooted \n")

parser.add_argument("-tag_key", dest="tag_key", type=str, required=False,
                help="The tag key for the freeform tags used in order to start/stop/reboot instancesc \n")

parser.add_argument("-tag_value", dest="tag_value", type=str, required=False,
                help="The tag value for the freeform tags used in order to start/stop/reboot instances \n")


args = parser.parse_args()

def spawn_config(region, config):
    if region:
        config["region"] = region
        compute_client = oci.core.ComputeClient(config)
        identity_client = oci.identity.IdentityClient(config)
        search_client = oci.resource_search.ResourceSearchClient(config)
    else:
        compute_client = oci.core.ComputeClient(config)
        identity_client = oci.identity.IdentityClient(config)
        search_client = oci.resource_search.ResourceSearchClient(config)
    return compute_client, identity_client, search_client

def get_instances(key, value, region, config):
    compute_client, identity_client, search_client = spawn_config(region, config)

    query_search = "query instance resources where (freeformTags.key = '{}' && freeformTags.value = '{}' && lifecycleState != 'terminated')".format(key, value)
    structured_search = oci.resource_search.models.StructuredSearchDetails(query=query_search,
                                                                           type='Structured',
                                                                           matching_context_type=oci.resource_search.models.SearchDetails.MATCHING_CONTEXT_TYPE_NONE)
    instances = search_client.search_resources(structured_search).data
    old_instances_list = [instance.display_name for instance in instances.items]
    return old_instances_list


def stop_instance(instance_id, instance_name, compute_client, wait):
    print("===============================\nStopping Instance %s\n===============================\n" %(instance_name))
    compute_client.instance_action(instance_id, "STOP")
    if wait:
        oci.wait_until(compute_client, compute_client.get_instance(instance_id), 'lifecycle_state', 'STOPPED')
    print("Instance Stopped:\n%s, %s\n\n" % (instance_name, instance_id))

def start_instance(instance_id, instance_name, compute_client, wait):
    print("===============================\nStarting Instance %s\n===============================\n" %(instance_name))
    compute_client.instance_action(instance_id, "START")
    if wait:
        oci.wait_until(compute_client, compute_client.get_instance(instance_id), 'lifecycle_state', 'RUNNING')
    print("Instance Started:\n%s, %s\n\n" % (instance_name, instance_id))

def instance_action(compartment_name, region, config, action, wait, instances_names=None):
    compute_client, identity_client, search_client = spawn_config(region, config)
    compartments = oci.pagination.list_call_get_all_results(identity_client.list_compartments, config["tenancy"], compartment_id_in_subtree=True).data
    compartment_params = [{"comp_id": compartment.id, "comp_name": compartment.name} for compartment in compartments if compartment.lifecycle_state != "DELETED" if compartment.name == compartment_name]
    if len(compartment_params) == 0:
        print("There is no compartment with the name %s in the tenancy\nExiting..." %(compartment_name))
        exit(1)
    instances = oci.pagination.list_call_get_all_results(compute_client.list_instances, compartment_params[0]["comp_id"]).data
    instance_params = []
    if instances_names != None:
        for instance_name in instances_names:
            instance_params.append([{"instance_id" : instance.id, "instance_ad": instance.availability_domain, "instance_name": instance.display_name} for instance in instances if instance.lifecycle_state != "TERMINATED" if instance.display_name == instance_name])
            if len(instance_params) == 0:
                print("There is no instance with the name %s in the compartment\nExiting..." %(instance_name))
                exit(1)
        instance_params = [item for sublist in instance_params for item in sublist]
    else:
        instance_params = [{"instance_id" : instance.id, "instance_ad": instance.availability_domain, "instance_name": instance.display_name} for instance in instances if instance.lifecycle_state != "TERMINATED"]
    for instance in instance_params:
        if action == "REBOOT":
            print("===============================\nRestarting instance %s\n===============================\n" %(instance["instance_name"]))
            stop_instance(instance["instance_id"], instance["instance_name"], compute_client, wait)
            start_instance(instance["instance_id"], instance["instance_name"], compute_client, wait)

        if action == "STOP":
            stop_instance(instance["instance_id"], instance["instance_name"], compute_client, wait)

        if action == "START":
            start_instance(instance["instance_id"], instance["instance_name"], compute_client, wait)

    return instance_params

def instance_status(region, config, instance_params):
    compute_client, identity_client, search_client = spawn_config(region, config)
    instances = instance_params
    tries = 0

    while(len(instances) > 0):
        time.sleep(20)
        for instance in instances:
            instance_details = compute_client.get_instance(instance["instance_id"]).data
            if instance_details.lifecycle_state == "STOPPING" or instance_details.lifecycle_state == "STARTING" or instance_details.lifecycle_state == "TERMINATING" or instance_details.lifecycle_state == "TERMINATED":
                print("Instance {} with id {} action still in progress.".format(instance_details.display_name, instance_details.id))
            else:
                print("Instance {} with id {}: action completed.".format(instance_details.display_name, instance_details.id))
                instances.remove(instance)
                break
        if tries == 15:
            print("The following instances are not in RUNNING or STOPPED state: {}".format(instances))
            exit(1)
        tries += 1
        print("\n\n")

if __name__ == "__main__":

    # Create config for python sdk
    config = from_file()
    validate_config(config)
    if args.instances_names:
        if args.wait:
            action = instance_action(args.compartment, args.region, config, args.action, args.wait, args.instances_names)
        else:
            action = instance_action(args.compartment, args.region, config, args.action, args.wait, args.instances_names)
            instance_status(args.region, config, action)
    elif args.tag_key and args.tag_value:
        if args.wait:
            instances_names = get_instances(args.tag_key, args.tag_value, args.region, config)
            action = instance_action(args.compartment, args.region, config, args.action, args.wait, instances_names)
        else:
            instances_names = get_instances(args.tag_key, args.tag_value, args.region, config)
            action = instance_action(args.compartment, args.region, config, args.action, args.wait, instances_names)
            instance_status(args.region, config, action)
    else:
        if args.wait:
            action = instance_action(args.compartment, args.region, config, args.action, args.wait)
        else:
            action = instance_action(args.compartment, args.region, config, args.action, args.wait)
            instance_status(args.region, config, action)

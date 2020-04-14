# VCN Peering script - updates route tables and security lists with specific rules regarding vcn peering
#
# Ionut Sturzu (ionut.sturzu@oracle.com)
# Flavius Dinu (flavius.dinu@oracle.com)
# Ionut Leca (ionut.leca@oracle.com)
# Cristian Cozma (cristian.cozma@oracle.com)
#
#       Oracle Cloud Infrastructure
#
# Release (Date): 1.0 (December 2019)
#
# Copyright Oracle, Inc.  All rights reserved.

import os
import sys
from itertools import islice
import oci
from oci.config import validate_config
from oci.config import from_file
import json
import argparse
import time
import random
import backoff
import hcl


parser = argparse.ArgumentParser(
    formatter_class=argparse.RawTextHelpFormatter, description="Add tags to different oci resources")

parser.add_argument("-tfvars_file", dest="tfvars_file", type=str, required=False,
                    help="Terraform provider file\n")

parser.add_argument("-req_compartment", dest="req_compartment", type=str, required=False,
                    help="Requestor compartment\n")

parser.add_argument("-req_vcn_id", dest="req_vcn_id", type=str, required=False,
                    help="Requestor vcn id\n")

parser.add_argument("-acc_cidr", dest="acc_cidr", type=str, required=False,
                    help="Acceptor cidrs to be used in the Requestor\n")

parser.add_argument("-req_drg", dest="req_drg", type=str, required=False,
                    help="Requestor DRG id\n")


parser.add_argument("-acc_compartment", dest="acc_compartment", type=str, required=False,
                    help="Acceptor Compartment\n")

parser.add_argument("-acc_vcn_id", dest="acc_vcn_id", type=str, required=False,
                    help="Acceptor VCN id\n")

parser.add_argument("-req_cidr", dest="req_cidr", type=str, required=False,
                    help="Requestor cidr to be used in the Acceptor\n")

parser.add_argument("-acc_drg", dest="acc_drg", type=str, required=False,
                    help="Acceptor DRG id\n")

parser.add_argument("-action", dest="action", type=str, required=False,
                    help="Add or remove the app sl ant rt rules [ add | remove ]\n")

args = parser.parse_args()


def is_throttling_error(err):
    if err.status == 429:
        return False
    return True


def spawn_config(config):
    vcn_client = oci.core.VirtualNetworkClient(config)
    return vcn_client


@backoff.on_exception(backoff.expo, exception=oci.exceptions.ServiceError, max_time=300, giveup=is_throttling_error)
def add_route_rule(compartment, vcn, cidr, lpg, config):
    vcn_client = spawn_config(config)
    route_tables = vcn_client.list_route_tables(compartment, vcn).data
    route_rule = oci.core.models.RouteRule(
        cidr_block=cidr,
        destination=cidr,
        destination_type="CIDR_BLOCK",
        network_entity_id=lpg
    )
    for route_table in route_tables:
        status = "unchanged"
        route_rules = route_table.route_rules
        if route_rule not in route_rules:
            status = "changed"
            route_rules.append(
                route_rule
            )
        if status == "changed":
            try:
                print("UPDATING {}: {}".format(
                    route_table.display_name, cidr))
                vcn_client.update_route_table(
                    route_table.id, oci.core.models.UpdateRouteTableDetails(route_rules=route_rules))
            except Exception as e:
                if e.status == 429:
                    print("Got throttle error. Retrying...")
                else:
                    print(e)
                raise
        else:
            print("{} already in {}".format(
                cidr, route_table.display_name))


@backoff.on_exception(backoff.expo, exception=oci.exceptions.ServiceError, max_time=300, giveup=is_throttling_error)
def remove_route_rule(compartment, vcn, cidr, lpg, config):
    vcn_client = spawn_config(config)
    route_tables = vcn_client.list_route_tables(compartment, vcn).data
    route_rule = oci.core.models.RouteRule(
        cidr_block=cidr,
        destination=cidr,
        destination_type="CIDR_BLOCK",
        network_entity_id=lpg
    )
    for route_table in route_tables:
        status = "unchanged"
        route_rules = route_table.route_rules
        if route_rule in route_rules:
            status = "changed"
            route_rules = list(filter(lambda r: r != route_rule, route_rules))
        if status == "changed":
            try:
                print("REMOVING from {}: - {}".format(
                    route_table.display_name, cidr))
                vcn_client.update_route_table(
                    route_table.id, oci.core.models.UpdateRouteTableDetails(route_rules=route_rules))
            except Exception as e:
                if e.status == 429:
                    print("Got throttle error. Retrying...")
                else:
                    print(e)
                raise
        else:
            print("{} not in {}".format(
                cidr, route_table.display_name))


@backoff.on_exception(backoff.expo, exception=oci.exceptions.ServiceError, max_time=300, giveup=is_throttling_error)
def add_security_rule(compartment_id, vcn_id, cidr, config):
    vcn_client = spawn_config(config)
    security_lists = vcn_client.list_security_lists(
        compartment_id, vcn_id).data
    ingress_rule = oci.core.models.IngressSecurityRule(
        protocol="6",
        source=cidr,
        source_type="CIDR_BLOCK",
        is_stateless=False
    )
    egress_rule = oci.core.models.EgressSecurityRule(
        protocol="6",
        destination=cidr,
        destination_type="CIDR_BLOCK",
        is_stateless=False
    )
    for security_list in security_lists:
        status = "unchanged"
        egress_security_rules = security_list.egress_security_rules
        ingress_security_rules = security_list.ingress_security_rules
        if ingress_rule not in ingress_security_rules:
            ingress_security_rules.append(ingress_rule)
            status = "changed"
        if egress_rule not in egress_security_rules:
            egress_security_rules.append(egress_rule)
            status = "changed"
        if status == "changed":
            try:
                print("UPDATING {}: {}".format(
                    security_list.display_name, cidr))
                vcn_client.update_security_list(security_list.id, oci.core.models.UpdateSecurityListDetails(
                    ingress_security_rules=ingress_security_rules,
                    egress_security_rules=egress_security_rules
                ))
            except Exception as e:
                if e.status == 429:
                    print("Got throttle error. Retrying...")
                else:
                    print(e)
                raise
        else:
            print("{} already in {}".format(cidr, security_list.display_name))


@backoff.on_exception(backoff.expo, exception=oci.exceptions.ServiceError, max_time=300, giveup=is_throttling_error)
def remove_security_rule(compartment_id, vcn_id, cidr, config):
    vcn_client = spawn_config(config)
    security_lists = vcn_client.list_security_lists(
        compartment_id, vcn_id).data
    ingress_rule = oci.core.models.IngressSecurityRule(
        protocol="6",
        source=cidr,
        source_type="CIDR_BLOCK",
        is_stateless=False
    )
    egress_rule = oci.core.models.EgressSecurityRule(
        protocol="6",
        destination=cidr,
        destination_type="CIDR_BLOCK",
        is_stateless=False
    )
    for security_list in security_lists:
        status = "unchanged"
        egress_security_rules = security_list.egress_security_rules
        ingress_security_rules = security_list.ingress_security_rules
        if ingress_rule in ingress_security_rules:
            ingress_security_rules = list(
                filter(lambda r: r != ingress_rule, ingress_security_rules))
            status = "changed"
        if egress_rule in egress_security_rules:
            egress_security_rules = list(
                filter(lambda r: r != egress_rule, egress_security_rules))
            status = "changed"
        if status == "changed":
            try:
                print("REMOVING from {}: - {}".format(
                    security_list.display_name, cidr))
                vcn_client.update_security_list(security_list.id, oci.core.models.UpdateSecurityListDetails(
                    ingress_security_rules=ingress_security_rules,
                    egress_security_rules=egress_security_rules
                ))
            except Exception as e:
                if e.status == 429:
                    print("Got throttle error. Retrying...")
                else:
                    print(e)
                raise
        else:
            print("{} not in {}".format(cidr, security_list.display_name))


if __name__ == "__main__":

    if(args.tfvars_file[-4:] == 'json'):
        # Create config for python sdk
        with open(args.tfvars_file) as f:
            config_tmp = json.load(f)["provider_oci"]
            config = {"tenancy": config_tmp["tenancy"],
                      "user": config_tmp["user_id"],
                      "fingerprint": config_tmp["fingerprint"],
                      "region": config_tmp["region"],
                      "key_file": config_tmp["key_file_path"],
                      "pass_phrase": config_tmp["private_key_password"]
                      }
            config_second = {"tenancy": config_tmp["tenancy"],
                             "user": config_tmp["user_id"],
                             "fingerprint": config_tmp["fingerprint"],
                             "region": config_tmp["region2"],
                             "key_file": config_tmp["key_file_path"],
                             "pass_phrase": config_tmp["private_key_password"]
                             }
    elif(args.tfvars_file[-6:] == 'tfvars'):
        with open(args.tfvars_file, 'r') as f:
            obj = hcl.load(f)['provider_oci']
            config = {"tenancy": obj["tenancy"],
                      "user": obj["user_id"],
                      "fingerprint": obj["fingerprint"],
                      "region": obj["region"],
                      "key_file": obj["key_file_path"],
                      "pass_phrase": obj["private_key_password"]
                      }
            config_second = {"tenancy": obj["tenancy"],
                             "user": obj["user_id"],
                             "fingerprint": obj["fingerprint"],
                             "region": obj["region2"],
                             "key_file": obj["key_file_path"],
                             "pass_phrase": obj["private_key_password"]
                             }

    validate_config(config)
    validate_config(config_second)

    # Update the (requestor) vcn route tables
    if args.action == "remove":
        remove_route_rule(args.req_compartment, args.req_vcn_id,
                          args.acc_cidr, args.req_drg, config)
    else:
        add_route_rule(args.req_compartment, args.req_vcn_id,
                       args.acc_cidr, args.req_drg, config)

    # Update the (acceptors) vcn route tables
    if args.action == "remove":
        remove_route_rule(args.acc_compartment, args.acc_vcn_id,
                          args.req_cidr, args.acc_drg, config_second)
    else:
        add_route_rule(args.acc_compartment, args.acc_vcn_id,
                       args.req_cidr, args.acc_drg, config_second)

    # Update the (requestor) vcn security lists
    if args.action == "remove":
        remove_security_rule(args.req_compartment,
                             args.req_vcn_id, args.acc_cidr, config)
    else:
        add_security_rule(args.req_compartment,
                          args.req_vcn_id, args.acc_cidr, config)

    # Update the (acceptor) vcn security lists
    if args.action == "remove":
        remove_security_rule(args.acc_compartment,
                             args.acc_vcn_id, args.req_cidr, config_second)
    else:
        add_security_rule(args.acc_compartment,
                          args.acc_vcn_id, args.req_cidr, config_second)

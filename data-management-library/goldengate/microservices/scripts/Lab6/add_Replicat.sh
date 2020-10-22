#!/bin/bash

#variables
vPass=$1
vASHost=localhost
vASPort=$2
vRepName=$3
vGGAlias=TGGATE

function _addReplicat {
    curl -X POST \
    http://$vASHost:$vASPort/services/v2/replicats/$vRepName \
    --user "oggadmin:"$vPass   \
    -H 'Cache-Control: no-cache' \
    -d '{
        "description":"Integrated Replicat",
        "config":[
            "Replicat     '$vRepName'",
            "UseridAlias '$vGGAlias'",
            "map oggoow181.soe.addresses,target soe.addresses, keycols(address_id);",
            "map oggoow181.soe.customers, target soe.customers, keycols(customer_id);",
            "map oggoow181.soe.orders, target soe.orders, keycols(order_id);",
            "map oggoow181.soe.order_items, target soe.order_items, keycols(order_id, line_item_id);",
            "map oggoow181.soe.card_details, target soe.card_details, keycols(card_id);",
            "map oggoow181.soe.logon, target soe.logon;",
            "map oggoow181.soe.product_information, target soe.product_information;",
            "map oggoow181.soe.inventories, target soe.inventories, keycols(product_id, warehouse_id);",
            "map oggoow181.soe.product_descriptions, target soe.product_descriptions;",
            "map oggoow181.soe.warehouses, target soe.warehouses;",
            "map oggoow181.soe.orderentry_metadata, target soe.orderentry_metadata;"
        ],
        "source":{
            "name":"ab"
        },
        "mode":{
            "type":"integrated"
        },
        "credentials":{
            "alias":"'$vGGAlias'"
        },
        "checkpoint":{
            "table":"ggate.checkpoints"
        },
        "status":"stopped"
    }' | python -mjson.tool
}

function _main {
     _addReplicat
}

_main


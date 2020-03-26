#!/bin/bash

curl -u 250BC172FD9:62eb97427a
600 -X POST -H "Content-Type: application/x-www-form-urlencoded" -d "grant_type=
client_credentials&scope=urn:opc:idm:__myscopes__" https://idcs-ba024b2844b3414a
a15581833cd48889.identity.oraclecloud.com/oauth2/v1/token

curl -u 79b00f673:44c301af -X POST -H "Content-Type: application/x-www-form-urlencoded" -d "grant_type=client_credentials&scope=urn:opc:idm:__myscopes__" https://idcs-ba0889.identity.oraclecloud.com/oauth2/v1/token

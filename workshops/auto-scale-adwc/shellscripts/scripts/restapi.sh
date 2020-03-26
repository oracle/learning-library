#!/bin/sh

# Version: 1.0.2
# Usage:
# oci-curl <host> <method> [file-to-send-as-body] <request-target> [extra-curl-args]
#
# ex:
# oci-curl iaas.us-ashburn-1.oraclecloud.com get "/20160918/instances?compartmentId=some-compartment-ocid"
# oci-curl iaas.us-ashburn-1.oraclecloud.com post ./request.json "/20160918/vcns"

function oci-curl {
        # TODO: update these values to your own
	local tenancyId="ocid1.tenancy.oc1..aaaaaaaabdbu3tn27i2dex5c4homxeoz2dvra73swhotc3flk63rqnjulrcq";
        local authUserId="ocid1.user.oc1..aaaaaaaamaxpbhukeqkmmuqxclbbutw6amq3l37a44qf7fbbtc7vwwkmqi7a"
        local keyFingerprint="ff:38:65:b0:2b:45:97:32:6c:da:52:8b:b1:c4:07:40"
        local privateKeyPath="/home/oracle/.oci/oci_api_key.pem";
        local alg=rsa-sha256
        local sigVersion="1"
        local now="$(LC_ALL=C \date -u "+%a, %d %h %Y %H:%M:%S GMT")"
        local host=$1
        local method=$2
        local extra_args
        local keyId="$tenancyId/$authUserId/$keyFingerprint"

        case $method in

                "get" | "GET")
                local target=$3
                extra_args=("${@: 4}")
                local curl_method="GET";
                local request_method="get";
                ;;

                "delete" | "DELETE")
                local target=$3
                extra_args=("${@: 4}")
                local curl_method="DELETE";
                local request_method="delete";
                ;;

                "head" | "HEAD")
                local target=$3
                extra_args=("--head" "${@: 4}")
                local curl_method="HEAD";
                local request_method="head";
                ;;

                "post" | "POST")
                local body=$3
                local target=$4
                extra_args=("${@: 5}")
                local curl_method="POST";
                local request_method="post";
                local content_sha256="$(openssl dgst -binary -sha256 < $body | openssl enc -e -base64)";
                local content_type="application/json";
                local content_length="$(wc -c < $body | xargs)";
                ;;

                "put" | "PUT")
                local body=$3
                local target=$4
                extra_args=("${@: 5}")
                local curl_method="PUT"
                local request_method="put"
                local content_sha256="$(openssl dgst -binary -sha256 < $body | openssl enc -e -base64)";
                local content_type="application/json";
                local content_length="$(wc -c < $body | xargs)";
                ;;

                *) echo "invalid method"; return;;
esac

# This line will url encode all special characters in the request target except "/", "?", "=", and "&", since those characters are used
# in the request target to indicate path and query string structure. If you need to encode any of "/", "?", "=", or "&", such as when
# used as part of a path value or query string key or value, you will need to do that yourself in the request target you pass in.

local escaped_target="$(echo $( rawurlencode "$target" ))"
local request_target="(request-target): $request_method $escaped_target"
local date_header="date: $now"
local host_header="host: $host"
local content_sha256_header="x-content-sha256: $content_sha256"
local content_type_header="content-type: $content_type"
local content_length_header="content-length: $content_length"
local signing_string="$request_target\n$date_header\n$host_header"
local headers="(request-target) date host"
local curl_header_args
curl_header_args=(-H "$date_header")
local body_arg
body_arg=()

if [ "$curl_method" = "PUT" -o "$curl_method" = "POST" ]; then
        signing_string="$signing_string\n$content_sha256_header\n$content_type_header\n$content_length_header"
        headers=$headers" x-content-sha256 content-type content-length"
        curl_header_args=("${curl_header_args[@]}" -H "$content_sha256_header" -H "$content_type_header" -H "$content_length_header")
        body_arg=(--data-binary @${body})
fi

local sig=$(printf '%b' "$signing_string" | \
                        openssl dgst -sha256 -sign $privateKeyPath | \
                        openssl enc -e -base64 | tr -d '\n')

curl "${extra_args[@]}" "${body_arg[@]}" -X $curl_method -sS https://${host}${escaped_target} "${curl_header_args[@]}" \
        -H "Authorization: Signature version=\"$sigVersion\",keyId=\"$keyId\",algorithm=\"$alg\",headers=\"${headers}\",signature=\"$sig\""
}
# url encode all special characters except "/", "?", "=", and "&"
function rawurlencode {
  local string="${1}"
  local strlen=${#string}
  local encoded=""
  local pos c o

  for (( pos=0 ; pos<strlen ; pos++ )); do
        c=${string:$pos:1}
        case "$c" in
                [-_.~a-zA-Z0-9] | "/" | "?" | "=" | "&" ) o="${c}" ;;
                * )               printf -v o '%%%02x' "'$c"
        esac
        encoded+="${o}"
        done

        echo "${encoded}"
}



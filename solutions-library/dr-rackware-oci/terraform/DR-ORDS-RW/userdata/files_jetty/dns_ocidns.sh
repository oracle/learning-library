#!/bin/bash

#Usage: add _acme-challenge.www.domain.com   "XKrxpRBosdIKFzxW_CT3KLZNf6q0HG9i01zxXp5CPBs"
dns_ocidns_add() {
  fulldomain=$1
  txtvalue=$2
  reg=`curl -s http://169.254.169.254/opc/v1/instance/canonicalRegionName`

  OCIDNS_C="${OCIDNS_C:-$(_readaccountconf_mutable OCIDNS_C)}"
  if [ -z "$OCIDNS_C" ]; then
    OCIDNS_C=""
    _err "You don't specify credentials. Please set and try again."
    return 1
  fi

  source $HOME/oci_bash

  #save the api key and email to the account conf file.
  _saveaccountconf_mutable OCIDNS_C "$OCIDNS_C"

  zone_name=`echo ${fulldomain} | rev | cut -d '.' -f -2 | rev`

  cat <<EOF > $HOME/request.json
{
    "items": [
        {
            "compartmentId" : "${OCIDNS_C}",
            "zone_name_or_id" : "${zone_name}",
            "domain" : "${fulldomain}",
            "rtype" : "TXT",
            "rdata" : "${txtvalue}",
            "ttl" : 120
        }
    ]
}
EOF

  if [ ! -e $HOME/request.json ]; then
    _err "json file couldn't be found at $HOME"
    return 1
  fi

  res_test=$(oci-curl)
  if [ ! "$res_test" = "invalid method" ]; then
    _err "oci-curl is not available."
    return 1
  fi

  _info "Adding record"
  if response=`oci-curl dns.${reg}.oraclecloud.com put $HOME/request.json "/20180115/zones/${zone_name}/records/${fulldomain}"`; then
    if printf -- "%s" "$response" | grep "$fulldomain" >/dev/null; then
      _info "Added, OK"
      return 0
    else
      _err "Add txt record error."
      return 1
    fi
  fi
}

#fulldomain txtvalue
dns_ocidns_rm() {
  fulldomain=$1
  txtvalue=$2
  reg=`curl -s http://169.254.169.254/opc/v1/instance/canonicalRegionName`

  source $HOME/oci_bash

  OCIDNS_C="${OCIDNS_C:-$(_readaccountconf_mutable OCIDNS_C)}"
  if [ -z "$OCIDNS_C" ]; then
    OCIDNS_C=""
    _err "You didn't specify credentials. Please set and try again."
    return 1
  fi

  zone_name=`echo ${fulldomain} | rev | cut -d '.' -f -2 | rev`

  res_test=$(oci-curl)
  if [ ! "$res_test" = "invalid method" ]; then
    _err "oci-curl is not available."
    return 1
  fi

  _info "Deleting record"
  if response=`oci-curl dns.${reg}.oraclecloud.com delete "/20180115/zones/${zone_name}/records/${fulldomain}"?compartmentId=${OCIDNS_C}`; then
    _info "Deleted, OK"
    return 0
  else
    _err "Delete record error."
    return 1
  fi

}

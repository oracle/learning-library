// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.

compartment_ids = {
  db_rampup = "ocid1.compartment.oc1..aaaaaaaaaba37tpcye2nbepuyfzf35ain7urlhqtnccb6a4kdik2zmtdpera"
}

subnet_ids = {
  hur1prv  = "ocid1.subnet.oc1.uk-london-1.aaaaaaaarevnm2idftrsronbhtnlq2pkn3ogws5t37tx4csvr427n22sm33a"
  hur1pub  = "ocid1.subnet.oc1.uk-london-1.aaaaaaaaydjnqaw4rgf2cehcz3r5rsfmknv42yjcwu6vzn7eyfzyo4h4ylua"
  hur2priv = "ocid1.subnet.oc1.uk-london-1.aaaaaaaaqhfnvh3yfzl7qnyxpqkvk3lyuephwdz44xoih5afrmy3md6s3pwq"
  hur2pub  = "ocid1.subnet.oc1.uk-london-1.aaaaaaaagviwrwwn5u32xugrvwofnqdmswqkyefyhg5tg4y3akgso6hbx3da"
}

function_ids = {
  helloworld-func = "ocid1.fnfunc.oc1.uk-london-1.aaaaaaaaadendfh4h27ayk7e3ujzn22ybh4buolgi26khm7mmdkcmlma475q"
}

apigw_params = {
  apigw = {
    compartment_name = "db_rampup"
    endpoint_type    = "PUBLIC"
    subnet_name      = "hur1pub"
    display_name     = "test_apigw"
  }
}


gwdeploy_params = {
  api_deploy1 = {
    compartment_name = "db_rampup"
    gateway_name     = "apigw"
    display_name     = "tf_deploy"
    path_prefix      = "/tf"
    access_log       = true
    exec_log_lvl     = "WARN"

    function_routes = [
      {
        type          = "function"
        path          = "/func"
        methods       = ["GET", ]
        function_name = "helloworld-func"
      },
    ]
    http_routes = [
      {
        type            = "http"
        path            = "/http"
        methods         = ["GET", ]
        url             = "http://152.67.128.232/"
        ssl_verify      = true
        connect_timeout = 60
        read_timeout    = 40
        send_timeout    = 10
      },
    ]
    stock_routes = [
      {
        methods = ["GET", ]
        path    = "/stock"
        type    = "stock_response"
        status  = 200
        body    = "The API GW deployment was successful."
        headers = [
          {
            name  = "Content-Type"
            value = "text/plain"
          },
        ]

      },
    ]

  }
}
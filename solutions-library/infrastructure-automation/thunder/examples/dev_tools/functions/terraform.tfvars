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

app_params = {
  thunder_app = {
    compartment_name = "db_rampup"
    subnet_name      = ["hur1pub", "hur1prv"]
    display_name     = "thunder_app"
    config = {
      "MY_FUNCTION_CONFIG" : "ConfVal"
    }
    freeform_tags = {
      "client" : "hurricane",
      "department" : "hurricane"
    }
  }
}

fn_params = {
  thunder_fn = {
    function_app       = "thunder_app"
    display_name       = "helloworld-func"
    image              = "lhr.ocir.io/isvglobal/thunder/helloworld-func:0.0.6"
    memory_in_mbs      = 256
    image_digest       = "sha256:0b5a80cb5957462bae6e438cfcc676394bf6fa9978c6352f4b0f654d7261b4e3"
    timeout_in_seconds = 30
    config = {
      "MY_FUNCTION_CONFIG" : "ConfVal"
    }
    freeform_tags = {
      "client" : "hurricane",
      "department" : "hurricane"
    }
  }
  thunder_fn2 = {
    function_app       = "thunder_app"
    display_name       = "fun-func"
    image              = "lhr.ocir.io/isvglobal/thunder/fun:0.1"
    memory_in_mbs      = 128
    image_digest       = "sha256:c929fcadacd4873379f01219584249c03947feb194882e8d132171b38bd292a8"
    timeout_in_seconds = 30
    config = {
      "MY_FUNCTION_CONFIG" : "ConfVal"
    }
    freeform_tags = {
      "client" : "hurricane",
      "department" : "hurricane"
    }
  }
}
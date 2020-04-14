// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.

output "ad" {
  value = {
    for idx, ad in oci_database_autonomous_database.adw:
      ad.db_name => { "connection_strings" : ad.connection_strings.0.all_connection_strings, "password" : random_string.autonomous_database_wallet_password[idx].result }
  }
}


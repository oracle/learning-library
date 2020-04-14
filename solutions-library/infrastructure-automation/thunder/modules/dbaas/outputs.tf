// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.
output "database" {
  value = {
    for db in oci_database_db_system.this:
      db.display_name => db.id 
  }
}

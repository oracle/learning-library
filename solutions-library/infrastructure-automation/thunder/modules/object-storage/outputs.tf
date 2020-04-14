// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.
output "buckets" {
  value = {
    for bucket in oci_objectstorage_bucket.this:
      bucket.name => bucket.access_type
  }
}
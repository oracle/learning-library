 //Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.

variable "ssh_private_key" {
  type = string
}

variable "masters_private_ip" {
  type = list(string)
}

variable "slaves_private_ip" {
  type = list(string)
}

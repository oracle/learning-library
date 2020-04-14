 //Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.

resource "null_resource" "passwordless_master" {

  provisioner "file" {
    source      = "${path.module}/../../userdata/passwordless.sh"
    destination = "/tmp/passwordless.sh"

    connection {
      type        = "ssh"
      user        = "opc"
      host        = var.masters_private_ip[0]
      private_key = file(var.ssh_private_key)
      agent       = false
      timeout     = "200s"
    }
  }

  provisioner "remote-exec" {
    when   = "create"
    inline = ["cd /tmp", "chmod +x passwordless.sh", "sudo ./passwordless.sh master ${var.slaves_private_ip[0]}"]

    connection {
      type        = "ssh"
      user        = "opc"
      host        = var.masters_private_ip[0]
      private_key = file(var.ssh_private_key)
      agent       = false
      timeout     = "100s"
    }
  }

  provisioner "local-exec" {
    command = "scp -o StrictHostKeyChecking=no -i ${var.ssh_private_key} opc@${var.masters_private_ip[0]}:/tmp/id_rsa.pub /tmp/id_rsa.pub"
  }
}

resource "null_resource" "passwordless_slave" {
  depends_on = ["null_resource.passwordless_master"]

  provisioner "file" {
    source      = "/tmp/id_rsa.pub"
    destination = "/tmp/id_rsa.pub"

    connection {
      type        = "ssh"
      user        = "opc"
      host        = var.slaves_private_ip[0]
      private_key = file(var.ssh_private_key)
      agent       = false
      timeout     = "100s"
    }
  }

  provisioner "file" {
    source      = "${path.module}/../../userdata/passwordless.sh"
    destination = "/tmp/passwordless.sh"

    connection {
      type        = "ssh"
      user        = "opc"
      host        = var.slaves_private_ip[0]
      private_key = file(var.ssh_private_key)
      agent       = false
      timeout     = "100s"
    }
  }

  provisioner "remote-exec" {
    when   = "create"
    inline = ["cd /tmp", "chmod +x passwordless.sh", "sudo ./passwordless.sh slave"]

    connection {
      type        = "ssh"
      user        = "opc"
      host        = var.slaves_private_ip[0]
      private_key = file(var.ssh_private_key)
      agent       = false
      timeout     = "100s"
    }
  }
}

resource "null_resource" "georeplication" {
  depends_on = ["null_resource.passwordless_slave"]

  provisioner "remote-exec" {
    when   = "create"
    inline = ["cd /tmp", "chmod +x passwordless.sh", "sudo ./passwordless.sh georeplication ${var.slaves_private_ip[0]}"]

    connection {
      type        = "ssh"
      user        = "opc"
      host        = var.masters_private_ip[0]
      private_key = file(var.ssh_private_key)
      agent       = false
      timeout     = "100s"
    }
  }
}

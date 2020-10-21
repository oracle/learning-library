### Compute ###
resource "null_resource" "remote-exec_init" {
  depends_on = [oci_core_instance.ORDS-Comp-Instance]

  provisioner "file" {
    connection {
      agent       = false
      timeout     = "10m"
      host        = oci_core_instance.ORDS-Comp-Instance.public_ip
      user        = var.HostUserName
      private_key = var.ssh_private_key
    }

    source      = "./userdata/files_init.zip"
    destination = "~/files_init.zip"
  }

  provisioner "remote-exec" {
    connection {
      agent       = false
      timeout     = "30m"
      host        = oci_core_instance.ORDS-Comp-Instance.public_ip
      user        = var.HostUserName
      private_key = var.ssh_private_key
    }

    inline = [
      "unzip files_init.zip",
      "chmod +x ~/config_init.sh",
      "sudo ~/config_init.sh",
    ]
  }
}

resource "null_resource" "remote-exec_jetty-1" {
  depends_on = [null_resource.remote-exec_init]

  count = 1 - var.web_srv # if web_srv=0 then jetty is configured

  provisioner "file" {
    connection {
      agent       = false
      timeout     = "10m"
      host        = oci_core_instance.ORDS-Comp-Instance.public_ip
      user        = var.HostUserName
      private_key = var.ssh_private_key
    }

    source      = "./userdata/files_jetty.zip"
    destination = "~/files_jetty.zip"
  }

  provisioner "remote-exec" {
    connection {
      agent       = false
      timeout     = "30m"
      host        = oci_core_instance.ORDS-Comp-Instance.public_ip
      user        = var.HostUserName
      private_key = var.ssh_private_key
    }

    inline = [
      "unzip files_jetty.zip \"config_jetty_init.sh\" ",
      "chmod +x ~/config_jetty_init.sh",
      "sudo ~/config_jetty_init.sh ${var.com_port}",
    ]
  }
}

resource "null_resource" "remote-exec_jetty-2" {
  depends_on = [null_resource.remote-exec_jetty-1]

  count = 1 - var.web_srv # if web_srv=0 then jetty is configured

  provisioner "remote-exec" {
    connection {
      agent       = false
      timeout     = "30m"
      host        = oci_core_instance.ORDS-Comp-Instance.public_ip
      user        = "oracle"
      private_key = var.ssh_private_key
    }

    inline = [
      "unzip files_jetty.zip",
      "chmod +x ~/*.sh",
      "./config_jetty_ords.sh \"${var.target_db_admin_pw}\" ${var.target_db_ip} ${var.target_db_srv_name} ${oci_core_instance.ORDS-Comp-Instance.public_ip} ${var.com_port} ${var.URL_ORDS_file}",
    ]
  }
}

resource "null_resource" "remote-exec_jetty-apex" {
  depends_on = [null_resource.remote-exec_jetty-2]

  # if web_srv=0(jetty)
  count = 1 - var.web_srv

  provisioner "remote-exec" {
    connection {
      agent       = false
      timeout     = "30m"
      host        = oci_core_instance.ORDS-Comp-Instance.public_ip
      user        = "oracle"
      private_key = var.ssh_private_key
    }

    inline = [
      "./config_jetty_apex.sh \"${var.target_db_admin_pw}\" ${var.target_db_ip} ${var.target_db_srv_name} ${oci_core_instance.ORDS-Comp-Instance.public_ip} ${var.com_port} ${var.URL_APEX_file} ${var.APEX_install_mode}",
    ]
  }
}



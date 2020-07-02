
#running vncserver setup on oracle cloud developer image

resource "null_resource" "remote-exec" {
    
    provisioner "remote-exec" {
        connection {
          agent       = false
          timeout     = "10m"
          host        = "${oci_core_instance.developer_instance.public_ip}"
          user        = "opc"
          private_key = "${file("${var.ssh_private_key}")}"
        }
        inline = [
          "mkdir -p tmp",
          "mkdir -p atp_wallet"
        ]
    }
    provisioner "file" {
        connection{
            agent           = false
            timeout         = "1m"
            host            = "${oci_core_instance.developer_instance.public_ip}"
            user            = "opc"
            private_key     = "${file("${var.ssh_private_key}")}"
        }
    source      = "./lab-resources"
    destination = "/tmp"
    }
    
    provisioner "remote-exec" {
    connection {
      agent       = false
      timeout     = "10m"
      host        = "${oci_core_instance.developer_instance.public_ip}"
      user        = "opc"
      private_key = "${file("${var.ssh_private_key}")}"
    }
    inline = [
      "sudo chmod a+x /tmp/lab-resources/*.sh",
      "/tmp/lab-resources/ocd_vnc_server.sh ${var.vncpasswd}",
    ]
    }
}

 //Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.

locals {
  type_list        = ["distributed", "replicated", "distributed_replicated", "dispersed", "distributed_dispersed"]
  volume_type      = contains(local.type_list, var.gluster_params.volume_type) ? null : file("ERROR: You have not selected a valid gluster volume type. Supported values are: distributed, replicated, distributed_replicated, dispersed, distributed_dispersed")
  replica_values   = var.gluster_params.replica_number == "" || var.gluster_params.volume_type == "dispersed" || var.gluster_params.volume_type == "distributed_dispersed" ? null : var.gluster_params.replica_number < 2 ? file("ERROR: Replica should be at least 2") : null
  replica_division = var.gluster_params.replica_number == "" || var.gluster_params.volume_type == "dispersed" || var.gluster_params.volume_type == "distributed_dispersed" ? null : length(var.bv_params) % var.gluster_params.replica_number != 0 ? file(format("ERROR: If you set a replica to %d, the length of the block volumes should be a multiple of the replica. Currently, the length of the block volumes is %d", var.gluster_params.replica_number, length(var.bv_params))) : null
  dispersed_check  = var.gluster_params.replica_number == "" ? null : (var.gluster_params.volume_type == "dispersed" || var.gluster_params.volume_type == "distributed_dispersed") && var.gluster_params.replica_number < 3 ? file("ERROR: A dispersed/distributed dispersed volume must have a minimum of 3 bricks.") : null
}

data "oci_identity_availability_domains" "ads" {
  compartment_id = var.instance_params[keys(var.instance_params)[0]].comp_id
}


resource "oci_core_instance" "this" {
  for_each             = var.instance_params
  availability_domain  = data.oci_identity_availability_domains.ads.availability_domains[(each.value.ad) - 1].name
  compartment_id       = each.value.comp_id
  shape                = each.value.shape
  display_name         = each.value.hostname
  preserve_boot_volume = each.value.preserve_boot_volume


  create_vnic_details {
    assign_public_ip = false
    subnet_id        = each.value.subnet_id
    hostname_label   = each.value.hostname
  }

  source_details {
    source_type = "image"
    source_id   = var.images[var.region]
  }
  metadata = {
    ssh_authorized_keys = file(var.ssh_public_key)
  }
}

resource "oci_core_volume" "this" {
  for_each            = var.bv_params
  availability_domain = oci_core_instance.this[each.value.instance_name].availability_domain
  compartment_id      = oci_core_instance.this[each.value.instance_name].compartment_id
  display_name        = each.value.name
  size_in_gbs         = each.value.size_in_gbs
}

resource "oci_core_volume_attachment" "this" {
  for_each        = var.bv_params
  attachment_type = "iscsi"
  instance_id     = oci_core_instance.this[each.value.instance_name].id
  volume_id       = oci_core_volume.this[each.value.name].id
}

data "oci_core_volume_attachments" "existing" {
  depends_on     = ["oci_core_volume_attachment.this"]
  for_each       = var.instance_params
  compartment_id = each.value.comp_id
  instance_id    = oci_core_instance.this[each.value.hostname].id
}

resource "null_resource" "attach_block_volume" {
  triggers = {
    cluster_instance_ids = join(",", [for key, value in oci_core_instance.this : value.id])
    attachment_ids       = join(",", [for key, value in oci_core_volume_attachment.this : value.id])
  }

  depends_on = ["oci_core_volume_attachment.this"]

  for_each = var.instance_params

  provisioner "file" {
    source      = "${path.module}/../../userdata/iscsi.sh"
    destination = "/tmp/iscsi.sh"

    connection {
      type        = "ssh"
      user        = "opc"
      host        = oci_core_instance.this[each.value.hostname].private_ip
      private_key = file(var.ssh_private_key)
      agent       = false
      timeout     = "200s"
    }
  }

  provisioner "remote-exec" {
    when   = "create"
    inline = ["cd /tmp", "chmod +x iscsi.sh", "sudo ./iscsi.sh '${length(data.oci_core_volume_attachments.existing[each.value.hostname].volume_attachments)}'"]

    connection {
      type        = "ssh"
      user        = "opc"
      host        = oci_core_instance.this[each.value.hostname].private_ip
      private_key = file(var.ssh_private_key)
      agent       = false
      timeout     = "100s"
    }
  }
}

resource "null_resource" "mount_block_volume" {
  triggers = {
    cluster_instance_ids = join(",", [for key, value in oci_core_instance.this : value.id])
    attachment_ids       = join(",", [for key, value in oci_core_volume_attachment.this : value.id])
  }

  depends_on = ["null_resource.attach_block_volume"]
  for_each   = var.instance_params


  provisioner "file" {
    source      = "${path.module}/../../userdata/mount.sh"
    destination = "/tmp/mount.sh"
    connection {
      type        = "ssh"
      user        = "opc"
      host        = oci_core_instance.this[each.value.hostname].private_ip
      private_key = file(var.ssh_private_key)
      agent       = false
      timeout     = "50s"
    }
  }

  provisioner "remote-exec" {

    when   = "create"
    inline = ["cd /tmp", "chmod +x mount.sh", "sudo ./mount.sh '${length(data.oci_core_volume_attachments.existing[each.value.hostname].volume_attachments)}' "]
    connection {
      type        = "ssh"
      user        = "opc"
      host        = oci_core_instance.this[each.value.hostname].private_ip
      private_key = file(var.ssh_private_key)
      agent       = false
      timeout     = "50s"
    }
  }

}

resource "null_resource" "prepare_glusterfs" {

  triggers = {
    cluster_instance_ids = join(",", [for key, value in oci_core_instance.this : value.id])
    attachment_ids       = join(",", [for key, value in oci_core_volume_attachment.this : value.id])
  }

  depends_on = ["null_resource.mount_block_volume"]

  for_each = var.instance_params


  provisioner "file" {
    when        = "create"
    source      = "${path.module}/../../userdata/glusterfs.sh"
    destination = "/tmp/glusterfs.sh"
    connection {
      type        = "ssh"
      user        = "opc"
      host        = oci_core_instance.this[each.value.hostname].private_ip
      private_key = file(var.ssh_private_key)
      agent       = false
    }
  }
}

resource "null_resource" "install_glusterfs" {

  triggers = {
    cluster_instance_ids = join(",", [for key, value in oci_core_instance.this : value.id])
    attachment_ids       = join(",", [for key, value in oci_core_volume_attachment.this : value.id])
  }

  depends_on = ["null_resource.prepare_glusterfs"]

  for_each = var.instance_params


  provisioner "remote-exec" {
    when = "create"

    inline = ["cd /tmp", "chmod +x glusterfs.sh", "sudo ./glusterfs.sh"]
    connection {
      type        = "ssh"
      user        = "opc"
      host        = oci_core_instance.this[each.value.hostname].private_ip
      private_key = file(var.ssh_private_key)
      agent       = false
    }
  }
}

resource "null_resource" "local_cleanup" {

  for_each   = var.instance_params
  depends_on = ["oci_core_instance.this"]

  provisioner "local-exec" {
    command = "rm -rf /tmp/*host*"
    when    = "destroy"
  }

  provisioner "local-exec" {
    command = "rm -rf /tmp/*brick*"
    when    = "destroy"
  }

  provisioner "local-exec" {
    command = "rm -rf /tmp/*${each.value.hostname}*"
    when    = "destroy"
  }

}

resource "null_resource" "gfs_config" {
  triggers = {
    cluster_instance_ids = join(",", [for key, value in oci_core_instance.this : value.id])
    attachment_ids       = join(",", [for key, value in oci_core_volume_attachment.this : value.id])
  }

  depends_on = ["null_resource.install_glusterfs"]
  for_each   = var.instance_params

  provisioner "remote-exec" {
    when = "create"
    connection {
      type        = "ssh"
      user        = "opc"
      host        = oci_core_instance.this[each.value.hostname].private_ip
      private_key = file(var.ssh_private_key)
      agent       = false
    }
    inline = [
      "echo ${oci_core_instance.this[each.value.hostname].private_ip} > /tmp/hostnames",
      "ls -d -1 /data/* > /tmp/bricks",
      "sed -i -e \"s/^/${oci_core_instance.this[each.value.hostname].private_ip}:/\" /tmp/bricks",
    ]
  }

  provisioner "local-exec" {
    command = "scp -o StrictHostKeyChecking=no -i ${var.ssh_private_key} opc@${oci_core_instance.this[each.value.hostname].private_ip}:/tmp/hostnames /tmp/myhostname_${each.value.hostname}"
  }

  provisioner "local-exec" {
    command = "scp -o StrictHostKeyChecking=no -i ${var.ssh_private_key} opc@${oci_core_instance.this[each.value.hostname].private_ip}:/tmp/bricks /tmp/bricks_${each.value.hostname}"
  }

  provisioner "local-exec" {
    command = "cat /tmp/myhostname_${each.value.hostname} >> /tmp/hostnamesfinal_${oci_core_instance.this[keys(var.instance_params)[0]].private_ip}"
  }

  provisioner "local-exec" {
    command = "cat /tmp/bricks_${each.value.hostname} >> /tmp/bricksfinal_${oci_core_instance.this[keys(var.instance_params)[0]].private_ip}"
  }

}

resource "null_resource" "eliminate_duplicates" {

  triggers = {
    cluster_instance_ids = join(",", [for key, value in oci_core_instance.this : value.id])
    attachment_ids       = join(",", [for key, value in oci_core_volume_attachment.this : value.id])
  }

  depends_on = ["null_resource.gfs_config"]

  provisioner "local-exec" {
    command = "awk '!a[$0]++' /tmp/hostnamesfinal_${oci_core_instance.this[keys(var.instance_params)[0]].private_ip} > /tmp/hosts_${oci_core_instance.this[keys(var.instance_params)[0]].private_ip}"
  }

  provisioner "local-exec" {
    command = "awk '!a[$0]++' /tmp/bricksfinal_${oci_core_instance.this[keys(var.instance_params)[0]].private_ip} > /tmp/bricks_${oci_core_instance.this[keys(var.instance_params)[0]].private_ip}"
  }
}

resource "null_resource" "gfs_copy_hostnames" {

  triggers = {
    cluster_instance_ids = join(",", [for key, value in oci_core_instance.this : value.id])
    attachment_ids       = join(",", [for key, value in oci_core_volume_attachment.this : value.id])
  }

  depends_on = ["null_resource.eliminate_duplicates"]

  provisioner "file" {
    source      = "/tmp/hosts_${oci_core_instance.this[keys(var.instance_params)[0]].private_ip}"
    destination = "/tmp/hosts"
    connection {
      type        = "ssh"
      user        = "opc"
      host        = oci_core_instance.this[keys(var.instance_params)[0]].private_ip
      private_key = file(var.ssh_private_key)
      agent       = false
      timeout     = "50s"
    }

  }

  provisioner "file" {
    source      = "/tmp/bricks_${oci_core_instance.this[keys(var.instance_params)[0]].private_ip}"
    destination = "/tmp/mounts"
    connection {
      type        = "ssh"
      user        = "opc"
      host        = oci_core_instance.this[keys(var.instance_params)[0]].private_ip
      private_key = file(var.ssh_private_key)
      agent       = false
      timeout     = "50s"
    }

  }
}

resource "null_resource" "gfs_volume" {

  triggers = {
    cluster_instance_ids = join(",", [for key, value in oci_core_instance.this : value.id])
    attachment_ids       = join(",", [for key, value in oci_core_volume_attachment.this : value.id])
  }

  depends_on = ["null_resource.gfs_copy_hostnames"]

  provisioner "file" {
    source      = "${path.module}/../../userdata/peer.sh"
    destination = "/tmp/peer.sh"
    connection {
      type        = "ssh"
      user        = "opc"
      host        = oci_core_instance.this[keys(var.instance_params)[0]].private_ip
      private_key = file(var.ssh_private_key)
      agent       = false
      timeout     = "50s"
    }
  }


  provisioner "remote-exec" {
    when = "create"
    connection {
      type        = "ssh"
      user        = "opc"
      host        = oci_core_instance.this[keys(var.instance_params)[0]].private_ip
      private_key = file(var.ssh_private_key)
      agent       = false
    }
    inline = ["cd /tmp", "chmod +x peer.sh", "sudo ./peer.sh '${var.gluster_params.volume_type}' '${var.gluster_params.replica_number}'"]
  }
}

resource "null_resource" "install_ganesha" {
  triggers = {
    cluster_instance_ids = join(",", [for key, value in oci_core_instance.this : value.id])
    attachment_ids       = join(",", [for key, value in oci_core_volume_attachment.this : value.id])
  }
  for_each   = var.instance_params
  depends_on = ["null_resource.gfs_volume"]

  provisioner "file" {
    source      = "${path.module}/../../userdata/ganesha.sh"
    destination = "/tmp/ganesha.sh"
    connection {
      type        = "ssh"
      user        = "opc"
      host        = oci_core_instance.this[each.value.hostname].private_ip
      private_key = file(var.ssh_private_key)
      agent       = false
      timeout     = "50s"
    }
  }

  provisioner "remote-exec" {

    when   = "create"
    inline = ["cd /tmp", "chmod +x ganesha.sh", "sudo ./ganesha.sh '${oci_core_instance.this[each.value.hostname].private_ip}'"]
    connection {
      type        = "ssh"
      user        = "opc"
      host        = oci_core_instance.this[each.value.hostname].private_ip
      private_key = file(var.ssh_private_key)
      agent       = false
      timeout     = "50s"
    }
  }

}

resource "null_resource" "copy_gluster_info" {
  triggers = {
    cluster_instance_ids = join(",", [for key, value in oci_core_instance.this : value.id])
    attachment_ids       = join(",", [for key, value in oci_core_volume_attachment.this : value.id])
  }

  depends_on = ["null_resource.gfs_volume"]

  provisioner "remote-exec" {
    when = "create"
    connection {
      type        = "ssh"
      user        = "opc"
      host        = oci_core_instance.this[keys(var.instance_params)[0]].private_ip
      private_key = file(var.ssh_private_key)
      agent       = false
    }
    inline = ["sudo gluster volume info glustervol > /tmp/glustervol_info"]
  }


  provisioner "local-exec" {
    command = "scp -o StrictHostKeyChecking=no -i ${var.ssh_private_key} opc@${oci_core_instance.this[keys(var.instance_params)[0]].private_ip}:/tmp/glustervol_info /tmp/glustervol_info"
  }

}

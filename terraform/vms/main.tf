# Source the Cloud Init Config file
data "template_file" "cloud_init_deb10_vm-01" {
  template = file("${path.module}/files/cloud_init_deb10.cloud_config")

  vars = {
    ssh_key  = "var.ssh_key"
    hostname = "vm-01"
    domain   = "johnstilia.internal"
  }
}

# Create a local copy of the file, to transfer to Proxmox
resource "local_file" "cloud_init_deb10_vm-01" {
  content  = data.template_file.cloud_init_deb10_vm-01.rendered
  filename = "${path.module}/files/user_data_cloud_init_deb10_vm-01.cfg"
}

# Transfer the file to the Proxmox Host
resource "null_resource" "cloud_init_deb10_vm-01" {
  connection {
    type        = "ssh"
    user        = "root"
    private_key = file("~/.ssh/id_rsa")
    host        = "192.168.1.22" #PROXMOX HOST
  }

  provisioner "file" {
    source      = local_file.cloud_init_deb10_vm-01.filename
    destination = "/var/lib/vz/snippets/cloud_init_deb10_vm-01.yml"
  }
}

# Create the VM
resource "proxmox_vm_qemu" "vm-01" {
  ## Wait for the cloud-config file to exist

  depends_on = [
    null_resource.cloud_init_deb10_vm-01
  ]

  name        = "vm-01"
  target_node = "flyinghermes"

  # Clone from debian-cloudinit template
  clone   = "debian-cloudinit"
  os_type = "cloud-init"

  # Cloud init options
  cicustom  = "user=local:snippets/cloud_init_deb10_vm-01.yml"
  ipconfig0 = "ip=192.168.1.19/24,gw=192.168.1.1"

  memory = 512
  agent  = 1

  # Set the boot disk paramters
  bootdisk = "scsi0"
  scsihw   = "virtio-scsi-pci"

  disk {
    size     = "20G"
    type     = "scsi"
    storage  = "local-lvm"
    iothread = "0"
    format   = "vmdk"
  }

  # Set the network
  network {
    model  = "virtio"
    bridge = "vmbr0"
  }

  # Ignore changes to the network
  ## MAC address is generated on every apply, causing
  ## TF to think this needs to be rebuilt on every apply
  lifecycle {
    ignore_changes = [
      network
    ]
  }
}
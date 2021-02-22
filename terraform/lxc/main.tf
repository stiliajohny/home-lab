resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "proxmox_lxc" "database" {
  target_node     = var.target_node
  hostname        = "SilverJanus"
  ostemplate      = "local:vztmpl/ubuntu-20.04-standard_20.04-1_amd64.tar.gz"
  password        = random_password.password.result
  unprivileged    = true
  ssh_public_keys = var.ssh_keys
  cores           = "2"
  memory          = "1024"
  start           = true

  // Terraform will crash without rootfs defined
  rootfs {
    storage = "DataStoreZFS-Local"
    size    = "20G"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "192.168.1.52/32"
    gw     = "192.168.1.1"
  }
}

output "database_password" {
  value = random_password.password.result
}
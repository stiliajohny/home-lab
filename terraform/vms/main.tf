


module "VM1" {
#  source = "git@github.com:stiliajohny/terraform-module_proxmox-vm.git"
  source = "../../../terraform-proxmox-vm/"

  pm_api_url      = var.pm_api_url
  pm_user         = var.pm_user
  pm_password     = var.pm_password

  count       = 1
  vmid        = "7000"
  name        = "test-vm-1"
  target_node = "proxmox_server"

  clone = "debian-cloudinit"

  os_type = "cloud-init"

  agent      = 1
  bios       = "ovmf"
  boot       = "cdn"
  bootdisk   = "scsi0"
  cores      = 1
  sockets    = "1"
  cpu        = "host"
  memory     = 1024
  scsihw     = "virtio-scsi-pci"
  onboot     = false
  full_clone = true

  vm_network = [
     {
      id        = 0
      model     = "virtio"
      bridge    = "vmbr0"
    },
     {
      id        = 1
      model     = "virtio"
      bridge    = "vmbr1"
    }
  ]

  vm_disk = [
    {
      type         = "scsi"
      storage      = "local-lvm"
      size         = "32G"
      format       = "qcow2"
      file         = "7000/vm-7000-disk-1.qcow2"
      volume       = "local-lvm:7000/vm-7000-disk-1.qcow2"
      slot         = 0
    },
    {
      type         = "scsi"
      storage      = "local-lvm"
      size         = "20G"
      format       = "qcow2"
      slot         = 1
    }
  ]

  # Cloud init specific
  ssh_keys      = "ssh-ed25519 AAAAC3NzaC1l7faf6a69UIATUDABIBTrVBGFSDAGLRJ+JjqB0+bgaKW80W6bxv407PzS user@domain.name"
  nameserver   = "10.10.10.1"
  searchdomain = "domain.name"
  #ipconfig0 = "ip=10.10.10.15${count.index + 1}/24,gw=10.10.10.1"


}

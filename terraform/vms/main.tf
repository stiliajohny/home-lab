module "test_vm" {
  source = "./modules/vms/"

}


module "test_module" {
  source = "git@github.com:stiliajohny/terraform-module_proxmox-vm.git"
}

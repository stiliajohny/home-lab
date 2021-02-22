variable "pm_api_url" {
  default     = "https://192.168.1.22:8006/api2/json"
  description = "Thisis the API or FQDN of your Proxmox Server"
}

variable "pm_user" {
  default     = "terraform-prov@pve"
  description = "This is an example user in the proxmox server with Administrator permissions"
}

variable "pm_password" {
  default     = "password"
  description = "This is an example password for the proxmox user"
  sensitive   = true
}

variable "ssh_keys" {
  description = "Public SSH keys to be passed in the LXC container."
}

variable "target_node" {
  default     = "pve"
  description = "This is an example of the Proxmox node name"
}

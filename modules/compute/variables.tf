variable "rg_name" {
  description = "Name of the Azure Resource Group"
  type        = string
}

variable "location" {
  description = "Azure region for all resources"
  type        = string
}

variable "app_subnet_id" {
  description = "Subnet ID for the App tier VMSS"
  type        = string
}

variable "ssh_public_key" {
  description = "SSH public key for admin access"
  type        = string
  sensitive   = true
}

variable "admin_username" {
  description = "Admin username for the VM instances"
  type        = string
  default     = "adminuser"
}

variable "vm_sku" {
  description = "VM SKU for the Scale Set instances"
  type        = string
  default     = "Standard_F2"
}

variable "instance_count" {
  description = "Initial number of VMSS instances"
  type        = number
  default     = 2
}

variable "tags" {
  description = "A map of tags to assign to resources"
  type        = map(string)
  default     = {}
}

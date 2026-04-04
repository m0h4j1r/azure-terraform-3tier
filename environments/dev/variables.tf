variable "location" {
  description = "Azure region for all resources"
  type        = string
  default     = "West Europe"
}

variable "environment" {
  description = "Deployment environment (dev / staging / prod)"
  type        = string
  default     = "dev"
}

variable "project_name" {
  description = "Short project name used in resource naming"
  type        = string
  default     = "3tier"
}

variable "ssh_public_key" {
  description = "SSH public key for VMSS admin access"
  type        = string
  sensitive   = true
}

variable "instance_count" {
  description = "Number of VMSS instances"
  type        = number
  default     = 2
}

variable "vm_sku" {
  description = "VM SKU for Scale Set instances"
  type        = string
  default     = "Standard_F2"
}

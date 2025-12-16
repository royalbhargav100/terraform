variable "location" {
  description = "Azure region for resources"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "admin_username" {
  description = "Administrator username for VMs"
  type        = string
  default     = "azureuser"
}

variable "virtual_machines" {
  description = "Map of virtual machines to create"
  type = map(object({
    name              = string
    vm_size           = string
    subnet_id         = string
    ssh_key_path      = string
    image_publisher   = string
    image_offer       = string
    image_sku         = string
    image_version     = string
  }))
  default = {}
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}

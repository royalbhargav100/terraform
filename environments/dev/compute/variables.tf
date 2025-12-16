variable "resource_group_name" {
  type = string
}

variable "admin_username" {
  type = string
}

variable "virtual_machines" {
  type = map(object({
    name            = string
    vm_size         = string
    subnet_id       = string
    ssh_key_path    = string
    image_publisher = string
    image_offer     = string
    image_sku       = string
    image_version   = string
  }))
}

variable "tags" {
  type = map(string)
}

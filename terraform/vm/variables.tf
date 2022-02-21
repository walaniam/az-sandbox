# export TF_VAR_azure_subscription_id=
# export TF_VAR_azure_tenant_id=

variable "azure_subscription_id" {
  type = string
}

variable "azure_tenant_id" {
  type = string
}

variable "azure_default_location" {
  type    = string
  default = "westeurope"
}

variable "vm_group" {
  type    = string
  default = "example-vms"
}

variable "vm_size" {
  type    = string
  default = "Standard_B1ls"
}

variable "vm_admin_username" {
  type      = string
  sensitive = true
}

variable "vm_admin_password" {
  type      = string
  sensitive = true
}
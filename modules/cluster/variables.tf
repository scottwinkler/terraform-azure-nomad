variable "azure" {
  type = object({
    subscription_id = string
    client_id       = string
    client_secret   = string
    tenant_id       = string
  })
}

variable "instance_count" {
  type = number
}

variable "instance_size" {
  type = string
}

variable "location" {
  type = string
}

variable "datacenter" {
  type = string
}

variable "join_wan" {
  default = []
  type = list(string)
}

variable "admin" {
  type = object({
    username = string
    password = string
    disable_password_authentication = bool
  })
}

variable "consul" {
  default = {
    version = "n/a"
    mode    = "disabled"
  }
  type = object({
    version = string
    mode    = string
  })
}

variable "nomad" {
  default = {
    version = "n/a"
    mode    = "disabled"
  }
  type = object({
    version = string
    mode    = string
  })
}

variable "namespace" {
  type = string
}

variable "vpc" {
  type = any
}

variable "security_group_id" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "lb_backend_address_pool_ids" {
  type = list(string)
}

variable "associate_public_ips" {
  type = bool
}
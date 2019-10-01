variable "namespace" {
  default = "terraforminaction"
  type    = string
}

variable "location" {
  default = "westus2"
  type    = string
}

variable "datacenter" {
  default = "azure"
  type    = string
}

variable "join_wan" {
  type    = list(string)
  default = []
}

variable "associate_public_ips" {
  default = true
  type = bool
}

variable "azure" {
  type = object({
    subscription_id = string
    client_id       = string
    client_secret   = string
    tenant_id       = string
  })
}

variable "admin" {
  default = {
    username                        = "azure"
    password                        = "Passwword1234"
    disable_password_authentication = false
  }
  type = object({
    username                        = string
    password                        = string
    disable_password_authentication = bool
  })
}

variable "consul" {
  default = {
    version              = "1.5.2"
    servers_count        = 3
    server_instance_size = "Standard_A1"
  }
  type = object({
    version              = string
    servers_count        = number
    server_instance_size = string
  })
}

variable "nomad" {
  default = {
    version              = "0.9.3"
    servers_count        = 3
    server_instance_size = "Standard_A1"
    clients_count        = 3
    client_instance_size = "Standard_A1"
  }
  type = object({
    version              = string
    servers_count        = number
    server_instance_size = string
    clients_count        = number
    client_instance_size = string
  })
}

output "vpc" {
  value = {
    subnets = [
      azurerm_subnet.vm_subnet,
    ]
  }
}

output "sg" {
  value = {
    consul_server = azurerm_network_security_group.consul_server_sg.id
    nomad_server  = azurerm_network_security_group.nomad_server_sg.id
    nomad_client  = azurerm_network_security_group.nomad_client_sg.id
  }
}

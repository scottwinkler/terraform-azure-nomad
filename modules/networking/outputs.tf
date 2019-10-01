output "vpc" {
  value = {
    subnets = [
      azurerm_subnet.vm_subnet,
    ]
  }
}

output "sg" {
  value = {
    consul       = azurerm_network_security_group.consul_sg.id
    nomad        = azurerm_network_security_group.nomad_sg.id
    nomad_client = azurerm_network_security_group.nomad_client_sg.id
  }
}

output "addresses" {
  value = {
    consul_ui = "http://${azurerm_public_ip.consul_public_ip.fqdn}:8500"
    nomad_ui  = "http://${azurerm_public_ip.nomad_public_ip.fqdn}:4646"
    fabio_ui  = "http://${azurerm_public_ip.fabio_public_ip.fqdn}:9998"
    fabio_db  = "tcp://${azurerm_public_ip.fabio_public_ip.fqdn}:27017"
  }
}

output "lb_backend_address_pool_ids" {
  value = {
    consul = [azurerm_lb_backend_address_pool.consul_address_pool.id]
    nomad  = [azurerm_lb_backend_address_pool.nomad_address_pool.id]
    fabio  = [azurerm_lb_backend_address_pool.fabio_address_pool.id]
  }
}

output "lb_health_probes" {
  value = {
    nomad  = azurerm_lb_probe.nomad_probe.id,
    consul = azurerm_lb_probe.consul_probe.id
  }
}

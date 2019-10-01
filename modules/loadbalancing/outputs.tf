output "lb_dns_names" {
  value = {
    consul = "${azurerm_public_ip.consul_public_ip.fqdn}:8500"
    nomad  = "${azurerm_public_ip.nomad_public_ip.fqdn}:4646"
    app    = "${azurerm_public_ip.application_public_ip.fqdn}:9998"
  }
}

output "lb_backend_address_pool_ids" {
  value = {
    consul = [azurerm_lb_backend_address_pool.consul_address_pool.id]
    nomad  = [azurerm_lb_backend_address_pool.nomad_address_pool.id]
    app    = [azurerm_lb_backend_address_pool.application_address_pool.id]
  }
}

output "lb_health_probes" {
  value = {
    nomad  = azurerm_lb_probe.nomad_probe.id,
    consul = azurerm_lb_probe.consul_probe.id
  }
}

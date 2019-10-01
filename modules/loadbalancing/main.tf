# consul load balancer
resource "azurerm_public_ip" "consul_public_ip" {
  name                = "${var.namespace}-consul-public_ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  domain_name_label   = "${var.namespace}-consul"
  sku                 = "Standard"
}

resource "azurerm_lb" "consul_lb_external" {
  name                = "${var.namespace}-consul"
  location            = var.location
  resource_group_name = var.resource_group_name

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.consul_public_ip.id
  }
  sku = "Standard"
}

resource "azurerm_lb_backend_address_pool" "consul_address_pool" {
  resource_group_name = var.resource_group_name
  loadbalancer_id     = azurerm_lb.consul_lb_external.id
  name                = "${var.namespace}-consul-pool"
}

resource "azurerm_lb_probe" "consul_probe" {
  resource_group_name = var.resource_group_name
  loadbalancer_id     = azurerm_lb.consul_lb_external.id
  name                = "${var.namespace}-consul-probe"
  protocol            = "HTTP"
  port                = "8500"
  request_path        = "/v1/status/leader"
}

resource "azurerm_lb_rule" "consul_ui_rule" {
  resource_group_name            = var.resource_group_name
  name                           = "${var.namespace}-consul-ui"
  loadbalancer_id                = azurerm_lb.consul_lb_external.id
  protocol                       = "TCP"
  frontend_port                  = "8500"
  backend_port                   = "8500"
  frontend_ip_configuration_name = "PublicIPAddress"
  backend_address_pool_id        = azurerm_lb_backend_address_pool.consul_address_pool.id
  probe_id                       = azurerm_lb_probe.consul_probe.id
}

# nomad server load balancer
resource "azurerm_public_ip" "nomad_public_ip" {
  name                = "${var.namespace}-nomad-public_ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  domain_name_label   = "${var.namespace}-nomad"
  sku                 = "Standard"
}

resource "azurerm_lb" "nomad_lb_external" {
  name                = "${var.namespace}-nomad"
  location            = var.location
  resource_group_name = var.resource_group_name

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.nomad_public_ip.id
  }
  sku = "Standard"
}

resource "azurerm_lb_backend_address_pool" "nomad_address_pool" {
  resource_group_name = var.resource_group_name
  loadbalancer_id     = azurerm_lb.nomad_lb_external.id
  name                = "${var.namespace}-nomad-pool"
}

resource "azurerm_lb_probe" "nomad_probe" {
  resource_group_name = var.resource_group_name
  loadbalancer_id     = azurerm_lb.nomad_lb_external.id
  name                = "${var.namespace}-nomad-probe"
  protocol            = "HTTP"
  port                = "4646"
  request_path        = "/v1/agent/self"
}

resource "azurerm_lb_rule" "nomad_ui_rule" {
  resource_group_name            = var.resource_group_name
  name                           = "${var.namespace}-nomad-ui"
  loadbalancer_id                = azurerm_lb.nomad_lb_external.id
  protocol                       = "TCP"
  frontend_port                  = "4646"
  backend_port                   = "4646"
  frontend_ip_configuration_name = "PublicIPAddress"
  backend_address_pool_id        = azurerm_lb_backend_address_pool.nomad_address_pool.id
  probe_id                       = azurerm_lb_probe.nomad_probe.id
}

# fabio load balancer
resource "azurerm_public_ip" "fabio_public_ip" {
  name                = "${var.namespace}-fabio-public_ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  domain_name_label   = "${var.namespace}-fabio"
  sku                 = "Standard"
}

resource "azurerm_lb" "fabio_lb_external" {
  name                = "${var.namespace}-fabio"
  location            = var.location
  resource_group_name = var.resource_group_name

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.fabio_public_ip.id
  }
  sku = "Standard"
}

resource "azurerm_lb_backend_address_pool" "fabio_address_pool" {
  resource_group_name = var.resource_group_name
  loadbalancer_id     = azurerm_lb.fabio_lb_external.id
  name                = "${var.namespace}-fabio-pool"
}

resource "azurerm_lb_probe" "fabio_probe" {
  resource_group_name = var.resource_group_name
  loadbalancer_id     = azurerm_lb.fabio_lb_external.id
  name                = "${var.namespace}-fabio-probe"
  protocol            = "HTTP"
  port                = "9998"
  request_path        = "/routes"
}

resource "azurerm_lb_rule" "fabio_ui_rule" {
  resource_group_name            = var.resource_group_name
  name                           = "${var.namespace}-fabio-ui"
  loadbalancer_id                = azurerm_lb.fabio_lb_external.id
  protocol                       = "TCP"
  frontend_port                  = "9998"
  backend_port                   = "9998"
  frontend_ip_configuration_name = "PublicIPAddress"
  backend_address_pool_id        = azurerm_lb_backend_address_pool.fabio_address_pool.id
  probe_id                       = azurerm_lb_probe.fabio_probe.id
}

resource "azurerm_lb_rule" "fabio_lb_rule" {
  resource_group_name            = var.resource_group_name
  name                           = "${var.namespace}-fabio-lb"
  loadbalancer_id                = azurerm_lb.fabio_lb_external.id
  protocol                       = "TCP"
  frontend_port                  = "9999"
  backend_port                   = "9999"
  frontend_ip_configuration_name = "PublicIPAddress"
  backend_address_pool_id        = azurerm_lb_backend_address_pool.fabio_address_pool.id
  probe_id                       = azurerm_lb_probe.fabio_probe.id
}

resource "azurerm_lb_rule" "fabio_db_rule" {
  resource_group_name            = var.resource_group_name
  name                           = "${var.namespace}-fabio-db"
  loadbalancer_id                = azurerm_lb.fabio_lb_external.id
  protocol                       = "TCP"
  frontend_port                  = "27017"
  backend_port                   = "27017"
  frontend_ip_configuration_name = "PublicIPAddress"
  backend_address_pool_id        = azurerm_lb_backend_address_pool.fabio_address_pool.id
  probe_id                       = azurerm_lb_probe.fabio_probe.id
}

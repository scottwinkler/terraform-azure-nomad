module "resourcegroup" {
  source = "./modules/resourcegroup"

  namespace = var.namespace
  location  = var.azure.location
}

module "networking" {
  source = "./modules/networking"

  location            = var.azure.location
  namespace           = module.resourcegroup.namespace
  resource_group_name = module.resourcegroup.resource_group_name
}

module "loadbalancing" {
  source = "./modules/loadbalancing"

  location            = var.azure.location
  namespace           = module.resourcegroup.namespace
  resource_group_name = module.resourcegroup.resource_group_name
}

module "consul_servers" {
  source = "./modules/cluster"

  azure          = var.azure
  instance_count = var.consul.servers_count
  instance_size  = var.consul.server_instance_size
  location       = var.azure.location
  datacenter     = var.datacenter
  join_wan       = var.join_wan
  admin          = var.admin

  consul = {
    version = var.consul.version
    mode    = "server"
  }

  associate_public_ips        = var.associate_public_ips
  namespace                   = module.resourcegroup.namespace
  vpc                         = module.networking.vpc
  security_group_id           = module.networking.sg.consul
  resource_group_name         = module.resourcegroup.resource_group_name
  lb_backend_address_pool_ids = module.loadbalancing.lb_backend_address_pool_ids.consul
}

module "nomad_servers" {
  source = "./modules/cluster"

  azure          = var.azure
  instance_count = var.nomad.servers_count
  instance_size  = var.nomad.server_instance_size
  location       = var.azure.location
  datacenter     = var.datacenter
  admin          = var.admin

  nomad = {
    version = var.nomad.version
    mode    = "server"
  }
  consul = {
    version = var.consul.version
    mode    = "client"
  }

  associate_public_ips        = var.associate_public_ips
  namespace                   = module.resourcegroup.namespace
  vpc                         = module.networking.vpc
  security_group_id           = module.networking.sg.nomad
  resource_group_name         = module.resourcegroup.resource_group_name
  lb_backend_address_pool_ids = module.loadbalancing.lb_backend_address_pool_ids.nomad
}

module "nomad_clients" {
  source = "./modules/cluster"

  azure          = var.azure
  instance_count = var.nomad.clients_count
  instance_size  = var.nomad.client_instance_size
  location       = var.azure.location
  datacenter     = var.datacenter
  admin          = var.admin

  nomad = {
    version = var.nomad.version
    mode    = "client"
  }
  consul = {
    version = var.consul.version
    mode    = "client"
  }

  associate_public_ips        = false
  namespace                   = module.resourcegroup.namespace
  vpc                         = module.networking.vpc
  security_group_id           = module.networking.sg.nomad_client
  resource_group_name         = module.resourcegroup.resource_group_name
  lb_backend_address_pool_ids = module.loadbalancing.lb_backend_address_pool_ids.app
}

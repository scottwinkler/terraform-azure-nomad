output "resource_group_name" {
    value = azurerm_resource_group.resource_group.name
}

output "namespace" {
    value = local.namespace
}
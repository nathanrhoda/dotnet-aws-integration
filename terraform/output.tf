output api_gw_id{
  value = module.api-gateway.api_gateway_api_id
}

output "api_gw_resource_id" {
    description = "Api Root resource id for the Api Gateway"
    value       = module.api-gateway.api_gateway_root_resource_id
}

output "api_gw_method" {
  description = "Gateway http method "
  value = module.api-gateway.api_gateway_method
}

output "api_gateway_resource_path" {
  description = "Gateway Resource Path"
  value = module.api-gateway.api_gateway_resource_path
}
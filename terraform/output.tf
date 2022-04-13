output api_gateway_id{
  value = module.api-gateway.api_gateway_api_id
}

output "api_gateway_resource_id" {
    description = "Api Root resource id for the Api Gateway"
    value       = module.api-gateway.api_gateway_root_resource_id
}
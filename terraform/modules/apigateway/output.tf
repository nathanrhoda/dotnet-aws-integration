output "api_gateway_api_id" {
    description = "Api id for the Api Gateway"
    value       = aws_api_gateway_rest_api.NathanAPI.id
}

output "api_gateway_root_resource_id" {
    description = "Root resource id for the Api Gateway"
    value       = aws_api_gateway_rest_api.NathanAPI.root_resource_id
}

output "api_gateway_method" {
  description = "Gateway http method "
  value = aws_api_gateway_method.NathanMethod.http_method  
}

output "api_gateway_resource_path" {
  description = "Gateway Resource Path"
  value = aws_api_gateway_resource.NathanResource.path
}

output "api_gateway_resource_id" {
  description = "Resource Id"
  value = aws_api_gateway_resource.NathanResource.id
}
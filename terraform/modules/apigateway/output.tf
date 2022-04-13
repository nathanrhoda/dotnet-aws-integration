output "api_gateway_api_id" {
    description = "Api id for the Api Gateway"
    value       = aws_api_gateway_rest_api.NathanAPI.id
}

output "api_gateway_root_resource_id" {
    description = "Api id for the Api Gateway"
    value       = aws_api_gateway_rest_api.NathanAPI.root_resource_id
}
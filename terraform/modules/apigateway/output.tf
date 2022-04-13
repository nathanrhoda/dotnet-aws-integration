output "api_gateway_api_id" {
    description = "Api id for the Api Gateway"
    value       = aws_api_gateway_rest_api.NathanAPI.id
}
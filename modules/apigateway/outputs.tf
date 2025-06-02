output "rest_api_id" {
  value = aws_api_gateway_rest_api.this.id
}

output "invoke_url" {
  value = aws_api_gateway_deployment.this.invoke_url
}
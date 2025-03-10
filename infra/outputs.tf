output "event_bus_arn" {
  value = module.eventbridge.event_bus_arn
}

output "lambda_function_arn" {
  value = module.lambda.lambda_function_arn
}

output "api_gateway_url" {
  value = module.api_gateway.api_gateway_url
}
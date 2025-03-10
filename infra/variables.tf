# Root variables.tf
variable "aws_region" {
  description = "AWS region where resources will be deployed"
  type        = string
}

variable "lambda_function_name" {
  type    = string
}

variable "lambda_runtime" {
  type    = string
  default = "python3.13"
}

variable "event_bus_name" {
  type    = string
}

variable "api_gateway_stage_name" {
  type    = string
}
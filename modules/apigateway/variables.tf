variable "api_name" {
  description = "Nome da API Gateway REST API"
  type        = string
}

variable "stage_name" {
  description = "Nome do Deployment stage"
  type        = string
  default     = "prod"
}
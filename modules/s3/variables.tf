variable "bucket_name" {
  description = "Nome do bucket S3"
  type        = string
}

variable "tags" {
  description = "Mapeamento das tags para associar ao bucket S3"
  type        = map(string)
}

variable "lambda_function_arn" {
  description = "ARN da função Lambda a ser acionada por eventos S3 (opcional)"
  type        = string
  default     = null
}
variable "bucket_name" {
  description = "Nome do bucket S3"
  type = string
}

variable "tags" {
  description = "Mapeamento das tags para associar ao bucket S3"
  type = map(string)
}
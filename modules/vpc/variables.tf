variable "cidr_block" {
  description = "Bloco CIDR para a VPC"
  type        = string
}

variable "tags" {
  description = "Mapeamento de tags para associar a VPC"
  type        = map(string)
}

variable "public_subnet_cidr_block" {
  description = "Bloco CIDR para subnet publica da VPC"
  type        = string
}
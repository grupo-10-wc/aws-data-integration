variable "region" {
  description = "Regiao destino do deploy dos recursos"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr_block" {
  description = "Bloco CIDR para VPC"
  type        = string
  default     = "10.0.0.0/23"
}

variable "public_subnet_cidr_block" {
  description = "Bloco CIDR para a subnet publica"
  type        = string
  default     = "10.0.0.0/24"
}

variable "vpc_tags" {
  description = "Mapeamento de tags para associar a VPC"
  type        = map(string)
  default      = {}
}

variable "ec2_ami" {
  description = "ID da AMI para a instancia EC2"
  type        = string
}

variable "ec2_instance_type" {
  description = "Tipo da instancia EC2"
  type        = string
  default     = "t2.micro"
}

variable "ec2_key_name" {
  description = "Nome da Chave para a instancia EC2"
  type        = string
}

variable "ec2_tags" {
  description = "Mapeamento de tags para associar a EC2"
  type        = map(string)
  default      = {}
}

variable "s3_raw_bucket_name" {
  description = "Nome para o raw bucket S3"
  type        = string
}

variable "s3_raw_tags" {
  description = "Mapeamento de tags para associar ao raw bucket S3"
  type        = map(string)
}

variable "s3_trusted_bucket_name" {
  description = "Nome do trusted bucket S3"
  type        = string
}

variable "s3_trusted_tags" {
  description = "Tags para o trusted bucket S3"
  type        = map(string)
}

variable "s3_client_bucket_name" {
  description = "Nome do bucket S3 client"
  type        = string
}

variable "s3_client_tags" {
  description = "Tags para o bucket S3 client"
  type        = map(string)
}

variable "security_group_rules" {
  description = "Lista de regras para grupos de seguranca"
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "apigateway_stage_name" {
  description = "Nome de estagio de Deploy para a API Gateway"
  type        = string
  default     = "hmg"
}
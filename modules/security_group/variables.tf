variable "vpc_id" {
  description = "ID da VPC onde o grupo de segurança será criado"
  type        = string
}

variable "name" {
  description = "Nome do grupo de segurança"
  type        = string
}

variable "description" {
  description = "Descrição do grupo de segurança"
  type        = string
}

variable "ingress_rules" {
  description = "Lista de regras de entrada"
  type = list(object({
    from_port   = number,
    to_port     = number,
    protocol    = string,
    cidr_blocks = list(string)
  }))
}

variable "egress_rules" {
  description = "Lista de regras de saída"
  type = list(object({
    from_port   = number,
    to_port     = number,
    protocol    = string,
    cidr_blocks = list(string)
  }))
}
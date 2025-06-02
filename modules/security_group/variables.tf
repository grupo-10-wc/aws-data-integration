variable "vpc_id" {
  description = "ID da VPC onde o grupo de seguranca sera criado"
  type        = string
}

variable "name" {
  description = "Nome do grupo de seguranca"
  type        = string
}

variable "description" {
  description = "Descricao do grupo de seguranca"
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
  description = "Lista de regras de saida"
  type = list(object({
    from_port   = number,
    to_port     = number,
    protocol    = string,
    cidr_blocks = list(string)
  }))
}
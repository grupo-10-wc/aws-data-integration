variable "ami" {
  description = "ID da AMI para instância EC2"
  type        = string
}

variable "instance_type" {
  description = "Tipo da instância EC2"
  type        = string
}

variable "key_name" {
  description = "Nome da chave para se conectar na instância EC2"
  type        = string
}

variable "subnet_id" {
  description = "ID da subnet em que se encontra a instância EC2"
  type        = string
}

variable "tags" {
  description = "Mapeamento de tags para associar a instância EC2"
  type = map(string)
}

variable "security_group_id" {
  description = "ID do grupo de segurança para associar com a instância EC2"
  type        = string
}
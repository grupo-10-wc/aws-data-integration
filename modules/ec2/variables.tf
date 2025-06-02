variable "ami" {
  description = "ID da AMI para instancia EC2"
  type        = string
}

variable "instance_type" {
  description = "Tipo da instancia EC2"
  type        = string
}

variable "key_name" {
  description = "Nome da chave para se conectar na instancia EC2"
  type        = string
}

variable "subnet_id" {
  description = "ID da subnet em que se encontra a instancia EC2"
  type        = string
}

variable "tags" {
  description = "Mapeamento de tags para associar a instancia EC2"
  type        = map(string)
}

variable "security_group_id" {
  description = "ID do grupo de seguranca para associar com a instancia EC2"
  type        = string
}
variable "vpc_id" {
  description = "ID da VPC"
  type        = string
}

variable "project" {
  type        = string
  description = "Projeto da Aplicação"
}

variable "environment" {
  type        = string
  description = "Ambiente de Desenvolvimento"
}

variable "security_group_name" {
  description = "Nome do grupo de segurança"
  type        = string
}

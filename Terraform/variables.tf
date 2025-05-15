variable "region" {
  type        = string
  description = "Nome do projeto"
  default     = "us-east-1"
}

variable "profile" {
  type        = string
  description = "Profile utilizada no projeto"
  default     = "treinamento"
}

variable "project" {
  type        = string
  description = "Projeto da Aplicação"
  default     = "meusite"
}

variable "environment" {
  type        = string
  description = "Ambiente de Desenvolvimento"
  default     = "dev"
}

variable "domain" {
  type        = string
  description = "Dominio da aplicação"
  default     = "supptech.net.br"
}
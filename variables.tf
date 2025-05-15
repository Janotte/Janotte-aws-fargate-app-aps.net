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

variable "github_owner" {
  type        = string
  description = "Proprietário do GitHub"
  default     = "Janotte"
}

variable "github_repo" {
  type        = string
  description = "Repositório no GitHub"
  default     = "Janotte-aws-fargate-app-aps.net"
}

variable "account_id" {
  type        = string
  description = "ID da conta aws"
  default     = "316713592474"
}

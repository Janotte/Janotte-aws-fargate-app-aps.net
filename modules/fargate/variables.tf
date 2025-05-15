variable "project" {
  type        = string
  description = "Projeto da Aplicação"
}

variable "environment" {
  type        = string
  description = "Ambiente de Desenvolvimento"
}

variable "fargate_name" {
  description = "Nome para o Fargate"
  type        = string
}
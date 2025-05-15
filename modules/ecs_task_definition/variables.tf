variable "project" {
  type        = string
  description = "Projeto da Aplicação"
}

variable "environment" {
  type        = string
  description = "Ambiente da Aplicação"
}

variable "family_name" {
  description = "Nome da família da Task Definition"
  type        = string
}

variable "cpu" {
  description = "Quantidade de CPU para a Task Definition"
  type        = string
  default = "256"
}

variable "memory" {
  description = "Quantidade de memória para a Task Definition"
  type        = string
  default = "512"
}

variable "container_image" {
  description = "Imagem do container"
  type        = string
}

variable "execution_role_arn" {
  description = "ARN da role de execução do ECS"
  type        = string
}


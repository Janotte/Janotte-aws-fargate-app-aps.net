variable "project" {
  type        = string
  description = "Projeto da Aplicação"
}
variable "environment" {
  type        = string
  description = "Ambiente de Desenvolvimento"
}

variable "alb_name" {
  type        = string
  description = "Nome do Application Load Balancer"
}

variable "subnets" {
  type        = list(string)
  description = "Subnets públicas para o ALB"
}

variable "security_groups" {
  type        = list(string)
  description = "Grupo de segurança associado ao ALB"
}

variable "vpc_id" {
  type        = string
  description = "VPC onde o ALB será criado"
}

variable "target_group_name" {
  type        = string
  description = "Nome do target group"
}

variable "target_group_port" {
  type        = number
  description = "Valor para porta do target group"
  default     = 80
}

variable "health_check_path" {
  type        = string
  description = "Valor para o health check do target group"
  default     = "/"
}

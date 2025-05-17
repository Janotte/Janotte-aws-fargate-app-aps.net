variable "project" {
  type        = string
  description = "Projeto da Aplicação"
}


variable "service_name" {
  description = "Nome do serviço ECS"
  type        = string
}

variable "cluster_id" {
  description = "ID do cluster ECS"
  type        = string
}

variable "task_definition_arn" {
  description = "ARN da Task Definition"
  type        = string
}

variable "desired_count" {
  description = "Número desejado de instâncias do serviço"
  type    = number
  default = 1
}
variable "subnets" {
  description = "Subnets para o serviço ECS"
  type = list(string)
}

variable "security_group_id" {
  description = "ID do grupo de segurança para o serviço ECS"
  type = string
}   

variable "target_group_arn" {
  description = "ARN do Target Group"
  type        = string
}  

variable "alb_listener_arn" {
  description = "ARN do listener HTTP para garantir ordem de criação"
}

variable "container_name" {
  description = "Nome do container"
  type        = string
}
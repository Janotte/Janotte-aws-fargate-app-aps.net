variable "alarm_name" {
  description = "Nome do alarme"
  type        = string
}

variable "alarm_description" {
  description = "Descrição do alarme"
  type        = string  
}

variable "cluster_name" {
  description = "Nome do cluster ECS"
  type        = string  
}

variable "service_name" {
  description = "Nome do serviço ECS"
  type        = string      
}
variable "connection_name" {
  description = "Nome da conexão do GitHub"
  type        = string
}

variable "provider_type" {
  description = "Tipo de provedor da conexão"
  type        = string
  default     = "GitHub"
}
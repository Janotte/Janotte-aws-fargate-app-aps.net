variable "project" {
  type        = string
  description = "Projeto da Aplicação"
}

variable "environment" {
  type        = string
  description = "Ambiente da Aplicação"
}

variable "github_owner" {
  description = "Proprietário do repositório no GitHub"
  type        = string
}

variable "github_repo" {
  description = "Repositório no GitHub"
  type        = string
}

variable "codestar_connection_arn" {
  description = "ARN da conexão do AWS CodeStar"
  type        = string
}

variable "codebuild_name" {
  description = "Nome para o CodeBuilder"
  type        = string
}

variable "codebuild_role_arn" {
  description = "ARN da role do CodeBuild"
  type = string
}

variable "artifact_bucket" {
  description = "Nome do bucket S3 para os artefatos"
  type = string
}

variable "artifact_path" {
  description = "Caminho do artefato no bucket S3"
  type = string
}

variable "environment_variables" {
  description = "Variáveis de ambiente para o CodeBuild"
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

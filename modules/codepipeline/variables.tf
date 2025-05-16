variable "project" {
  description = "Projeto da Aplicação"
  type        = string
}

variable "environment" {
  description = "Ambiente da Aplicação"
  type        = string
}
variable "codepipeline_name" {
  description = "Nome do CodePipeline"
  type        = string
} 

variable "codepipeline_role_arn" {
  description = "ARN da role usada pelo CodePipeline"
  type        = string
}

variable "codebuild_project_name" {
  description = "Nome do projeto CodeBuild"
  type        = string
}

variable "artifact_bucket" {
  description = "Nome do bucket S3 para os artefatos"
  type        = string
}

variable "codestar_connection_arn" {
  description = "ARN da conexão do CodeStar"
  type        = string
}

variable "ecs_cluster_name" {
  description = "Nome do ECS Cluster"
  type        = string
}

variable "ecs_service_name" {
  description = "Nome do ECS Service"
  type        = string
}

variable "github_owner" {
  description = "Dono do repositório GitHub"
  type        = string
}

variable "github_repo" {
  description = "Nome do repositório GitHub"
  type        = string
}

variable "github_branch" {
  description = "Branch a ser monitorado"
  default     = "main"
}



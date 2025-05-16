variable "codebuild_role_name" {
  description = "Nome para o CodeBuilder"
  type        = string
}

variable "codebuild_policy_name" {
  description = "Nome da Policy do CodeBuild"
  type        = string
}

variable "ecs_task_execution_role_name" {
  description = "Nome da role de execução do ECS"
  type        = string
}

variable "codedeploy_policy_name" {
  description = "Nome da policy do CodeDeploy"
  type        = string
}

variable "codedeploy_role_name" {
  description = "Nome da role do CodeDeploy"
  type        = string
}

variable "codepipipeline_policy_name" {
  description = "Nome da policy do CodePipeline"
  type        = string
}

variable "codepipeline_role_name" {
  description = "Nome da role do CodePipeline"
  type        = string
}

variable "codestar_connection_arn" {
  description = "ARN da conexão do CodeStar"
  type        = string
}

variable "bucket_arn" {
  description = "ARN do bucket S3 para os artefatos"
  type        = string
}
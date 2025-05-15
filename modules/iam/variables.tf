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
# Criando a VPC e as subnets
module "main" {
  source                = "./modules/vpc"
  vpc_name              = "${var.project}-${var.environment}-vpc"
  vpc_cidr              = "10.0.0.0/16"
  public_subnet_a_cidr  = "10.0.1.0/24"
  public_subnet_b_cidr  = "10.0.2.0/24"
  private_subnet_a_cidr = "10.0.101.0/24"
  private_subnet_b_cidr = "10.0.102.0/24"
  region                = var.region
  project               = var.project
  environment           = var.environment
}

# Criando um grupo de segurança para containers
module "containers_security_group" {
  source              = "./modules/security_groups"
  security_group_name = "${var.project}-${var.environment}-containers-sg"
  vpc_id              = module.main.vpc_id
  project             = var.project
  environment         = var.environment
}

# Criando o Application Load Balancer, associando as subnets e grupo de segurança
module "alb" {
  source            = "./modules/alb"
  alb_name          = "${var.project}-${var.environment}-alb"
  subnets           = [module.main.public_subnet_a_id, module.main.public_subnet_b_id]
  security_groups   = [module.containers_security_group.containers_sg_id]
  vpc_id            = module.main.vpc_id
  target_group_name = "${var.project}-${var.environment}-tg"
  target_group_port = 80
  health_check_path = "/"
  project           = var.project
  environment       = var.environment
}

# Criando o cluster ECS Fargate
module "fargate_cluster" {
  source       = "./modules/fargate"
  fargate_name = "${var.project}-${var.environment}-cluster"
  project      = var.project
  environment  = var.environment
}

# Criando o bucket s3 para os artefatos do build
module "artifacts_bucket" {
  source      = "./modules/s3_artifacts"
  bucket_name = "${var.project}-${var.environment}-artifacts.${var.domain}"
  environment = var.environment
  project     = var.project
}

# Criando a conexão com o GitHub
module "github_connection" {
  source          = "./modules/github_connection"
  connection_name = "github-connection"
  github_provider = "GitHub"

}

# Criando um repositório ECR 
module "ecr_repository" {
  source          = "./modules/ecr_repository"
  repository_name = "${var.project}-${var.environment}-ecr-repository"
  project         = var.project
  environment     = var.environment
}

# Criando a Role para o CodeBuild
module "iam" {
  source                       = "./modules/iam"
  codebuild_role_name          = "${var.project}-${var.environment}-codebuild-service-role"
  codebuild_policy_name        = "${var.project}-${var.environment}-codebuild-base-policy"
  codedeploy_role_name         = "${var.project}-${var.environment}-codedeploy-service-role"
  codedeploy_policy_name       = "${var.project}-${var.environment}-codedeploy-base-policy"
  codepipeline_role_name       = "${var.project}-${var.environment}-codepipeline-service-role"
  codepipipeline_policy_name   = "${var.project}-${var.environment}-codepipeline-base-policy"
  ecs_task_execution_role_name = "${var.project}-${var.environment}-ecs-task-execution-role"
  codestar_connection_arn      = module.github_connection.codestar_connection_arn
  bucket_arn                   = module.artifacts_bucket.bucket_arn
}

# Criando o CodeBuild
module "codebuild" {
  source                  = "./modules/codebuild"
  codebuild_name          = "${var.project}-${var.environment}-codebuild"
  codebuild_role_arn      = module.iam.codebuild_role_arn
  github_owner            = var.github_owner
  github_repo             = var.github_repo
  artifact_bucket         = module.artifacts_bucket.bucket_name
  artifact_path           = ""
  codestar_connection_arn = module.github_connection.codestar_connection_arn
  environment_variables = [
    { name = "AWS_REGION", value = "${var.region}" },
    { name = "AWS_ACCOUNT_ID", value = "${var.account_id}" },
    { name = "IMAGE_REPO_NAME", value = "${module.ecr_repository.ecr_repository_name}" },
    { name = "IMAGE_TAG", value = "latest" },
    { name = "CONTAINER_NAME", value = "meusite-dev-container" },
    { name = "ASPNETCORE_ENVIRONMENT", value = "Production" },
  ]
  project     = var.project
  environment = var.environment
}

# Criando Task Definition com imagem e role
module "ecs_task_definition" {
  source             = "./modules/ecs_task_definition"
  family_name        = "${var.project}-${var.environment}-fargate-task"
  cpu                = "256"
  memory             = "512"
  container_image    = module.ecr_repository.ecr_image_url
  execution_role_arn = module.iam.ecs_execution_role_arn
  project            = var.project
  environment        = var.environment
}

# Criando o ECS Service com ALB e cluster
module "ecs_service" {
  source              = "./modules/ecs_service"
  service_name        = "${var.project}-${var.environment}-ecs-service"
  container_name      = "${var.project}-${var.environment}-container"
  cluster_id          = module.fargate_cluster.cluster_id
  task_definition_arn = module.ecs_task_definition.task_definition_arn
  desired_count       = 1
  subnets             = [module.main.public_subnet_a_id, module.main.public_subnet_b_id]
  security_group_id   = module.containers_security_group.containers_sg_id
  target_group_arn    = module.alb.target_group_arn
  alb_listener_arn    = module.alb.listener_arn
  project             = var.project
}

# Criando o CodePipeline
module "codepipeline" {
  source                = "./modules/codepipeline"
  codepipeline_name     = "${var.project}-${var.environment}-codepipeline"
  codepipeline_role_arn = module.iam.codepipeline_role_arn

  artifact_bucket = module.artifacts_bucket.bucket_name

  codestar_connection_arn = module.github_connection.codestar_connection_arn
  github_owner            = var.github_owner
  github_repo             = var.github_repo
  github_branch           = var.github_branch

  codebuild_project_name = module.codebuild.codebuild_project_name

  ecs_cluster_name = "meusite-dev-cluster"
  ecs_service_name = "meusite-dev-ecs-service"

  region      = var.region
  project     = var.project
  environment = var.environment
}

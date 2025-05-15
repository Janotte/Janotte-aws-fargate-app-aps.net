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
  source = "./modules/github_connection"
  connection_name   = "${var.project}-${var.environment}-github-connection"
  provider_type = "GitHub"
}

# Criando um repositório ECR 
module "ecr_repository" {
  source          = "./modules/ecr_repository"
  repository_name = "${var.project}-${var.environment}-ecr-repository"
  project         = var.project
  environment     = var.environment
}
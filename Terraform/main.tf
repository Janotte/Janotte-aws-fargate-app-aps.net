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
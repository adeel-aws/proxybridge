provider "aws" {
  region = var.region
}

module "vpc" {
  source = "../modules/vpc"

  vpc_name           = var.vpc_name
  vpc_cidr           = var.vpc_cidr
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
  azs                = var.azs
  enable_nat_gateway = var.enable_nat_gateway
  create_eip         = var.create_eip
  create_ec2_sg      = var.create_ec2_sg
  db_port            = var.db_port
  ec2_ingress_rules  = var.ec2_ingress_rules

}

module "ec2" {
  source            = "../modules/ec2"
  ami_id            = var.ami_id
  instance_type     = var.instance_type
  subnet_id         = module.vpc.public_subnet_ids[0]
  security_group_ids = [module.vpc.ec2_sg_id]
  instance_name     = var.instance_name
  key_name          = var.keypair
  enable_ssm        = var.enable_ssm
  user_data         = file("./squid-proxy.sh")
  environment       = var.environment
  
}

module "ec2-V2" {
  source            = "../modules/ec2"
  ami_id            = var.ami_id
  instance_type     = var.instance_type
  subnet_id         = module.vpc.private_subnet_ids[0]
  security_group_ids = [module.vpc.db_sg_id]
  instance_name     = var.instance_name2
  enable_ssm        = var.enable_ssm
  environment       = var.environment
  user_data         = file("./Nginx.sh")
  
}

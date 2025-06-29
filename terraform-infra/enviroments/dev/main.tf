
terraform {
  backend "s3" {
    bucket         = "remote-tf-state-mehran-qr"
    key            = "dev/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-state-locking"
    encrypt        = true
  }

  required_version = ">= 1.2"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
}

module "vpc" {
  source              = "../../modules/vpc"
  name                = "dev"
  vpc_cidr            = "10.0.0.0/16"
  public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
  azs                 = ["eu-central-1a", "eu-central-1b"]
  tags = {
    Environment = "dev"
    Project     = "qr-app"
  }
}


module "security_groups" {
  source = "../../modules/security_groups"
  name   = "dev-sg"
  vpc_id = module.vpc.vpc_id

  tags = {
    Environment = "dev"
    Project     = "qr"
  }
}


module "ecr" {
  source             = "../../modules/ecr"
  frontend_repo_name = "qr-frontend"
  backend_repo_name  = "qr-backend"
  project            = "qr"
  tags = {
    Environment = "dev"
  }
}


module "ec2" {
  source                 = "../../modules/ec2"
  name                   = "dev-qr"
  instance_type          = "t3.micro"
  subnet_ids             = module.vpc.public_subnet_ids
  security_group_ids     = [module.security_groups.app_sg_id]
  key_name               = "mehran-key-qr"
  docker_compose_version = "1.29.2"
  aws_account_id         = "209479274418"
  frontend_repo_name     = "qr-frontend"
  backend_repo_name      = "qr-backend"
  aws_region             = "eu-central-1"
  tags = {
    Environment = "dev"
    Project     = "qr"
  }
}


module "alb" {
  source               = "../../modules/alb"
  name                 = "dev-qr"
  subnet_ids           = module.vpc.public_subnet_ids
  vpc_id               = module.vpc.vpc_id
  lb_security_group_id = module.security_groups.lb_sg_id
  target_instance_ids  = [module.ec2.instance_id]
  certificate_arn = module.acm.this_acm_certificate_arn
  health_check_path = "/"
  target_port          = 80
  tags = {
    Environment = "dev"
    Project     = "qr"
  }
}


module "dns_record" {
  source       = "../../modules/route53_record"
  zone_id      = "Z07026343J2N6WJUNC8OI"
  record_name  = "dev.mehran.app"
  alb_dns_name = module.alb.alb_dns_name
  alb_zone_id  = module.alb.alb_zone_id
}

module "dns_record_api" {
  source       = "../../modules/route53_record"
  zone_id      = "Z07026343J2N6WJUNC8OI"
  record_name  = "api.dev.mehran.app"
  alb_dns_name = module.alb.alb_dns_name
  alb_zone_id  = module.alb.alb_zone_id
}


module "acm" {
  source          = "../../modules/acm"
  primary_domain  = "dev.mehran.app"
  san_domains     = ["api.dev.mehran.app"]
  zone_id         = "Z07026343J2N6WJUNC8OI"
  tags = {
    Environment = "dev"
    Project     = "qr"
  }
}

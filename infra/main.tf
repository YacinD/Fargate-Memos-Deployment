# ---------- Route 53 (existing hosted zone from ClickOps) ----------

data "aws_route53_zone" "main" {
  name         = var.domain_name
  private_zone = false
}

# ---------- VPC ----------

module "vpc" {
  source       = "./modules/vpc"
  project_name = var.project_name
  environment  = var.environment
}

# ---------- ECR ----------

module "ecr" {
  source          = "./modules/ecr"
  repository_name = "ecs-memos"
  environment     = var.environment
}

# ---------- ACM ----------

module "acm" {
  source          = "./modules/acm"
  domain_name     = var.domain_name
  route53_zone_id = data.aws_route53_zone.main.zone_id
  environment     = var.environment
}

# ---------- ALB ----------

module "alb" {
  source            = "./modules/alb"
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  certificate_arn   = module.acm.certificate_arn
  project_name      = var.project_name
  environment       = var.environment
}

# ---------- ECS ----------

module "ecs" {
  source                 = "./modules/ecs"
  project_name           = var.project_name
  environment            = var.environment
  container_image        = var.container_image
  private_subnet_ids     = module.vpc.private_subnet_ids
  ecs_security_group_id  = module.alb.ecs_security_group_id
  target_group_arn       = module.alb.target_group_arn
  aws_region              = var.aws_region
}

# ---------- Route 53 A record -> ALB ----------

resource "aws_route53_record" "app" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = module.alb.alb_dns_name
    zone_id                = module.alb.alb_zone_id
    evaluate_target_health = true
  }
}
module "vpc" {
  source       = "./modules/vpc"
  project_name = var.project_name
}

module "ecr" {
  source          = "./modules/ecr"
  repository_name = "ecs-memos"
}

module "acm" {
  source                  = "./modules/acm"
  domain_name             = var.domain_name
  validation_record_fqdns = module.route53.validation_record_fqdns
}

module "route53" {
  source                    = "./modules/route53"
  domain_name               = var.domain_name
  domain_validation_options = module.acm.domain_validation_options
  alb_dns_name              = module.alb.dns_name
  alb_zone_id               = module.alb.zone_id
}

module "alb" {
  source            = "./modules/alb"
  project_name      = var.project_name
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  certificate_arn   = module.acm.certificate_arn
}

module "ecs" {
  source                = "./modules/ecs"
  project_name          = var.project_name
  service_name          = "memos-task-service-luk8cbkx"
  vpc_id                = module.vpc.vpc_id
  private_subnet_ids    = module.vpc.private_subnet_ids
  alb_security_group_id = module.alb.security_group_id
  target_group_arn      = module.alb.target_group_arn
  container_image       = var.container_image
}
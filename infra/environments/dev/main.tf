module "memos" {
  source = "../../"

  aws_region      = var.aws_region
  project_name    = var.project_name
  environment     = var.environment
  domain_name     = var.domain_name
  container_image = var.container_image
}
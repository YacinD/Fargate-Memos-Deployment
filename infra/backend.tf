terraform {
  backend "s3" {
    bucket       = "ecsv1-terraform-state"
    key          = "infra/terraform.tfstate"
    region       = "eu-west-2"
    use_lockfile = true
    encrypt      = true
  }
}
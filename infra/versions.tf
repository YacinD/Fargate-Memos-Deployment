terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    # Fill in during setup, e.g.:
    # bucket = "memos-terraform-state"
    # key    = "memos/terraform.tfstate"
    # region = "eu-west-2"
    # dynamodb_table = "memos-terraform-locks"
  }
}
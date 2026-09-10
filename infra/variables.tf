variable "region" {
  type    = string
  default = "eu-west-2"
}

variable "aws_region" {
  type    = string
  default = "eu-west-2"
}

variable "project_name" {
  type    = string
  default = "memos"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "domain_name" {
  type    = string
  default = "ecsv1.online"
}

variable "container_image" {
  type    = string
  default = "956076205260.dkr.ecr.eu-west-2.amazonaws.com/ecs-memos:v1"
}
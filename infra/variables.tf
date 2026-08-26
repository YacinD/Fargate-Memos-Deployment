variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-2"
}

variable "project_name" {
  description = "Project name used for naming"
  type        = string
  default     = "memos"
}

variable "environment" {
  description = "Environment name (dev/prod)"
  type        = string
}

variable "domain_name" {
  description = "Root domain name"
  type        = string
  default     = "ecsv1.online"
}

variable "container_image" {
  description = "Full ECR image URI including tag"
  type        = string
}
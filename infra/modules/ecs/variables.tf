variable "cluster_name" {
  description = "ECS cluster name"
  type        = string
  default     = "memos-cluster"
}

variable "task_family" {
  description = "ECS task definition family name"
  type        = string
  default     = "memos-task"
}

variable "container_name" {
  description = "Container name"
  type        = string
  default     = "memos"
}

variable "container_image" {
  description = "Full ECR image URI including tag"
  type        = string
}

variable "container_port" {
  description = "Port the container listens on"
  type        = number
  default     = 5230
}

variable "cpu" {
  description = "Task CPU units (0.5 vCPU = 512)"
  type        = number
  default     = 512
}

variable "memory" {
  description = "Task memory in MB (1 GB = 1024)"
  type        = number
  default     = 1024
}

variable "private_subnet_ids" {
  description = "Private subnet IDs for ECS tasks"
  type        = list(string)
}

variable "ecs_security_group_id" {
  description = "Security group ID for ECS tasks"
  type        = string
}

variable "target_group_arn" {
  description = "ALB target group ARN"
  type        = string
}

variable "desired_count" {
  description = "Desired number of running tasks"
  type        = number
  default     = 1
}

variable "environment" {
  description = "Environment name (dev/prod)"
  type        = string
}

variable "project_name" {
  description = "Project name used for naming"
  type        = string
  default     = "memos"
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-2"
}
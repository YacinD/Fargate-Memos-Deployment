variable "project_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "container_port" {
  type    = number
  default = 5230
}

variable "health_check_path" {
  type    = string
  default = "/"
}

variable "ssl_policy" {
  type    = string
  default = "ELBSecurityPolicy-TLS13-1-2-Res-PQ-2025-09"
}

variable "certificate_arn" {
  # Comes from the acm module's output — the validated cert ARN
  type = string
}
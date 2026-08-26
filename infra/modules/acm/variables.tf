variable "domain_name" {
  description = "Primary domain name for the certificate"
  type        = string
  default     = "ecsv1.online"
}

variable "subject_alternative_names" {
  description = "Additional domain names (SANs) for the certificate"
  type        = list(string)
  default     = ["*.ecsv1.online"]
}

variable "route53_zone_id" {
  description = "Route 53 hosted zone ID for DNS validation"
  type        = string
}

variable "environment" {
  description = "Environment name (dev/prod)"
  type        = string
}
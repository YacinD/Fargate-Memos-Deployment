variable "domain_name" {
  type = string
}

variable "validation_record_fqdns" {
  # Comes from the route53 module's output, AFTER it creates the
  # validation CNAME records using this module's domain_validation_options
  type = list(string)
}
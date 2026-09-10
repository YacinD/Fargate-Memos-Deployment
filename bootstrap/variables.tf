variable "aws_region" {
  type    = string
  default = "eu-west-2"
}

variable "state_bucket_name" {
  type = string
}

variable "lock_table_name" {
  type    = string
  default = "ecsv1-tf-lock"
}
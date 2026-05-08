# terraform/bootstrap/variables.tf

variable "aws_region" {
  description = "AWS region used for bootstrap resources"
  type        = string
  default     = "eu-central-1"
}
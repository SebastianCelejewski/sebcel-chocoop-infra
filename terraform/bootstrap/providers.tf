# terraform/bootstrap/providers.tf

provider "aws" {
  region = var.aws_region
}
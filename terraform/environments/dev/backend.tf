terraform {
  backend "s3" {
    bucket         = "sebcel-chocoop-infra-tfstate"
    key            = "dev/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "sebcel-chocoop-infra-locks"
    encrypt        = true
  }
}
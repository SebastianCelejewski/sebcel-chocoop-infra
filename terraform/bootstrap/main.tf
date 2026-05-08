# terraform/bootstrap/main.tf

resource "aws_s3_bucket" "terraform_state" {
  bucket = "sebcel-chocoop-infra-tfstate"

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name         = "sebcel-chocoop-infra-tfstate"
    application  = "sebcel-chocoop"
    component    = "infra"
    environment  = "shared"
    owner        = "Sebastian.Celejewski@wp.pl"
    managed-by   = "terraform"
  }
}

resource "aws_s3_bucket_versioning" "terraform_state_versioning" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state_encryption" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "terraform_state_public_access" {
  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "sebcel-chocoop-infra-locks"
  billing_mode = "PAY_PER_REQUEST"

  hash_key = "LockID"

  lifecycle {
    prevent_destroy = true
  }

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name         = "sebcel-chocoop-infra-locks"
    application  = "sebcel-chocoop"
    component    = "infra"
    environment  = "shared"
    owner        = "Sebastian.Celejewski@wp.pl"
    managed-by   = "terraform"
  }
}
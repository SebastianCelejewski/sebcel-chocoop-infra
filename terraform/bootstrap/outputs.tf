# terraform/bootstrap/outputs.tf

output "terraform_state_bucket_name" {
  value = aws_s3_bucket.terraform_state.bucket
}

output "terraform_locks_table_name" {
  value = aws_dynamodb_table.terraform_locks.name
}
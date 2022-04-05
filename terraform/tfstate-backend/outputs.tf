output "tfstate_bucket" {
  value = module.s3_bucket.s3_bucket_id
}

output "aws_region" {
  value = var.aws_region
}
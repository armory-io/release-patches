provider "aws" {
  region = var.aws_region
}

module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"
  bucket = "internal-prod-spinnaker-sandbox-integrations-tfstate-backends"
  acl    = "private"
  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true

  versioning = {
    enabled = true
  }

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm     = "AES256"
        kms_master_key_id = null
      }
    }
  }

  tags = {
    Purpose = "State files bucket for all ephemeral spinnaker-sandbox"
    Owner   = "${var.team}@armory.io"
  }
}
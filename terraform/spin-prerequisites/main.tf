terraform {
  backend "s3" {
  }
}

provider "vault" {
  address = "https://vault.cloud.armory.io"
}

data "vault_aws_access_credentials" "account" {
  backend = "aws/${var.aws_account_name}"
  role = "admin"
  type = "sts"
}

provider "aws" {
  region = var.aws_region
  access_key = data.vault_aws_access_credentials.account.access_key
  secret_key = data.vault_aws_access_credentials.account.secret_key
  token = data.vault_aws_access_credentials.account.security_token
}

module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"
  bucket = "${var.owner}-spinnaker-sandbox-files"
  acl    = "private"
  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true

  force_destroy = true
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
    Purpose = "Spinnaker files for ${var.owner} team spinnaker-sandbox"
    Owner   = "${var.owner}@armory.io"
  }
}



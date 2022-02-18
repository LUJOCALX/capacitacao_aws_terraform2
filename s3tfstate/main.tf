provider "aws" {
  region = "us-east-1"
}

data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "ljc-tfstate-remote-terraform" {

  bucket = "ljc-tfstate-remote-terraform"

  tags = {

    Descricao = "Armazena o terraform tfstate remotamente"
    UsadoPor  = "Terraform"
    Owner     = "ljc"
  }
}

resource "aws_s3_bucket_versioning" "versionamento" {
  bucket = aws_s3_bucket.ljc-tfstate-remote-terraform.id

  versioning_configuration {

    status = "Enabled"

  }
}

resource "aws_s3_bucket_public_access_block" "semacessopublico" {
  bucket = aws_s3_bucket.ljc-tfstate-remote-terraform.id

  block_public_acls   = true
  block_public_policy = true
}

output "remote_state_bucket" {

  value = aws_s3_bucket.ljc-tfstate-remote-terraform.bucket
}

output "remote_state_bucket_arn" {

  value = aws_s3_bucket.ljc-tfstate-remote-terraform.arn
}


resource "aws_kms_key" "mykey" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10


}

resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = aws_s3_bucket.ljc-tfstate-remote-terraform.bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.mykey.arn
      sse_algorithm     = "aws:kms"
    }
  }
}
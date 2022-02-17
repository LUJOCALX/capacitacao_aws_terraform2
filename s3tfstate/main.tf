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

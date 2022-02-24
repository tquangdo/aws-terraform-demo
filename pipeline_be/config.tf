# IMPORTANT!!! Make sure the S3 bucket & DynamoDB exists
terraform {
  required_version = ">= 0.12.0"
  backend "s3" {
    encrypt        = true
    bucket         = "dtq-bucket-terraform-cicd"
    dynamodb_table = "DTQDynamoDBTerraformStateLock"
    key            = "terraform.tfstate"
    region         = "us-east-1"
  }
}
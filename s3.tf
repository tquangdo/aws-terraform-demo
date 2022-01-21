terraform {
  backend "s3" {
    bucket = "dtq-terraform"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
terraform {
  backend "s3" {
    bucket         = "DevOps29072025"
    key            = "terraform/terraform.tfstate"
    region         = "us-west-1"
  }
}
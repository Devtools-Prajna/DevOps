terraform {
  backend "s3" {
    bucket         = "devops29072025"
    key            = "terraform/terraform.tfstate"
    region         = "us-east-1"
  }
}
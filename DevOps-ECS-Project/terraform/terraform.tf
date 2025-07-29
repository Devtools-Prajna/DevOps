terraform {
  backend "s3" {
    bucket         = "DevOps29072025"
    key            = "/var/lib/jenkins/workspace/DevOps-ECS-Project/DevOps-ECS-Project/terraform/terraform.tfstate"
    region         = "us-west-1"
  }
}
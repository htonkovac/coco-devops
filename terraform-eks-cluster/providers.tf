terraform {
  required_version = ">= 0.12.0"

   backend "s3" {
    bucket = "devops-test-task-eks-cluster-terraform-state"
    key    = "terraform_state"
    region = "eu-central-1"
  }
}

provider "aws" {
  version = ">= 2.11"
  region  = var.region
}

provider "random" {
  version = "~> 2.1"
}

provider "local" {
  version = "~> 1.2"
}

provider "null" {
  version = "~> 2.1"
}

provider "template" {
  version = "~> 2.1"
}
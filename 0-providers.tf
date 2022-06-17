terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.17"
    }
  }
}




provider "aws" {
  region  = "eu-west-1"
  access_key = "aws_access_key"
  secret_key = "aws_secret_key"
}

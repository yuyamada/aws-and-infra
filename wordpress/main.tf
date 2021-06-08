terraform {
  backend "s3" {
    bucket = "yuyamada-terraform"
    key    = "aws_and_infra/wordpress/terraform.tfstate"
    region = "ap-northeast-1"
  }
}

data "terraform_remote_state" "common" {
  backend = "s3"
  config = {
    bucket = "yuyamada-terraform"
    key    = "aws_and_infra/common/terraform.tfstate"
    region = "ap-northeast-1"
  }
}

provider "aws" {
  region = "ap-northeast-1"
}

locals {
  project_name = "aws-and-infra"
}

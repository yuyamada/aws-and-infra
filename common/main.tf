terraform {
  backend "s3" {
    bucket = "yuyamada-terraform"
    key    = "aws_and_infra/common/terraform.tfstate"
    region = "ap-northeast-1"
  }
}

provider "aws" {
  region = "ap-northeast-1"
}

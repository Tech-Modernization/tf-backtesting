provider "aws" {
  region = "us-east-1"
}

module "dev_aws-virginia_backtesting" {
  source = "./config"
}

provider "aws" {
  region = "us-east-1"
}

module "dev_aws-virginia_backtesting_env1" {
  source = "git::https://github.com/contino/occ-terraform-app//aws/compute/ec2_instance"

  instance_type = "${var.instance_type}"

  instance_name = "${var.instance_name}"
}

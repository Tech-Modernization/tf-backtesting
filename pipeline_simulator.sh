#!/bin/bash

TARGET_ENV=$1

rm -f main.tf backend.tf

echo -e "Generating main.tf for ${TARGET_ENV}\n"

cat << EOF > ./main.tf
provider "aws" {
  region = "us-east-1"
}

module "dev_aws-virginia_backtesting_${TARGET_ENV}" {
  source = "git::https://github.com/contino/occ-terraform-app//aws/compute/ec2_instance"

  instance_type = "\${var.instance_type}"

  instance_name = "\${var.instance_name}"
}
EOF

cat ./main.tf

echo -e "\n"

echo -e "Generating backend.tf for ${TARGET_ENV}\n"

cat << EOF > ./backend.tf
terraform {
  backend "s3" {
    bucket = "occ-terraform-backend"
    key    = "backtesting_${TARGET_ENV}.tfstate"
    region = "us-east-1"
  }
}
EOF

cat ./backend.tf

terraform init -reconfigure

terraform plan -var-file=environments/tf_env_backtesting_${TARGET_ENV}.tfvars

# terraform apply -var-file=environments/tf_env_backtesting_${TARGET_ENV}.tfvars -auto-approve


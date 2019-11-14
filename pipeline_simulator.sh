#!/bin/bash

if [[ -z $1 ]]; then
	echo -e "\nPlease specify env as command line arg 1\n"
	exit 1
fi

TARGET_ENV=$1

STRATEGY=$2

echo -e "Generating temporary config directory for ${TARGET_ENV} ....\n"

mkdir temp

echo -e "Copying ${TARGET_ENV}'s config and vars file into temporary directory ....\n"

cp config/tf_env_backtesting_${TARGET_ENV}.tf temp/

ls temp

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

echo -e "\n\n"

terraform get

terraform init -reconfigure

echo -e "\n\n"

terraform plan -out tfplan

echo -e "\n\n"

if [[ $STRATEGY == 'apply' ]]; then
	terraform apply --auto-approve tfplan
elif [[ $STRATEGY == 'destroy' ]]; then
	terraform destroy --auto-approve
fi

rm -rf temp
rm -f backend.tf
rm -f tfplan
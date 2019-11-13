terraform {
  backend "s3" {
    bucket = "occ-terraform-backend"
    key    = "terraform_env1.tfstate"
    region = "us-east-1"
  }
}

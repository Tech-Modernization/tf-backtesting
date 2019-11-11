terraform {
  backend "s3" {
    bucket = "occ-terraform-backend"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}

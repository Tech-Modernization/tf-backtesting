module "tf_env_backtesting_env1" {
  source        = "git::https://github.com/contino/occ-terraform-app//aws/compute/ec2_instance"
  instance_type = "t2.micro"
  instance_name = "test-instance-1"
}

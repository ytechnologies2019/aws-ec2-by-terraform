module "main_vpc" {
  source = "./vpc"
}

module "main_ec2" {
  source            = "./ec2"
  private_subnet    = module.main_vpc.private_subnet
  security_group_id = module.public_sg.security_group_id
}

module "public_sg" {
  source = "./security_group"
  vpc_id = module.main_vpc.vpc_id
}
module "main" {
  source = "./modules"

  region          = var.region
  cluster_name    = var.cluster_name
  vpc_cidr        = var.vpc_cidr
  pri_sub_count   = var.pri_sub_count
  pri_sub_block   = var.pri_sub_block
  pri_sub_azs     = var.pri_sub_azs
  pub_sub_count   = var.pub_sub_count
  pub_sub_block   = var.pub_sub_block
  pub_sub_azs     = var.pub_sub_azs
  key_name        = var.key_name
  ami             = var.ami
  first_instance_name = var.first_instance_name
  first_instance_type = var.first_instance_type
  second_instance_name = var.second_instance_name
  second_instance_type = var.second_instance_type   
}
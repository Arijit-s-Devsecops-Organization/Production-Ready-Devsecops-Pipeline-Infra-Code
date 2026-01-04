module "main" {
  source = "./modules/main"

  region          = var.region
  cluster_name    = var.cluster_name
  vpc_cidr        = var.vpc_cidr
  pri_sub_count   = var.pri_sub_count
  pri_sub_block   = var.pri_sub_block
  pri_sub_azs     = var.pri_sub_azs
  pub_sub_count   = var.pub_sub_count
  pub_sub_block   = var.pub_sub_block
  pub_sub_azs     = var.pub_sub_azs
}
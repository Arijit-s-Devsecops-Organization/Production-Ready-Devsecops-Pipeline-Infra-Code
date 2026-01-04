variable "region" {}
variable "vpc_cidr" {}
variable "pri_sub_count" {
  type = number
}
variable "pri_sub_block" {
  type = list(string)
}
variable "pri_sub_azs" {
  type = list(string)
}
variable "pub_sub_count" {
  type = number
}
variable "pub_sub_block" {
  type = list(string)
}
variable "pub_sub_azs" {
  type = list(string)
}
variable "cluster_name" {}
variable "key_name" {}
variable "ami" {}
variable "first_instance_name" {}
variable "first_instance_type" {}
variable "second_instance_type" {}
variable "second_instance_name" {}
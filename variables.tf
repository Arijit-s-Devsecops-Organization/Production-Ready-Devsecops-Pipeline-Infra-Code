# Non-confidential variables
variable "region" {
    default = "us-east-1"
    type = string
}
variable "cluster_name" {
    default = "main-cluster"
    type = string
}
variable "key_name" {
    type = string
    default = "ec2-key-pair"
}

# Confidential variables
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
variable "ami" {}
variable "first_instance_name" {}
variable "first_instance_type" {}
variable "second_instance_type" {}
variable "second_instance_name" {}
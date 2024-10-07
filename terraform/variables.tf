variable "region" {
  default = "ap-southeast-1"
}
variable "avail_zone" {
  default = "ap-southeast-1a"
}
variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}
variable "subnet_cidr_block" {
  default = "10.0.10.0/16"
}
variable "env_prefix" {
  default = "dev"
}
variable "my_ip" {
  default = "0.0.0.0/0"
}
variable "instance_type" {
  default = "t2.micro"
}

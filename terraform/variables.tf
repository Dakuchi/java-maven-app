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
  default = "10.0.10.0/24"
}
variable "env_prefix" {
  default = "dev"
}
variable "my_ip" {
  default = "171.243.48.128"
}
variable "jenkins_ip" {
  default = "34.124.175.117/32"
}
variable "instance_type" {
  default = "t2.micro"
}

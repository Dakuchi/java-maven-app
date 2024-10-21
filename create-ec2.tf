## AWS credentials
provider "aws" {
  region = "ap-southeast-1"
}

# fetch default VPC
data "aws_vpc" "default" {
  default = true
}

# create security group
resource "aws_security_group" "my_scr_gr" {
  name        = "myapp-security-group"
  description = "security group for my ansible project"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    prefix_list_ids = []
  }
  tags = {
    Name: "ansible-deploy"
  }
}

# query AMI
data "aws_ami" "latest-amazon-linux-image" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*-x86_64-gp2"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Create ssh public key on AWS
resource "aws_key_pair" "ssh-key" {
  key_name   = "ansible-key"
  public_key = file("/home/jayce/ansible/integrate-with-jenkins/ec2_key.pub")
}

# Create EC2 instance
resource "aws_instance" "myapp-server" {
  ami                         = data.aws_ami.latest-amazon-linux-image.id
  instance_type               = "t2.micro"
  availability_zone           = "ap-southeast-1a"
  associate_public_ip_address = true
  key_name                    = aws_key_pair.ssh-key.key_name
  security_groups             = [aws_security_group.my_scr_gr.name]
  tags                        = {
    Name: "ansible-deploy"
  }
}

# Output EC2 public ip
output "ec2_public_ip" {
  value = aws_instance.myapp-server.public_ip
}
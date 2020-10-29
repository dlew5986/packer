terraform {
  required_version = ">= 0.13, < 0.14"
}

provider "aws" {
  region  = "us-east-2"
}

data "aws_vpc" "vpc_default" {
  default = true
}

data "aws_ami" "source_ami" {
  most_recent = true
  owners      = ["self"]
  filter {
    name   = "name"
    values = ["packer-Windows_Server-2019-English-Full-Base-*"]
  }
}

resource "aws_instance" "instance" {
  ami                    = data.aws_ami.source_ami.id
  instance_type          = "t2.micro"
  key_name               = "windowsKeyPair"
  vpc_security_group_ids = [aws_security_group.security_group.id]
  tags = {
    Name = "packer-testing",
    project = "packer",
    platform = "windows_server",
    version = "2019"
  }
}

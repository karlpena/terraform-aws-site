# Configure the AWS Provider 

# Create a new instance of the latest Ubuntu 14.04 on an
# t2.micro node with an AWS Tag naming it "www-01"
# Ubuntu AMI ID = ami-0782e9ee97725263d

provider "aws" {
  region                  = "us-east-2"
  shared_credentials_file = "~/.aws/credentials"
  profile                 = "personal"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  #  ami           = "${data.aws_ami.ubuntu.id}"
  ami           = "ami-0782e9ee97725263d"
  instance_type = "t2.micro"

  tags {
    Name = "www-01"
  }




  ### ENABLE TO DEBUG CONFIGURAITON:

  #output "lb_address" {
  #  value = "${aws_alb.web.public_dns}"
  #}

  #  output "instance_ip" {
  #    value = ["${aws_instance.web.0.public_ip}"]
  #  }

  #resource "aws_security_group" "sg-www" {
  #  name = "sg-www"
  #  description = "default VPC security group"
  #
  #  # TCP access
  #    ingress {
  ##    from_port = 0
  ##    to_port = 65535
  #from_port = 22
  #to_port = 80
  #    protocol = "tcp"
  #    cidr_blocks = ["0.0.0.0/0"]
  #  }
  #
  #  # HTTP access from anywhere
  #  ingress {
  #    from_port = 80
  #    to_port = 80
  #    protocol = "tcp"
  #    cidr_blocks = ["0.0.0.0/0"]
  #  }
  #}

  #  resource "aws_iam_user" "user" {
  #    name = "${var.aws_iam_user}"
  #    path = "/"
  #  }
  #
  #    resource "aws_iam_user_ssh_key" "username" {
  #      username   = "${var.aws_ssh_user}"
  #      encoding   = "SSH"
  #      public_key = "${var.ssh_public_key}"
  #    }
}

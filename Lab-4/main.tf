#----------------------------------------------------------
#  Terraform - From Zero to Certified Professional
#
# Build WebServer during Bootstrap with external template  file
#
# Made by Denis Astahov
#----------------------------------------------------------

provider "aws" {
  region = "eu-west-1"
}

resource "aws_instance" "web" {
  ami = "ami-09e2d756e7d78558d" // Amazon Linux2
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.web.id]
  user_data = templatefile("user_data.sh.tpl", {
    f_name = "Denis"
    l_name = "Astahov"
    names  = ["John", "Angel", "David", "Victor", "Frank", "Melissa", "Kitana"]
  })
  tags = {
    Name = "WebServer Built by Terraform with external file"
    Owner = "David Racha"
  }
}

resource "aws_security_group" "web" {
  name = "WebServer-SG"
  description = "Security Group for WebServer"

  ingress {
    description = "Allow port HTTP"
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow port HTTPS"
    from_port = 443
    protocol = "tcp"
    to_port = 443
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow port SSH"
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "Allow in ALL ports"
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "WebServer SG Built by Terraform"
    Owner = "David Racha"
  }
}
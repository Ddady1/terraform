#----------------------------------------------------------
#  Terraform - From Zero to Certified Professional
#
# Build WebServer during Bootstrap with External TEMPLATE File
#
# Made by Denis Astahov
#----------------------------------------------------------

provider "aws" {
  region = "eu-west-1"
}

resource "aws_instance" "web" {
  ami                    = "ami-09e2d756e7d78558d" // Amazon Linux2
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.web.id]
  user_data = templatefile("user_data.sh.tpl", { // Template File
    f_name = "David"
    l_name = "Racha"
    names  = ["John", "Angel", "David", "Victor", "Frank", "Melissa", "Kitana"]
  })

  tags = {
    Name  = "WebServer Built by Terraform"
    Owner = "David Racha"
  }
}

resource "aws_security_group" "web" {
  name        = "WebServer-SG-15"
  description = "Security Group for my WebServer"

  ingress {
    description = "Allow port HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow port HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow ALL ports"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "WebServer SG by Terraform"
    Owner = "David Racha"
  }
}
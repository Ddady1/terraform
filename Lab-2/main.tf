#----------------------------------------------------------
#  Terraform - From Zero to Certified Professional
#
# Build WebServer during Bootstrap
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
  user_data = <<EOF
#!/bin/bash
yum -y update
yum -y install httpd
MYIP=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
echo "<h2>WebServer with PrivateIP: $MYIP</h2><br>Built by Terraform" > /var/www/html/index.html
service httpd start
chkconfig httpd on
EOF
  tags = {
    Name = "WebServer Built by Terraform"
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
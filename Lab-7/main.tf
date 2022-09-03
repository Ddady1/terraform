provider "aws" {
  region = "eu-west-1"
}
resource "aws_default_vpc" "default" {}
resource "aws_instance" "WebServer" {
  ami = "ami-09e2d756e7d78558d"
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.aws_SG_15.id]
  tags = {Name = "Web-Server"}

  depends_on = [aws_instance.AppServer]
}

resource "aws_instance" "AppServer" {
  ami = "ami-09e2d756e7d78558d"
  vpc_security_group_ids = [aws_security_group.aws_SG_15.id]
  instance_type = "t3.micro"
  tags = {Name = "App-Server"}

  depends_on = [aws_instance.DBServer]
}

resource "aws_instance" "DBServer" {
  ami = "ami-09e2d756e7d78558d"
  vpc_security_group_ids = [aws_security_group.aws_SG_15.id]
  instance_type = "t3.micro"
  tags = {Name = "DB-Server"}
}

resource "aws_security_group" "aws_SG_15" {
  name = "Servers-SG-15"
  vpc_id = aws_default_vpc.default.id

  dynamic "ingress" {
    for_each = ["80", "443", "22", "3389"]
    content {
      from_port = ingress.value
      to_port = ingress.value
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Servers-SG-15"
  }
}
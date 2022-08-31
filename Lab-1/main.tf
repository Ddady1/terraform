#--------------
# This is Lab-1
#--------------

provider "aws" {
  region = "eu-west-1" #(If already configured in env it's not necessary here it's hard-coding
  #access_key = "<access key id>" #Not recommended here!!!
  #secret_key = "<secret access key?" #Not recommended here!!!

}
resource "aws_instance" "my_ubuntu" {
  ami           = "ami-0d75513e7706cf2d9"
  instance_type = "t3.micro"
  key_name = "Ddady1-ApacheKey"

  tags = {
    Name = "My-Ubuntu-Server"
    Owner = "David Racha"
    Project = "Phoenix"
  }
}

resource "aws_instance" "my_amazon" {
  ami           = "ami-09e2d756e7d78558d"
  instance_type = "t3.micro"

  tags = {
    Name = "My-AmazonLinux-Server"
    Owner = "David Racha"
  }
}
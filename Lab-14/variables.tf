variable "aws_region" {
  description = "Region where you want to provision this EC2 webserver" // To give the user more info what to enter
  type = string // number, bool // type ot he input
  default = "eu-west-1" // Once given, it won't ask the user for it while applying
}
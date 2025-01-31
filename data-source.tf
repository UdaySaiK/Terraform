data "aws_vpc" "MyVPC" {
  id = "vpc-0c55dbbe4e04b6564"
}

data "aws_subnet" "MySubnet" {
  id = "subnet-045821dacaa626627"
}

data "aws_security_group" "MySG" {
  id = "sg-0381c6312abe0d25a"
}


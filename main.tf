# Configuring the AWS Provider

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  access_key = ""
  secret_key = ""
}


# Creating a VPC

resource "aws_vpc" "MyVPC" {
  cidr_block       = "11.1.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "MyVPC"
  }
}

# Creating an Internet Gateway

resource "aws_internet_gateway" "MyIGW" {
  vpc_id = aws_vpc.MyVPC.id

  tags = {
    Name = "MyIGW"
  }
}


# Creating a Subnet

resource "aws_subnet" "MySubnet" {
  vpc_id     = aws_vpc.MyVPC.id
  cidr_block = "11.1.1.0/24"

  tags = {
    Name = "MySubnet"
  }
}

# Creating a Route Table

resource "aws_route_table" "MyRouteTable" {
  vpc_id = aws_vpc.MyVPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.MyIGW.id
  }

  tags = {
    Name = "MyRouteTable"
  }
}

# Creating RouteTable association

resource "aws_route_table_association" "MyRTA" {
  subnet_id      = aws_subnet.MySubnet.id
  route_table_id = aws_route_table.MyRouteTable.id


}


# Creatiing a Security Group

resource "aws_security_group" "MySG" {
  name        = "MySG"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.MyVPC.id


  ingress {

    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {

    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {
    Name = "MySG"
  }

}

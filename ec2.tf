resource "aws_instance" "myec2-iinstance"{
  ami                         = "ami-04b4f1a9cf54c11d0"
  availability_zone           = "us-east-1a"
  instance_type               = "t2.micro"
  key_name                    = "my-key"
  subnet_id                   = data.aws_subnet.MySubnet.id
  vpc_security_group_ids      = ["${data.aws_security_group.MySG.id}"]
  associate_public_ip_address = true

  tags = {
    Name = "myec2-iinstance"
  }
}
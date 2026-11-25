resource "aws_instance" "terraform_ec2" {
  count         =  2
  ami           = "ami-09bf9dfeeb1e9adbc"
  instance_type = "t2.nano"
  subnet_id     = var.private_subnet
  associate_public_ip_address = false
  vpc_security_group_ids = [var.security_group_id]
  tags = {
    Name = "ec2-tf-0${count.index}"
  }
}


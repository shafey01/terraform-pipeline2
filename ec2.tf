data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id   = aws_subnet.public_1.id
   security_groups = [aws_security_group.public.id]
   key_name = "terra"

  tags = {
    Name = "basiton"
  }

  provisioner "local-exec" {

      command = "echo ${aws_instance.web.public_ip} > ./ansible/inventory"
    
  }
}

resource "aws_instance" "web2" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id   = aws_subnet.private_1___.id
   security_groups = [aws_security_group.public.id]

  tags = {
    Name = "production"
  }

  
}
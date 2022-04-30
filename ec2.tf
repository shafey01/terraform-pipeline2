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


resource "aws_instance" "web2" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id = aws_subnet.public_1.id
  vpc_security_group_ids = ["sg-0ab35918e37a236cc"]
  key_name = "terraformkey"

  tags = {
    Name = "bastion_server"
  }
  provisioner "local-exec" {
      command = "echo ${aws_instance.web2.public_ip} > ./ansible/inventory"

    
  }
}


resource "aws_instance" "web1" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id = aws_subnet.private_1___.id

  tags = {
    Name = "public_instance"
  }
 
}


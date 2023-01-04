resource "aws_key_pair" "web_admin" {
  key_name = "web_admin"
  public_key = file("~/.ssh/web_admin.pub")
}

resource "aws_instance" "bastion" {
 ami = "ami-035233c9da2fabf52"
 instance_type = "t2.micro"
 key_name = aws_key_pair.web_admin.key_name
 subnet_id = aws_subnet.Public-Subnet-A.id
 vpc_security_group_ids = [
 aws_security_group.my_security.id
 ]
}

resource "aws_security_group" "my_security" {
  name = "allow_ssh_from_all"
  description = "Allow SSH allow"
  vpc_id = aws_vpc.my_vpc.id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
 }
}


resource "aws_instance" "web" {
 ami = "ami-035233c9da2fabf52"
 instance_type = "t2.micro"
 key_name = aws_key_pair.web_admin.key_name
 subnet_id = aws_subnet.Private-Subnet-A.id
 vpc_security_group_ids = [
 aws_security_group.my_security1.id
 ]
}

resource "aws_security_group" "my_security1" {
  name = "bastion host to private EC2"
  description = "bastion host to private EC2"
  vpc_id = aws_vpc.my_vpc.id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    security_groups = [aws_security_group.my_security.id]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
 }
}

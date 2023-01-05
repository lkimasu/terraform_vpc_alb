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
 user_data = <<EOF
            #! /bin/bash
            sudo yum update -y
            sudo yum install -y httpd
            sudo systemctl start httpd
            sudo systemctl enable httpd
            echo "<h1>Hello World from $(hostname -f)</h1>" > /var/www/html/index.html
            EOF
}

resource "aws_instance" "web_sub" {
 ami = "ami-035233c9da2fabf52"
 instance_type = "t2.micro"
 key_name = aws_key_pair.web_admin.key_name
 subnet_id = aws_subnet.Private-Subnet-B.id
 vpc_security_group_ids = [
 aws_security_group.my_security1.id
 ]
 user_data = <<EOF
            #!/bin/bash
            # Use this for your user data (script from top to bottom)
            # install httpd (Linux 2 version)
            sudo yum update -y
            sudo yum install -y httpd
            sudo systemctl start httpd
            sudo systemctl enable httpd
            echo "<h1>Hello World from $(hostname -f)</h1>" > /var/www/html/index.html
            EOF
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
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_groups = [aws_security_group.my_alb_security.id]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

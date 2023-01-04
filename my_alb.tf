resource "aws_lb" "my_alb" {
 name = "my-alb"
 internal = false
 load_balancer_type = "application"
 security_groups = [aws_security_group.my_alb_security.id]
 subnets = [aws_subnet.Public-Subnet-A.id,aws_subnet.Public-Subnet-B.id] 
 enable_deletion_protection = true
}

resource "aws_security_group" "my_alb_security"{
 name = "allow alb from 80 port"
 description = "allow alb from 80 port"
 vpc_id = aws_vpc.my_vpc.id
  
 ingress {
   from_port = 80
   to_port = 80
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


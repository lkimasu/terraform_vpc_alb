resource "aws_alb_target_group" "target" {
 name = "my-alb-target"
 port = 80
 protocol = "HTTP"
 vpc_id = aws_vpc.my_vpc.id

 health_check {
  interval = 30
  path = "/index.html"
  healthy_threshold = 3
  unhealthy_threshold = 3
 }
}

resource "aws_alb_target_group_attachment" "privateInstance01" {
  target_group_arn = aws_alb_target_group.target.arn
  target_id = aws_instance.web.id
  port = 80
}

resource "aws_alb_target_group_attachment" "privateInstance02" {
  target_group_arn = aws_alb_target_group.target.arn
  target_id = aws_instance.web_sub.id
  port = 80
}

resource "aws_alb_listener" "listener" {
 load_balancer_arn = aws_alb.my_alb.arn
 port = 80
 protocol = "HTTP"
 
 default_action {
  type = "forward"
  target_group_arn = aws_alb_target_group.target.arn
 }
}



# Create Target Group
resource "aws_lb_target_group" "target-group" {
  health_check {
    interval            = 10
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

  name        = "tf-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = data.aws_vpc.default.id
}

# Create Application Load Balancer
resource "aws_lb" "app-lb" {
  name               = "app-lb"
  internal           = false
  ip_address_type    = "ipv4"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.web_server_sg.id]
  subnets            = data.aws_subnet_ids.subnet.ids
  tags = {
    "Name" = "app_alb"
  }
}

# Create a Listiner
resource "aws_alb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.app-lb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_lb_target_group.target-group.arn
    type             = "forward"
  }
}

# Attaching Target Group to Application Load Balancer
resource "aws_lb_target_group_attachment" "ec2_attach" {
  count            = length(aws_instance.web_server)
  target_group_arn = aws_lb_target_group.target-group.arn
  target_id        = aws_instance.web_server[count.index].id
}

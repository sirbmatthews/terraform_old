provider "aws" {
  region                  = var.region
  shared_credentials_file = var.shared_credentials_file
}

# Create Security Group for EC2 Instances & Load Balance 
resource "aws_security_group" "web_server_sg" {
  name        = "web_server_sg"
  description = "Allow incoming HTTP connections"

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create 2 EC2 Instances
resource "aws_instance" "web_server" {
  ami             = "ami-0afe7f8bc76b877ea"
  instance_type   = "t3.micro"
  count           = 2
  security_groups = [aws_security_group.web_server_sg.name]
  user_data       = <<-EOF
    #!/bin/bash
    sudo su 
    yum update -y 
    yum install httpd -y
    systemctl httpd start
    systemctl enable httpd
    echo -e "<html><h1>You have provisioned an Instance on $(hostname -f)</h1></html>" >> /var/www/html/index.html
    EOF

  tags = {
    Name = "Web-Server-${count.index}"
  }
}

# Default VPC
data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "subnet" {
  vpc_id = data.aws_vpc.default.id
}

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

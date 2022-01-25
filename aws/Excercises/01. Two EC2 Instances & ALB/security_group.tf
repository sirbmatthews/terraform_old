# Create Security Group for EC2 Instances & Load Balance 
resource "aws_security_group" "web_server_sg" {
  name        = "web_server_sg"
  description = "Allow incoming HTTP connections"

  dynamic "ingress" {
    for_each = var.ports
    iterator = port
    content {
      cidr_blocks = ["0.0.0.0/0"]
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
    }
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }
}

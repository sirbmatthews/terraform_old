resource "aws_instance" "web_server" {
  ami             = lookup(var.ami, var.region)
  instance_type   = lookup(var.instance_type, var.region)
  key_name        = lookup(var.key_name, var.region)
  security_groups = ["${aws_security_group.web_server_sg.name}"]

  user_data = <<-EOF
  #!/bin/bash
  sudo su
  yum update -y
  yum install httpd -y
  systemctl start httpd
  systemctl enable httpd
  echo "<html><h1> Welcome to the Demo</h1></html>" >> /var/www/html/index.html
  EOF

  tags = {
    Name = "web_server_instance"
  }
}

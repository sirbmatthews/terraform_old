# Create 2 EC2 Instances
resource "aws_instance" "web_server" {
  ami             = lookup(var.ami, var.region)
  instance_type   = lookup(var.instance_type, var.region)
  count           = 2
  security_groups = [aws_security_group.web_server_sg.name]
  key_name        = lookup(var.key_name, var.region)
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

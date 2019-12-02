provider "aws" {
 region = "us-east-1"
}
resource "aws_instance" "web" {
  ami           = "ami-0b69ea66ff7391e80"
  instance_type = "t2.nano"
  vpc_security_group_ids = ["${aws_security_group.allow_http.id}"]
  user_data = <<-EOF
  #!/bin/bash
  yum install nginx -y
  systemctl start nginx
  systemctl enable nginx
  EOF
  tags = {
    Name = "Nginx-Web"
  }
}
  resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  description = "Allow HTTP inbound traffic"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

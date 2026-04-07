resource "aws_instance" "this" {
  ami                    = "ami-0220d79f3f480ecf5"
  vpc_security_group_ids = [aws_security_group.allow_all.id]
  instance_type          = "t3.micro"
  root_block_device {
    volume_size = 50
    volume_type = "gp3"
  }
  user_data = file("docker.sh")
  tags = {
    Name = "docker"
  }
}
resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow all inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls_u"
  }
}
output "ec2_info" {
  value = aws_instance.this

}
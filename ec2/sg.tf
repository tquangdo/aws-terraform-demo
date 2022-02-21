resource "aws_security_group" "allow_multi" {
  name        = "allow_multi"
  description = "allow multi traffics"
  ingress {
    from_port   = 22 # ssh
    to_port     = 22
    protocol =   "tcp"
    cidr_blocks =  ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80 # http
    to_port     = 80
    protocol =   "tcp"
    cidr_blocks =  ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8080 # http
    to_port     = 8080
    protocol =   "tcp"
    cidr_blocks =  ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
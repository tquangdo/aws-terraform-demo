data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}
# data "aws_ami" "ubuntu" {
#   most_recent = true
#   filter {
#     name   = "name"
#     values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
#   }
#   owners = ["099720109477"]
# }

resource "aws_instance" "example" {
  ami           = data.aws_ami.latest_amazon_linux.id
  # ami           = "ami-2757f631" # ubuntu
  # ami           = data.aws_ami.ubuntu.id
  associate_public_ip_address = true
  instance_type = "t2.micro"
  # user_data = file("scripts/ubuntu_jenkins.sh")
  user_data = file("scripts/linux_apache.sh")
  tags = {
    Name = "DTQEC2LInuxTerraform"
  }
  key_name = "DTQAMILinux20211223"
  security_groups = ["${aws_security_group.allow_multi.name}"] # "split/sg.tf": name = "allow_multi"
}
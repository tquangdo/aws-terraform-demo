resource "aws_instance" "example" {
  ami           = "ami-2757f631"
  instance_type = "t2.micro"
  # key_name = "terraform-key"
  security_groups = ["${aws_security_group.allow_rdp.name}"] # "split/sg.tf": name = "allow_rdp"

}
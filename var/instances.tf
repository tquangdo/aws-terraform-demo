
resource "aws_instance" "example" {
  ami           = "ami-0c64dd618a49aeee8"
  instance_type = var.ec2_type
  count = var.instance_count

tags = {
    Name = "Terraform_demo"
  }
}
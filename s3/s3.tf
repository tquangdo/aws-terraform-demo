resource "aws_s3_bucket" "s3_bucket_name" { 
    bucket = var.var_bucket_name
}

resource "aws_s3_bucket_policy" "default" {
    bucket = aws_s3_bucket.s3_bucket_name.id
    policy = file("policies/bucket_policy.json")
}

resource "null_resource" "default" {
  triggers = {
    bucket_empty   = aws_s3_bucket.s3_bucket_name.bucket
  }
  depends_on = [
    aws_s3_bucket.s3_bucket_name
  ]
  provisioner "local-exec" {
    when = destroy
    command = "aws s3 rm s3://${self.triggers.bucket_empty} --recursive"
  }
}
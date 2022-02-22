output this_aws_iam_role_arn {
  description = "IAMロールのarn値"
  value       = aws_iam_role.this.arn
}

output this_aws_iam_role_name {
  description = "IAMロール名称"
  value       = aws_iam_role.this.name
}
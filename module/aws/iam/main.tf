# 信頼ポリシー：どのサービスに関連付けるか
data aws_iam_policy_document assume_role {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = var.var_principal_service_identifiers
    }
  }
}

# IAMロール
resource aws_iam_role this {
  name               = var.var_role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

# IAMポリシー
resource aws_iam_policy this {
  name   = var.var_policy_name
  policy = var.var_policy
}

# IAMロールとポリシーの紐付け
resource aws_iam_role_policy_attachment this {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.this.arn
}
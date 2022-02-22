variable var_role_name {
  type        = string
  description = "IAMロール名称"
}

variable var_policy_name {
  type        = string
  description = "IAMポリシー名称"
}

variable var_policy {
  type        = string
  description = "ポリシードキュメント"
}

variable var_principal_service_identifiers {
  type        = list(string)
  description = "IAMロールを関連付けるサービス識別子リスト"
}
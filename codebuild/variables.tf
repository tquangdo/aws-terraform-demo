variable "var_codestar_connection" {
	default = "arn:aws:codestar-connections:us-east-1:462123133781:connection/2f45b0d7-576a-4934-b21b-a942fe620473"
}

variable "var_codestar_github_repo" {
	default = "tquangdo/serverless-series-spa"
}

variable "var_codebuild_projname" {
	# default = "DTQCodeBuildProjTerraform"
}

# variable "var_codepipeline_name" {
# 	# default = "DTQPipelineTerraform"
# }

# S3
variable "var_bucket_name" {
	default = "dtq-bucket-terraform-cicd"
}

# AWS IAM Role
variable "var_codebuild_role_name" {
	type        = string
	description = "CodeBuildで使用するIAMロール名称"
	default     = "DTQRoleForCodeBuild"
}

variable "var_codebuild_role_policy_name" {
	type        = string
	description = "CodeBuildで使用するIAMロールのもつポリシー名称"
	default     = "DTQPolicyForCodeBuild"
}
variable "var_codestar_github_repo" {
	default = "https://github.com/mitchellh/packer.git"
}

variable "var_codebuild_projname" {
	description = "Input AWS CodeBuild project name:"
	# default = "DTQCodeBuildProjTerraform"
}

# S3
variable "var_bucket_name" {
	default = "dtq-bucket-terraform-cicd"
}

# AWS IAM Role
variable "var_codebuild_role_name" {
	default     = "DTQRoleForCodeBuild"
}

variable "var_codebuild_role_policy_name" {
	default     = "DTQPolicyForCodeBuild"
}

# AWS Cloudwatch
variable "var_cwatch_grp_name" {
	default     = "dtq-cwatch-loggrp-terraform"
}

variable "var_cwatch_stream_name" {
	default     = "dtq-cwatch-logstream-terraform"
}


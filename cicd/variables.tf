variable "var_codestar_connection" {
	default = "arn:aws:codestar-connections:us-east-1:<AWS_ACCID!!!>:connection/5f3093a2-d850-4ae4-998c-e9c09a95d456"
}

variable "var_codestar_github_repo" {
	default = "tquangdo/serverless-series-spa"
}

variable "var_codebuild_projname" {
	description = "Input AWS CodeBuild project name:"
	default = "DTQCodeBuildProjTerraform"
}

variable "var_codepipeline_name" {
	description = "Input AWS CodePipeline name:"
	# default = "DTQPipelineTerraform"
}

# S3
variable "var_bucket_name" {
	default = "dtq-bucket-terraform-cicd"
}

# AWS IAM Role
variable "var_codebuild_role_name" {
	default     = "DTQRoleForCodeBuild"
}

variable "var_pipeline_role_name" {
	default     = "DTQRoleForPipeline"
}

variable "var_codebuild_role_policy_name" {
	default     = "DTQPolicyForCodeBuild"
}

variable "var_pipeline_policy_name" {
	default     = "DTQPolicyForPipeline"
}

# AWS Cloudwatch
variable "var_cwatch_grp_name" {
	default     = "dtq-cwatch-loggrp-terraform"
}

variable "var_cwatch_stream_name" {
	default     = "dtq-cwatch-logstream-terraform"
}


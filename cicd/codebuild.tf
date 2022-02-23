data "aws_iam_policy" "administrator" {
  arn = "arn:aws:iam::aws:policy/AWSCodeBuildAdminAccess"
}

module "service_role_for_continuous_check" {
  source = "../module/aws/iam"
  var_role_name                     = var.var_codebuild_role_name
  var_policy_name                   = var.var_codebuild_role_policy_name
  var_policy                        = data.aws_iam_policy.administrator.policy
  var_principal_service_identifiers = ["codebuild.amazonaws.com"]
}

resource "aws_codebuild_project" "codebuild_projname" {
  name         = var.var_codebuild_projname
  service_role = module.service_role_for_continuous_check.this_aws_iam_role_arn
  artifacts {
    name      = aws_s3_bucket.s3_bucket_name.bucket
    packaging = "NONE"
    type      = "CODEPIPELINE"
  }
  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:5.0"
    image_pull_credentials_type = "CODEBUILD"
    type                        = "LINUX_CONTAINER"
  }
  logs_config {
    cloudwatch_logs {
      group_name  = var.var_cwatch_grp_name
      stream_name = var.var_cwatch_stream_name
    }
  }
  source {
    git_clone_depth     = 0
    insecure_ssl        = false
    report_build_status = false
    type                = "CODEPIPELINE"
  }
  cache {
    type  = "LOCAL"
    modes = ["LOCAL_CUSTOM_CACHE"]
  }
  # tags = "tags"
}
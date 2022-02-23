data "template_file" "policy" {
  template = file("policies/policy.json")

  vars = {
    tpl_bucket_name_arn = "${aws_s3_bucket.s3_bucket_name.arn}"
  }
}

resource "aws_iam_role" "example" {
  name = var.var_codebuild_role_name

  assume_role_policy = file("policies/role.json")
}

resource "aws_iam_role_policy" "example" {
  name = var.var_codebuild_role_policy_name
  role = aws_iam_role.example.name

  policy = "${data.template_file.policy.rendered}"
}

resource "aws_codebuild_project" "example" {
  name          = var.var_codebuild_projname
  # description   = "test_codebuild_project"
  build_timeout = "5"
  service_role  = aws_iam_role.example.arn

  artifacts {
    # ERR!!!: "Invalid input: when using CodePipeline both sourceType, and artifactType must be set to: CODEPIPELINE"
    # reason: source type="GITHUB" ("CODEPIPELINE" is OK!)
    # name      = aws_s3_bucket.s3_bucket_name.bucket
    # packaging = "NONE"
    # type      = "CODEPIPELINE"
    type = "NO_ARTIFACTS"
  }

  cache {
    type     = "S3"
    location = aws_s3_bucket.s3_bucket_name.bucket
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:5.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"

    environment_variable {
      name  = "SOME_KEY1"
      value = "SOME_VALUE1"
    }

    environment_variable {
      name  = "SOME_KEY2"
      value = "SOME_VALUE2"
      type  = "PARAMETER_STORE"
    }
  }

  logs_config {
    cloudwatch_logs {
      group_name  = var.var_cwatch_grp_name
      stream_name = var.var_cwatch_stream_name
    }

    s3_logs {
      status   = "ENABLED"
      location = "${aws_s3_bucket.s3_bucket_name.id}/build-log"
    }
  }

  source {
    type            = "GITHUB"
    location        = var.var_codestar_github_repo
    git_clone_depth = 1

    git_submodules_config {
      fetch_submodules = true
    }
  }

  source_version = "master"

  # vpc_config {
  #   vpc_id = aws_vpc.example.id
# 
  #   subnets = [
  #     aws_subnet.example1.id,
  #     aws_subnet.example2.id,
  #   ]
# 
  #   security_group_ids = [
  #     aws_security_group.example1.id,
  #     aws_security_group.example2.id,
  #   ]
  # }

  tags = {
    Environment = "DTQ"
  }
}
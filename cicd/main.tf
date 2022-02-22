resource "aws_codepipeline" "default" {
  name     = "click-fe-${var.var_environment}"
  # role_arn = var.var_codepipeline_role_arn
  artifact_store {
    location = var.codepipeline_bucket
    type     = "S3"
  }

  stage {
    name = "Source"
    action {
      name     = "Source"
      category = "Source"
      owner    = "AWS"
      provider = "CodeStarSourceConnection"
      version  = "1"
      output_artifacts = [
        "SourceArtifact"
      ]
      configuration = {
        ConnectionArn    = var.codestar_connection
        FullRepositoryId = var.var_codestar_github_repo
        BranchName       = "main"
      }
    }
  }

  stage {
    name = "Build"
    action {
      name      = "Build"
      category  = "Build"
      owner     = "AWS"
      provider  = "CodeBuild"
      run_order = 1
      version   = "1"
      input_artifacts = [
        "SourceArtifact",
      ]
      output_artifacts = [
        "BuildArtifact",
      ]
      configuration = {
        "EnvironmentVariables" = jsonencode(
          [
            {
              name  = "CLOUDFRONT_DISTRO_ID"
              type  = "PLAINTEXT"
              value = aws_cloudfront_distribution.s3_distribution.id
            },
          ]
        )
        "ProjectName" = aws_codebuild_project.codebuild_projname.name
      }
    }
  }

  stage {
    name = "Deploy"
    action {
      name      = "Deploy"
      category  = "Deploy"
      owner     = "AWS"
      provider  = "S3"
      run_order = 1
      version   = "1"
      input_artifacts = [
        "BuildArtifact",
      ]
      configuration = {
        "BucketName" = var.codepipeline_bucket
        "Extract"    = "true"
      }
    }
  }
  # tags = "tags"
}
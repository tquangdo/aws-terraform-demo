resource "aws_iam_role" "codepipeline_role" {
  name = var.var_pipeline_role_name

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codepipeline.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "codepipeline_policy" {
  name = var.var_pipeline_policy_name
  role = aws_iam_role.codepipeline_role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect":"Allow",
      "Action": [
        "s3:GetObject",
        "s3:GetObjectVersion",
        "s3:GetBucketVersioning",
        "s3:PutObjectAcl",
        "s3:PutObject"
      ],
      "Resource": [
        "${aws_s3_bucket.s3_bucket_name.arn}",
        "${aws_s3_bucket.s3_bucket_name.arn}/*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "codestar-connections:UseConnection"
      ],
      "Resource": "${var.var_codestar_connection}"
    },
    {
      "Effect": "Allow",
      "Action": [
        "codebuild:BatchGetBuilds",
        "codebuild:StartBuild"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_codepipeline" "default" {
  name     = var.var_codepipeline_name
  role_arn = aws_iam_role.codepipeline_role.arn
  artifact_store {
    location = aws_s3_bucket.s3_bucket_name.bucket
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
      # output_artifacts = ["SourceArtifact"]
      output_artifacts = ["source_output"]
      configuration = {
        ConnectionArn    = var.var_codestar_connection
        FullRepositoryId = var.var_codestar_github_repo
        BranchName       = "main"
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"] # ["SourceArtifact"]
      output_artifacts = ["build_output"] # ["BuildArtifact"]
      version          = "1"

      configuration = {
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
      # input_artifacts = ["BuildArtifact"]
      input_artifacts = ["build_output"]
      configuration = {
        "BucketName" = aws_s3_bucket.s3_bucket_name.bucket
        "Extract"    = "true"
      }
    }
  }
  # tags = "tags"
}
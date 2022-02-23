# aws-terraform-demo 🐳

![Stars](https://img.shields.io/github/stars/tquangdo/aws-terraform-demo?color=f05340)
![Issues](https://img.shields.io/github/issues/tquangdo/aws-terraform-demo?color=f05340)
![Forks](https://img.shields.io/github/forks/tquangdo/aws-terraform-demo?color=f05340)
[![Report an issue](https://img.shields.io/badge/Support-Issues-green)](https://github.com/tquangdo/aws-terraform-demo/issues/new)

## reference
[youtube](https://www.youtube.com/watch?v=RA1mNClGYJ4&list=PLQP5dDPLts65J8csDjrGiLH5MZgTyTsDB)

## terraform help
1. ### get
    - Downloads and installs modules needed for the configuration given by PATH.

## install terraform
```shell
terraform -version
->
Terraform v1.1.4
on darwin_amd64
```

## var
1. ### input console
    - create folder=`var` & 3 files "*.tf"
    ```shell
    cd var && terraform init && terraform apply -auto-approve
    ->
    var.ec2_type
        Enter a value: t2.micro

    var.instance_count
        Enter a value: 
    ```
1. ### input param
    - we can call input param in CMD like:
    ```shell
    terraform apply -var 'ec2_type=t2.micro'
    ->
    var.instance_count
        Enter a value: 
    ```
1. ### terraform.tfvars
    - create `terraform.tfvars`
    ```shell
    terraform apply # If *.tfvars has different name from `terraform.tfvars`, we need CMD: terraform apply  -var-file="vars.tfvars"
    -> will NOT prompt GUI input
    terraform destroy
    ```

## ec2
1. ### ubuntu
    ![ubuntu](screenshots/ubuntu.png)
1. ### linux
    ![linux](screenshots/linux.png)

## s3
![s3](screenshots/s3.png)

## codebuild
1. ### use "terraform template_file"
    - `codebuild/main.tf`: `data "template_file" "policy" {...}`
1. ### AWS result (after click "Start build")
    1. #### IAM role & policy
        ![role_policy_cb](screenshots/role_policy_cb.png)
    1. #### codebuild
        ![new_cb1](screenshots/new_cb1.png)
        ---
        ![new_cb2](screenshots/new_cb2.png)
        ---
        ![new_cb3](screenshots/new_cb3.png)
    1. #### S3
        ![new_s3_cb](screenshots/new_s3_cb.png)

## cicd
1. ### reference
    [codepipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codepipeline)
1. ### terraform CLI
    1. #### validate
        ```shell
        cicd$ terraform validate
        => Success! The configuration is valid.
        ```
    1. #### plan
        ```shell
        cicd$ terraform plan -out tform_plan.out
        => 
        var.var_codebuild_projname
            Enter a value: DTQCodeBuildProjTerraform
            ...
        Plan: 5 to add, 0 to change, 0 to destroy.
        Saved the plan to: tform_plan.out
        ```
    1. #### apply
        ```shell
        cicd$ terraform apply tform_plan.out
        => Apply complete! Resources: 5 added, 0 changed, 0 destroyed.
        ```
1. ### AWS result
    1. #### IAM role & policy for codbuild
        > policy is according to `cicd/main.tf > "arn:aws:iam::aws:policy/AWSCodeBuildAdminAccess"`

        ![role_policy](screenshots/role_policy.png)
    1. #### IAM role & policy for pipeline
        ![role_policy_pl](screenshots/role_policy_pl.png)
    1. #### S3
        ![s3_cb](screenshots/s3_cb.png)
    1. #### codebuild
        > `cicd/codebuild.tf` using "module"

        ![cb1](screenshots/cb1.png)
        ---
        ![cb2](screenshots/cb2.png)
    1. #### pipeline
        ![pipeline](screenshots/pipeline.png)

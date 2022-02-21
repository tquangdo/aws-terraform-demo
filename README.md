# aws-terraform-demo 🐳

![Stars](https://img.shields.io/github/stars/tquangdo/aws-terraform-demo?color=f05340)
![Issues](https://img.shields.io/github/issues/tquangdo/aws-terraform-demo?color=f05340)
![Forks](https://img.shields.io/github/forks/tquangdo/aws-terraform-demo?color=f05340)
[![Report an issue](https://img.shields.io/badge/Support-Issues-green)](https://github.com/tquangdo/aws-terraform-demo/issues/new)

## reference
[youtube](https://www.youtube.com/watch?v=RA1mNClGYJ4&list=PLQP5dDPLts65J8csDjrGiLH5MZgTyTsDB)

## install terraform
```shell
terraform -version
->
Terraform v1.1.4
on darwin_amd64
```

## input var
1. ### A)
  - create folder=`var` & 3 files "*.tf"
  ```shell
  cd var && terraform init && terraform apply
  ->
  var.ec2_type
    Enter a value: t2.micro

  var.instance_count
    Enter a value: 
  ```
1. ### B)
  - we can call input param in CMD like:
  ```shell
  terraform apply -var 'ec2_type=t2.micro'
  ->
  var.instance_count
    Enter a value: 
  ```
1. ### C)
  - create `terraform.tfvars`
  ```shell
  terraform apply # If *.tfvars has different name from `terraform.tfvars`, we need CMD: terraform apply  -var-file="vars.tfvars"
  -> will NOT prompt GUI input
  terraform destroy
  ```

## ec2
1. ### ubuntu
  ![ubuntu](screenshots/ubuntu.png)
2. ### linux
  ![linux](screenshots/linux.png)

## s3
![s3](screenshots/s3.png)
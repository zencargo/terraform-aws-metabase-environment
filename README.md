# Live environment for zencargo

All modules we use are in a [separate repository][zencargo-modules].

## Requirements

In order to use this project, you will need

 - [ ] An [AWS account](http://aws.amazon.com) with API access.
 - [ ] Locally configured [AWS credentials][aws-credentials].
   - [ ] setup an AWS profile `zencargo-stage` for stage
   - [ ] setup an AWS profile `zencargo-prod` for prod
 - [ ] Download and install [Terraform][terraform].
 - [ ] Download and install [Terragrunt][terragrunt.io]

## Usage

Each component lives in its own folder in a top level environment folder.
For example the code to provision our staging VPC lives in `stage/vpc`.

```shell
$ terragrunt init
```

This is the first command that should be run after writing a new 
Terraform configuration or cloning an existing one from
version control. It is safe to run this command multiple times.

```shell
$ terragrunt plan
```

Terraform performs a refresh, unless explicitly disabled, and then 
determines what actions are necessary to achieve the desired state 
specified in the configuration files.

```shell
$ terragrunt apply
```

This command is used to apply the changes required to reach the
desired state of the configuration.

## Best practices

* use terragrunt instead of terraform
* have all infrastructure code in the [`infrastructure-modules`][infrastructure-modules] project
* have all environment specific variables in the [`infrastructure-live`][infrastructure-live] project
* use versions to deliver new updates

You can use local modules when trying things out before creating versions

    terragrunt init --terragrunt-source ../../../infrastructure-modules/vpc

## Reading material

* https://davidbegin.github.io/terragrunt/

[terragrunt.io]: https://github.com/gruntwork-io/terragrunt
[terraform]: https://www.terraform.io/downloads.html
[aws-credentials]: http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html#cli-quick-configuration
[zencargo-modules]: https://github.com/zencargo/infrastructure-modules

## FAQ

Q) AWS IAM linked role already exists, how do I import that role?

A) You have to find the iam role in the console and add it under control of terraform like this:

    terragrunt import aws_iam_service_linked_role.elasticbeanstalk arn:aws:iam::123456789012:role/aws-service-role/elasticbeanstalk.amazonaws.com/AWSServiceRoleForElasticBeanstalk

Q) AWS IAM instance profile import

A) same way:

    terragrunt import aws_iam_instance_profile.beanstalk_ec2 app-instance-profile-1

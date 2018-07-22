# Live environment for zencargo

## Usage

It's assumed you have two profiles:

* `zencargo-stage` for all definitions in stage
* `zencargo-prod` for all definitions in prod

This allows you to use your own AWS account to develop and test
infrastructure without impacting the production environment.

## Best practices

* use terragrunt instead of terraform
* have all infrastructure code in the [`infrastructure-modules`][infrastructure-modules] project
* have all environment specific variables in the [`infrastructure-live`][infrastructure-live] project
* use versions to deliver new updates

You can use local modules when trying things out before creating versions

    terragrunt init --terragrunt-source ../../../infrastructure-modules/vpc

## Reading material

* https://davidbegin.github.io/terragrunt/

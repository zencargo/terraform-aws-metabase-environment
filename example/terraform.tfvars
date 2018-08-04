terragrunt = {
  terraform = {
    source = "git@github.com:zencargo/terraform-aws-metabase-environment.git?ref=v1.0.0"
  }

  include = {
    path = "${find_in_parent_folders()}"
  }
}

# Application config
name                = "metabase"
zone_id             = "<ZONE_ID>"
stage               = "stage"
region              = "eu-west-1"

# EB config
description                  = "Metabase data room"
instance_type                = "t2.small"
ec2_key_name                 = "<SSH KEY NAME>"
loadbalancer_certificate_arn = "SSL CERTIFICATE ARN"

# DB config
rds_password                 = "<some-password>"

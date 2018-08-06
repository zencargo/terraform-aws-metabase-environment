terragrunt = {
  terraform = {
    source = "git@github.com:zencargo/terraform-aws-metabase-environment.git?ref=v1.1.1"
  }

  include = {
    path = "${find_in_parent_folders()}"
  }
}

# Application config
name                = "metabase"
description         = "Metabase data room"
stage               = "stage"
region              = "eu-west-1"

# EB config
instance_type       = "t2.small"
ec2_key_name        = "riethmayer@baldr"
cidr_block          = "10.6.0.0/16"

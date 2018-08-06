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
zone_id             = "Z1AHEWIT3RKIBA"
stage               = "stage"
region              = "eu-west-1"

# EB config
description         = "Metabase data room"
instance_type       = "t2.small"
ec2_key_name        = "riethmayer"
loadbalancer_certificate_arn = "arn:aws:acm:eu-west-1:722849216534:certificate/de838717-c5fd-4d8b-810a-cadd54dc6634"

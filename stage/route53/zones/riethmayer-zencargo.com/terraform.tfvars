terragrunt = {
  terraform = {
    source = "git@github.com:zencargo/infrastructure-modules.git//route53_zone?ref=v1.1.0"
  }

  include = {
    path = "${find_in_parent_folders()}"
  }
}

domain_name        = "riethmayer-zencargo.com"
environment        = "stage"
gmail              = false

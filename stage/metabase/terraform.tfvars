terragrunt = {
  terraform = {
    source = "git@github.com:zencargo/infrastructure-modules.git//metabase?ref=v1.1.0"
  }

  dependencies = {
    paths = ["../vpc"]
  }

  include = {
    path = "${find_in_parent_folders()}"
  }
}

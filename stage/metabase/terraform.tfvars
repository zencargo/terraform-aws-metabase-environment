terragrunt = {
  terraform = {
    source = "git::git@github.com:zencargo/infrastructure-modules.git//metabase?ref=v0.0.18"
  }

  dependencies = {
    paths = ["../vpc"]
  }

  include = {
    path = "${find_in_parent_folders()}"
  }
}

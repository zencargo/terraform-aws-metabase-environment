terragrunt = {
  terraform = {
    source = "git::git@github.com:zencargo/infrastructure-modules.git//vpc?ref=v1.0.8"
  }

  include = {
    path = "${find_in_parent_folders()}"
  }
}

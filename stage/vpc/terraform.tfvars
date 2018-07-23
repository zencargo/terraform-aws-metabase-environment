terragrunt = {
  terraform = {
    source = "git::git@github.com:zencargo/infrastructure-modules.git//vpc?ref=v0.0.18"
  }

  include = {
    path = "${find_in_parent_folders()}"
  }
}

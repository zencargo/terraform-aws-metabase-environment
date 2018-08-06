terragrunt = {
  terraform = {
    source = "git::git@github.com:zencargo/infrastructure-modules.git//vpc?ref=v1.2.13"
  }

  include = {
    path = "${find_in_parent_folders()}"
  }
}

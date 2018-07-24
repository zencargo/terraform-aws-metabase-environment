terragrunt = {
  # Configure Terragrunt to automatically store tfstate files in an S3 bucket
  remote_state {
    backend = "s3"
    config {
      encrypt        = true
      bucket         = "722849216534-terraform-state"
      key            = "stage/${path_relative_to_include()}/terraform.tfstate"
      region         = "eu-west-1"
      dynamodb_table = "722849216534-stage-terraform-locks"
      profile        = "zencargo-stage"
    }
  }

  terraform {
    extra_arguments "profile" {
      commands = ["${get_terraform_commands_that_need_vars()}"]
   
      optional_var_files = [
        "${get_tfvars_dir()}/${find_in_parent_folders("common.tfvars", "ignore")}",
        "${get_tfvars_dir()}/${find_in_parent_folders("passwords.tfvars", "ignore")}"
      ]
    }
  }
}

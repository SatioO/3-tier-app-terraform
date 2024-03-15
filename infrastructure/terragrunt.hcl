remote_state {
    backend = "s3"
    generate = {
        path = "state.tf"
        if_exists = "overwrite_terragrunt"
    }

    config = {
        bucket = "accion-terraform-state"
        key= "${path_relative_to_include()}/terraform.tfstate"
        region = "ap-south-1"
        encrypt = true
    }
}

generate "provider" {
    path = "provider.tf"
    if_exists = "overwrite_terragrunt"

    contents = <<EOF
    provider "aws" {
        region = "ap-south-1"
    }
    EOF
}
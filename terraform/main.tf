terraform {
  backend "remote" {
    organization = "learn-terraform-aws-v2"

    workspaces {
      name = "Week-4"
    }
  }
}
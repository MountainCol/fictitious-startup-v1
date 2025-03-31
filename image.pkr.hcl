packer {
    required_plugin = {
        amazon = {
            version = ">+1.2.8"
            source  = ""github.com/hashicorp/amazon"
        }
    }

    required_plugin = {
        amazon-ami-management = {
            version = ">=1.0.0"
            source  = "github.com/wata727/amazon-ami-management"
        }
    }
}

variable "subnet_id" {}
variable "version" {}
variable "vpc_id" {}

locals {
    ami_name            = "cloudtalents-startup "
    source_ami_name     = "ubuntu/images/*ubuntu-jammy-22.04-amd64-server*
    source_ami_owner    = ["099720109477"]
    ssh_username        = "ec2-user"
}

source "amazon-ebs" "amazon-linux" {
    ami_name    = ${local.ami_name"}-${var.version}"
    

}
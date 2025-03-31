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
    source_ami_name     = "ubuntu/images/*ubuntu-jammy-22.04-amd64-server*"
    source_ami_owner    = ["099720109477"]
    ssh_username        = "ec2-user"
}

source "amazon-ebs" "amazon-linux" {
    ami_name            = ${local.ami_name"}-${var.version}"
    instance_type       = "t2.micro"
    region              = "eu-west-1"
    source_ami_filter {
        filters = {
            name                = local.source_ami_name
            root_device_type    = "ebs"
            virtualisation-type = "hmv" 
        }
        most_recent     = true
        owners          = local.source_ami_owners
    }
    ssh_username                = local.ssh.ssh_username    
    vpc_id                      = var.vpc_id
    subnet_id                   = var.subnet_id
    associate_public_ip_address = true
}

build {
    name        = "base_image"
    sources     = [
        "sources.amazon-ebs.amazon-linux
    ]

    provisioner "shell" {
        script = "setup.sh"
    }

    post-processor "amazon-ami-management' {
        regions         = ["eu-west-1]
        identifier      = local.ami_name
        keep_releases   = 2
    }
}

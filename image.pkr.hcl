packer {
    required_plugins = {
        amazon = {
            version = ">=1.2.8"
            source  = "github.com/hashicorp/amazon"
        }
    }
}

variable "subnet_id" {}
variable "version" {}
variable "vpc_id" {}

locals {
    ami_name            = "cloudtalents-startup"
    source_ami_name     = "ubuntu/images/*ubuntu-jammy-22.04-amd64-server-*"
    source_ami_owner    = ["099720109477"]
    ssh_username        = "ubuntu"
}

source "amazon-ebs" "ubuntu" {
    ami_name        = "${local.ami_name}-${var.version}"
    instance_type   = "t2.micro"
    region          = "eu-west-1"
    source_ami_filter {
        filters = {
            name                    = local.source_ami_name
            root-device-type        = "ebs"
            virtualisation-type     = "hmv"
        }
        most_recent     = true
        owners          = local.source_ami_owner
    }
    ssh_username        = local.ssh_username
    vpc_id              = var.vpc_id
    subnet_id           = var.subnet.id
    associate_public_ip_address     = true
    tags = {
        Amazon_AMI_Management_Identifier = local.ami_name
    }
}

build {
    name        = "custom_ami"
    sources     = [
        "source.amazon-ebs.ubuntu"
    ]
    provisioner "file" {
        source =  "./"
        destination = "/tmp" 
    }
    provisioner "shell" {
        inline = [
            "echo Moving files...",
            "sudo mkdir -p /opt/app",
            "sudo mv /tmp/* /opt/app",
            "sudo chmod +x /opt/app/setup.sh"
        ]
    }
    provisioner "shell" {
        script = "setup.sh"
    }
    post-processor "amazon-ami-management" {
        regions         = ["eu-west-1"]
        identifier      = local.ami_name
        keep_releases   = 2
    }

}
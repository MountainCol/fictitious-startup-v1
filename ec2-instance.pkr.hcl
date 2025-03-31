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

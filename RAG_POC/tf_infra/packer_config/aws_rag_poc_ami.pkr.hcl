packer {
    required_version = ">= 1.15.0" 

    required_plugins = {
        amazon {
            version = ">= 1.8.1"
            source = "github.com/hashicorp/amazon"
        }
    }
}
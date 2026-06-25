packer {
  required_version = ">= 1.15.0"

  required_plugins {
    amazon = {
      version = ">= 1.8.1"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "rag_poc" {
  ssh_username  = "ragbuntu"
  ami_name      = "rag_poc_ami"
  instance_type = "t2.micro"
  region        = "eu-central-1"
  source_ami    = "ami-042dc8681de073ac4"
}

build {
  sources = ["source.amazon-ebs.rag_poc"]
  provisioner "file" {
    source      = "./scripts/requirements.txt"
    destination = "/tmp/requirements.txt"
  }

  provisioner "shell" {
    script = "./scripts/bootstrap.sh"
  }
}
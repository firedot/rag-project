packer {
  required_version = ">= 1.15.0"

  required_plugins {
    amazon = {
      version = ">= 1.8.1"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

variable "aws_access_key" {
  type = string
}

variable "aws_secret_key" {
  type      = string
  sensitive = true
}

source "amazon-ebs" "rag_poc" {
  access_key    = var.aws_access_key
  secret_key    = var.aws_secret_key
  ssh_username  = "ubuntu"
  ami_name      = "rag_poc_ami"
  instance_type = "t2.micro"
  region        = "eu-central-1"
  source_ami    = "ami-042dc8681de073ac4"
  skip_create_ami = true
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
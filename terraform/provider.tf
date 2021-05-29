terraform {
  required_version = ">= 0.14"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 3.22.0"
    }
    cloudinit = {
      source = "hashicorp/cloudinit"
      version = ">= 2.1.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

provider "cloudinit" {

}

data "template_cloudinit_config" "config-server" {
  gzip = true
  base64_encode = true

  part {
    filename = var.cloud_config-server
    content_type = "text/x-shellscript"
    content = file(var.cloud_config-server)
  }

  part {
    content_type = "text/cloud-config"
    content = jsonencode({
      write_files = [
        {
          content     = file("apache/index.html")
          path        = "/var/www/html/index.html"
          permissions = "0644"
        },
        {
          content     = file("apache/info.php")
          path        = "/var/www/html/info.php"
          permissions = "0644"
        },
      ]
    })
  }
}

data "template_cloudinit_config" "config-client" {
  gzip = true
  base64_encode = true

  part {
    filename = var.cloud_config-client
    content_type = "text/x-shellscript"
    content = file(var.cloud_config-client)
  }

}

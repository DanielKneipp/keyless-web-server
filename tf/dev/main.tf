terraform {
  required_version = "~> 0.15.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.39.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "server" {
  source = "../modules/server"

  ami           = "ami-0d5eff06f840b45e9" # Amazon Linux 2 us-east-1
  pub_subnet_id = "subnet-002f500f"       # VPC default
}

output "server_ip" {
  value = module.server.server_ip
}

resource "random_id" "habitat_workshop_id" {
  byte_length = 4
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "1.20.0"

  name = "habitat_workshop"
  cidr = "10.0.0.0/16"

  azs = ["us-west-2a"]
  public_subnets  = ["10.0.1.0/24"]

  tags = {
    Name = "${var.aws_sshkey}_${random_id.habitat_workshop_id.hex}_habitat_workshop"
  }
}

module "security_group" {
  source = "terraform-aws-modules/security-group/aws"
  version = "1.20.0"

  name = "habitat_workshop"
  description = "Security group for Habitat Workshop" 
  vpc_id = "${module.vpc.vpc_id}"

  egress_rules = ["all-all"]

  ingress_rules = ["ssh-tcp", "http-8080-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]

  ingress_with_cidr_blocks = [
    {
      from_port   = 8000
      to_port     = 8000
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 8085
      to_port     = 8085
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 9631
      to_port     = 9631
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 9638
      to_port     = 9638
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 9631
      to_port     = 9631
      protocol    = "udp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 9638
      to_port     = 9638
      protocol    = "udp"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  tags { 
    X-Contact = "${var.aws_sshkey}"
    X-Application = "Habitat Workshop"
    X-ManagedBy = "Terraform"
  }

}


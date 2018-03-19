###############################################################################
# Workstations

variable "total_workstations" {
  description = "Total number of student workstations to create"
}

variable "workstation_ami" {
  description = "AWS AMI to be used for the student workstation"
}

variable "workstation_login_password" {
  description = "encrypted password to be used for the 'chef' login account"
  type = "string"
}

###############################################################################
# Global Variables

provider "aws" {
  region = "us-west-2"
}

variable "aws_sshkey" {
  description = "Name of the key in EC2 to be used when logging in as the centos user"
  type = "string"
}

variable "workshop_prefix" {
  type = "string"
}

variable "contact_tag" {
  type = "string"
}

variable "deck_color_1" {
  type = "string"
}

variable "deck_color_2" {
  type = "string"
}

variable "dns_zone" {
  type = "string"
}

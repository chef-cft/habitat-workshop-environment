variable "suit" {}

variable "count" {
  default = "13"
}

variable "color" {
  default = ""
}

variable "contact_tag" {}
variable "aws_sshkey" {}
variable "workshop_prefix" {}
variable "workstation_ami" {}
variable "workstation_login_password" {}
variable "workstation_vpc" {}
variable "workstation_security_group" {}

variable "playing_cards" {
  type = "map"

  default = {
    "0"  = "02"
    "1"  = "03"
    "2"  = "04"
    "3"  = "05"
    "4"  = "06"
    "5"  = "07"
    "6"  = "08"
    "7"  = "09"
    "8"  = "10"
    "9"  = "jack"
    "10" = "queen"
    "11" = "king"
    "12" = "ace"
  }
}

resource "aws_instance" "workstation" {
  count                  = "${var.count}"
  ami                    = "${var.workstation_ami}"
  key_name               = "${var.aws_sshkey}"
  instance_type          = "c5.large"
  subnet_id              = "${var.workstation_vpc}"
  vpc_security_group_ids = ["${var.workstation_security_group}"]

  root_block_device {
    delete_on_termination = true
    volume_size = 20
  }

  connection {
    type = "ssh"
    user = "centos"
    timeout = "2m"
    agent = true
  }

  tags {
    X-Dept    = "Sales"
    X-Contact = "${var.contact_tag}"
    Name = "${var.workshop_prefix}-workshop-station-${var.color}-${var.suit}-${lookup(var.playing_cards, count.index)}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo usermod --password '${var.workstation_login_password}' hab",
      "sudo sed -i.bak 's/^PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config",
      "sudo systemctl restart sshd"
    ]
  }
}
